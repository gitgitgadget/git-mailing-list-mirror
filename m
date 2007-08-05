From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 21:47:57 +0200
Message-ID: <5AB64D44-2324-4A98-B010-8D6D6225F116@zib.de>
References: <20070803125634.GB28323@fieldses.org> <1186318785677-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0708051457110.14781@racer.site> <17AA7EBE-B755-4F26-9C7E-AF6D762811F2@zib.de> <85wswa6n1o.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	David Kastrup <dak@gnu.org>
To: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHm5r-00071X-3r
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbXHETss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbXHETss
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:48:48 -0400
Received: from mailer.zib.de ([130.73.108.11]:50910 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbXHETsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 15:48:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75JltZA012751;
	Sun, 5 Aug 2007 21:47:55 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75JloB2016351
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 21:47:50 +0200 (MEST)
In-Reply-To: <85wswa6n1o.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55064>


On Aug 5, 2007, at 5:03 PM, David Kastrup wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Aug 5, 2007, at 3:58 PM, Johannes Schindelin wrote:
>>
>>> Hi,
>>>
>>> On Sun, 5 Aug 2007, Steffen Prohaska wrote:
>>>
>>>> git gui is especially useful because it allows to select diff  
>>>> hunks.
>>>
>>> You should give a _big_ _fat_ _red_ warning there.
>>>
>>> If you selectively commit diff hunks, you _never_ tested what you
>>> committed.
>>>
>>> That is the reason we're not advertising git add -i more actively.
>>
>> Hmm... If you do 'git cherry-pick' or 'git rebase' you also did
>> not test what you committed. Should we advertise them less
>> actively as well?
>
> Selectively committing diff hunks also means that a subsequent rebase
> -i or git-cherry will have to reconsider the same commit as it has
> only been incompletely applied.
>
> So it can mean more work later.  Also one would in general have to
> edit the commit message (if it describes everything that has been
> done).
>
> There are simply consequences for the workflow if you do things
> right.  Whether they are worth a "big fat red warning" is one
> question, but mentioning them is probably not amiss.

I found it quite useful to be able to commit diff chunks selectively.
I started editing diffs as described in [1] but actually it turned
out to be easier for me to use git gui. I'm speaking unified diff
probably less fluently than Linus does.

My note about using git gui to select diff hunks is added to the
section 'Reordering or selecting from a patch series', which is in
my opinion the right section.

But apparently there's some dispute about usefulness of my comment on
cherry-picking. Maybe a separate section on rewriting changes would
be useful, which I do not have the time to start right now.

Junio, maybe you want to take only the first part of my patch?

	Steffen

[1] http://thread.gmane.org/gmane.comp.version-control.git/46733
