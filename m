From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Documentation: Update the style of 'git-describe' 
	command.
Date: Tue, 22 Sep 2009 21:24:58 -0400
Message-ID: <a4c8a6d00909221824u617a9812j11af45b39e06c6d5@mail.gmail.com>
References: <1253663286-5919-1-git-send-email-tfransosi@gmail.com>
	 <7v3a6eo759.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 03:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqGbR-00015I-52
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 03:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZIWBY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2009 21:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbZIWBYz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 21:24:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:53553 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbZIWBYz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2009 21:24:55 -0400
Received: by fxm18 with SMTP id 18so240913fxm.17
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pAEPhYy0ryurz9SNlqAQrTxjG5oIwNA7WccdZkLtn0I=;
        b=rcks4vh9XSh61IomS8J6IUpguLTyCl9RbQ60dpB+eGdyE9d7JW/sJcV2d0PKKGS5F5
         3TYPYgfUAXBgZixTBa2531FvyPCD+aqsWRGFUORO8+s1uZlQpJm0KR0eJCsh7R2aHiN6
         Eh/IV6MCPnbziIE1bEKqR/+HVHZo0tE4sC4d4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=benPErAR1ZyDE7aAb28OajfGPWKVgRI2QEmLGG6IUB+wcpDia23dTR1Ic3QXhmhN0t
         /PPxUIekjnZUz6cRhTCn2yEAhVbvYGhABRx0MKg4zHjJPTIOpZdzvum0bM4cSh7yQvuE
         wHSi6dBanZDj/LHGj0sB/1KkOYoBgr5erk7Vs=
Received: by 10.86.217.8 with SMTP id p8mr1477023fgg.73.1253669098401; Tue, 22 
	Sep 2009 18:24:58 -0700 (PDT)
In-Reply-To: <7v3a6eo759.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128966>

On Tue, Sep 22, 2009 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> =A0$ git describe -h
>> -usage: git-describe [options] <committish>*
>> +usage: git describe [options] <commit-ish>*
>
> I think the first half of this line is correct but the other half is =
not.
>
> $ git grep --color -c -e committish -- Documentation/
> Documentation/git-describe.txt:6
> Documentation/git-fast-import.txt:8
> Documentation/git-name-rev.txt:1
> Documentation/git-shortlog.txt:1
> Documentation/gitcli.txt:1
> Documentation/howto/revert-branch-rebase.txt:1
>
> $ git grep --color -c -e commit-ish -- Documentation/
> Documentation/git-rebase.txt:1
> Documentation/git.txt:2
I did this:
git$ grep --color -n "commit-ish" *.c
builtin-revert.c:29:	"git revert [options] <commit-ish>",
builtin-revert.c:34:	"git cherry-pick [options] <commit-ish>",
builtin-send-pack.c:368:		 * (3) if both new and old are commit-ish,
and new is a
remote.c:1388:	/* Both new and old must be commit-ish and new is descen=
dant of

git$ grep --color -n "committish" *.c
builtin-describe.c:13:	"git describe [options] <committish>*",
builtin-merge.c:885:	 * committish that is the same as HEAD there inste=
ad.
