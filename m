From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] git-svn.txt: mention how to rebuild rev_map files
Date: Wed, 25 Sep 2013 21:21:47 -0500
Message-ID: <87mwn0pbk4.fsf@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
	<20130925194402.GA9464@google.com> <874n98qxqx.fsf@gmail.com>
	<20130926000648.GE9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 04:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP1DZ-0006hf-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 04:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab3IZCWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 22:22:04 -0400
Received: from plane.gmane.org ([80.91.229.3]:50675 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab3IZCWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 22:22:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VP1DL-0006Xe-TV
	for git@vger.kernel.org; Thu, 26 Sep 2013 04:21:59 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:21:59 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 04:21:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:/ntLiLzQQMZ1kfh6oDNK6fKUMxo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235386>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Keshav Kini wrote:
>
>> I changed the wording of your first paragraph a bit according to what I
>> thought it meant. Does it still convey what you wanted to convey, and is
>> it still correct?
>>
>>         Mapping between Subversion revision numbers and Git commit
>>         names.  In a repository where the noMetadata option is not set,
>>         this can be rebuilt from the git-svn-id: lines that are at the
>>         end of every commit (see the 'svn.noMetadata' section above for
>>         details).
>
> Sounds good.
>
>> Also, I'm having a bit of trouble trying to get a definition to start
>> with a '.' character in AsciiDoc.  Escaping the '.' produces a
>> definition block, but with a literal '\' before the '.'.  If I don't
>> escape the '.', asciidoc thinks it's a section heading or something. Is
>> asciidoc just incapable of doing this, or am I missing something?
>
> Oh.  Yeah, this can be a pain.  Quoting the filename with `backticks`
> might work.  Writing $GIT_DIR instead of .git might be simpler (see
> v1.5.3.2~18 "Documentation/git-config.txt: AsciiDoc tweak to avoid
> leading dot", 2007-09-14).

Good point.  Actually it seems to me that writing $GIT_DIR is in fact
more correct, since $GIT_DIR need not be ".git" at all.  So I'll just
use that.  Reroll coming up in a bit.

-Keshav
