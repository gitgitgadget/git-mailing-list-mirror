From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: scissors definition and documentation
Date: Fri, 11 Sep 2009 02:09:19 +0200
Message-ID: <1252627761-1128-1-git-send-email-nicolas.s.dev@gmx.fr>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Cc: Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlthw-0005Rb-Sb
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbZIKAJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 20:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZIKAJe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:09:34 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:49555 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZIKAJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 20:09:34 -0400
Received: by ewy2 with SMTP id 2so647358ewy.17
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=+ro2u4c/KbTp4GJfVQ2E0kFIRJr910wVdEJA3570H+Q=;
        b=KDeTKHsGA3xNh/AICy+ullJwFvPAt12mwaV+l3Cre9tfcBsO52VEFrEOkCVUBwgSPz
         EYTEt5FhJNy84D7WBlvUBjNlPivQcxiJrLfSPKfuQw2Le4BHhxt2sDRRnPa+DtdOBtFw
         4gdTkxjHtqv31X7idi3iollzWjfh1rdhwvllc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=D6QMLLCm8vsreYmRhrUuNA+YVbnIuwOcFhQwiuTU/EJm+3UM47inuYqX7S4GN71szl
         wXokX0G9a+BAkdD+arOCgIibA6w5zNFQEk8IQW5zxrw6w3WBy9t2cZwiZd8tJnOgqV4n
         Hiv7EQb/ev8OQz33a3vSC2ewYClp4CjFsF0Kw=
Received: by 10.210.6.21 with SMTP id 21mr2441368ebf.86.1252627776344;
        Thu, 10 Sep 2009 17:09:36 -0700 (PDT)
Received: from localhost (91-164-133-105.rev.libertysurf.net [91.164.133.105])
        by mx.google.com with ESMTPS id 28sm3401857eye.40.2009.09.10.17.09.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 17:09:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.164.g5f6b0
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128160>

The 07/09/09, Junio C Hamano wrote:
> 
> * jc/mailinfo-scissors (2009-08-26) 5 commits
>   (merged to 'next' on 2009-08-30 at 5fc6248)
>  + mailinfo.scissors: new configuration
>  + am/mailinfo: Disable scissors processing by default
>  + Documentation: describe the scissors mark support of "git am"
>  + Teach mailinfo to ignore everything before -- >8 -- mark
>  + builtin-mailinfo.c: fix confusing internal API to mailinfo()
> 
> I didn't pick up the patch to simplify the definition of scissors. I do
> not have strong opinion on it either way, and nobody on the list seemed to
> care too much either.

Since --scissors is an option instead of the default behaviour, I believe that
the definition of scissors is much less critical.

The following two patches is only about documentation.

The last patch mixes documentation of both mailinfo.scissors and --no--scissors
because I think they are very tied from the user POV.

 [PATCH 1/2] mailinfo: add '--scissors' to usage message
 [PATCH 2/2] add documentation for mailinfo.scissors and '--no-scissors'

---
 Documentation/git-am.txt       |    2 +-
 Documentation/git-mailinfo.txt |    6 ++++++
 builtin-mailinfo.c             |    2 +-
 git-am.sh                      |    1 +
 4 files changed, 9 insertions(+), 2 deletions(-)
