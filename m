From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 11/44] ruby: request-pull: rewrite perl script
Date: Sun, 29 Sep 2013 10:34:07 +0530
Message-ID: <CALkWK0nVHRV40VOBwtRnVsDcCpgZNQ-XtwL1syABE9ED30wuiA@mail.gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com> <1380405849-13000-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 29 07:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ9Bn-00082d-C4
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 07:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab3I2FEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 01:04:49 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:46549 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3I2FEs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 01:04:48 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so7280733ieb.23
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 22:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OUFpKwI+g2tMlhEy0Ar1j0ClfUeTyUl18FNV14CWs4M=;
        b=XRnDIh06yXMAqrfjnLGhRSG65Z1I4VyZvDyjbZ1sXUBgEzWtlTD2vEaKupDt53zGxO
         GKUtUON0l0Ne8WHjHENscJvm4f5symXteBoxKo4WkHaO5XfB6qGfO1SbbxRDCyaBGFrD
         uwF0guy0N/QVXfzkxEPfvH6mHlrjQfeIRwFOH6WVh5fpi0XNe4WqIrmvyQFnKR1mYytp
         r/81uln4tneGHGzrNEHFP8N092GSO8n0rR3Cy3eeuZ9SQ3ywUyEw6j1j/aAMBNTZgVBO
         zciEvIxG2Bs596OrwoMmAzMdctM1Wi3GmYuavUm+gCA2aCS2yUS4iiDwajciZX/XXiLT
         qnKA==
X-Received: by 10.42.189.201 with SMTP id df9mr3530icb.54.1380431087660; Sat,
 28 Sep 2013 22:04:47 -0700 (PDT)
Received: by 10.64.73.36 with HTTP; Sat, 28 Sep 2013 22:04:07 -0700 (PDT)
In-Reply-To: <1380405849-13000-12-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235587>

Felipe Contreras wrote:
>  git-request-pull.rb | 65 +++++++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 35 deletions(-)

Arguably, more pretty and terse. Again, all tests pass.

Looks reasonable.
