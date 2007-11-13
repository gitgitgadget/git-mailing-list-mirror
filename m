From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 19:39:39 +0100
Message-ID: <6D2FF44E-5D45-4341-B863-1C33C104D3EA@zib.de>
References: <874pfq9q8s.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de> <200711131842.03622.jnareb@gmail.com> <87d4ue81tv.fsf@osv.gnss.ru>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "<osv@javad.com>" <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is0ex-0000cx-TD
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 19:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbXKMSi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 13:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbXKMSi1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 13:38:27 -0500
Received: from mailer.zib.de ([130.73.108.11]:33863 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbXKMSi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 13:38:27 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lADIcNZb027464;
	Tue, 13 Nov 2007 19:38:23 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lADIcM9R020771
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 13 Nov 2007 19:38:22 +0100 (MET)
In-Reply-To: <87d4ue81tv.fsf@osv.gnss.ru>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64823>


On Nov 13, 2007, at 6:58 PM, <osv@javad.com> <osv@javad.com> wrote:

>>>> So I'm not sure if it is a bug, misfeature or a feature.
>>>
>>> It doesn't make sense to delete remote-tracking branches
>>> locally if they are still present at the remote.  The main
>>> purpose of a remote-tracking branch is to be identical to the
>>> real remote branch.
>>
>> True, but it would be nice to have an option to _exclude_ some
>> branches from fetching (for example 'html' and 'man' branches
>> of git.git), while still picking up new branches automatically
>> on fetch.
>
> Guys, could you please read man git-branch? What do you think this
> example is doing?:
>
> <quote Documentation/git-branch.txt>
> Delete unneeded branch::
> +
> ------------
> $ git clone git://git.kernel.org/.../git.git my.git
> $ cd my.git
> $ git branch -d -r origin/todo origin/html origin/man   <1>
> $ git branch -D test                                    <2>
> ------------
> +
> <1> Delete remote-tracking branches "todo", "html", "man"
> </quote>
>
> That's *exactly* what I did! And it *doesn't work*! Well, it does  
> delete
> the branches, but they are automagically re-created on the next fetch,
> so "deleting" them this way is useless.

Yes, it is useless. The man page should be fixed.

	Steffen
