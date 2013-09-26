From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Wed, 25 Sep 2013 21:41:56 -0500
Message-ID: <87a9j0pamj.fsf@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
	<20130925194402.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:42:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1Ww-0006B4-Aw
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab3IZCmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 22:42:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:36296 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab3IZCmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:42:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VP1Wp-00065o-N6
	for git@vger.kernel.org; Thu, 26 Sep 2013 04:42:07 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:42:07 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:42:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:19KVCOiUmbn+JftkDv6E61cDRfQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235398>

Jonathan Nieder <jrnieder@gmail.com> writes:
>> @@ -684,7 +687,7 @@ svn-remote.<name>.noMetadata::
>>  +
>>  This option can only be used for one-shot imports as 'git svn'
>>  will not be able to fetch again without metadata. Additionally,
>> -if you lose your .git/svn/**/.rev_map.* files, 'git svn' will not
>> +if you lose your .git/svn/\*\*/.rev_map.* files, 'git svn' will not
>
> I don't mind seeing this fix snuck into the same commit, but a
> separate commit that could be applied more quickly would be even
> better. ;-)

May I also roll into said commit a couple of replacements of ".git" with
"$GIT_DIR" in the same file, or other such minor touchups?

-Keshav
