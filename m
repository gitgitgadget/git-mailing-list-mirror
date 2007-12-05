From: Sergei Organov <osv@javad.com>
Subject: Re: Put part of working tree on another file-system.
Date: Wed, 05 Dec 2007 20:07:13 +0300
Message-ID: <87ir3d83zy.fsf@osv.gnss.ru>
References: <87mysp8ddk.fsf@osv.gnss.ru> <4756C51C.8080608@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 18:07:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izxit-00018h-MG
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 18:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbXLERHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 12:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbXLERHY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 12:07:24 -0500
Received: from javad.com ([216.122.176.236]:1399 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbXLERHY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 12:07:24 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB5H7JU85454;
	Wed, 5 Dec 2007 17:07:20 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IzxiL-0002lN-ER; Wed, 05 Dec 2007 20:07:13 +0300
In-Reply-To: <4756C51C.8080608@dawes.za.net> (Rogan Dawes's message of "Wed\, 05 Dec 2007 07\:34\:52 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67169>

Rogan Dawes <lists@dawes.za.net> writes:

> Sergei Organov wrote:
>> Hello,
>>
>> I've a desire to put a sub-tree of my working tree into another
>> file-system. With CVS I've used symlink to achieve this. It works fine
>> with CVS as it doesn't care about directories and symlinks at all. I had
>> little hope it will work with GIT, but I've performed a test anyway. To
>> my surprise it almost worked, so I have a hope that maybe it's not that
>> difficult to support this. What do you think? Or maybe there is a
>> different way to achieve the goal with GIT?
>>
>
> I needed to do this in Cygwin, and saw the same behaviour. I worked
> around it by using cygwin's "mount" command to "mount" the other
> directory in Cygwin's namespace. With this done, cygwin does not
> detect a symlink (since there is none), and works as expected.
>
> With sufficient permissions, you can probably achieve the same effect
> with bind mounts perhaps (assuming Linux, of course).

Thanks for the idea, -- it seems to work.

[In fact it is Linux, and those "another file-system" is FAT32 partition,
so that, when rebooting to Windoze, this directory could be accessed from
there. I can't put all the working tree there as there are parts of the
tree that depend on file system being case-sensitive.]

-- 
Sergei.
