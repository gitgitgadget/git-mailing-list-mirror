From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sat, 8 Jun 2013 23:32:09 +0530
Message-ID: <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 20:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlNTi-0005wQ-40
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 20:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3FHSCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 14:02:51 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36000 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3FHSCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 14:02:50 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so288312iee.20
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vwNjjtVOzsRPhYEBGo/tpxpmPeQFFZbuu0ZAiiw5hsY=;
        b=Z6T6GOpycwZ1XITrtQ5kjxRnRI9cZ5kkXwpipuwuLd1iDBF95tmVEe/Xv+ZffJ7nnW
         kKvCOHkwZ7OrQeabGZDsQUiIYjJISHQPOxtFEtJ3hYPxo+FYdUsRirzVYXqu0TP7qhQ8
         xbauFY5f3f9/wr6wMQTJMK5UP4jQIyBoqxB1BdLsr5nKe1rIkQgKjvGsd9yeoWoTePab
         bPl/TMO4ZgOOTnOzDlhWp1nC9pTlij7uK/XhCeN/5i0fkxqffn/aK1dqLtzCXl5sBT3d
         /8+exSQVm0acJFOVFhi1evXCUU07slF3TVIbm9IyxGKUfMxeiEN79ow8sTvfAFToab3x
         fXYw==
X-Received: by 10.50.98.104 with SMTP id eh8mr1193638igb.111.1370714569959;
 Sat, 08 Jun 2013 11:02:49 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 11:02:09 -0700 (PDT)
In-Reply-To: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226850>

Felipe Contreras wrote:
> There's no libgit, and there will never be, every object file in Git is
> the same, and there's wish to organize them in any way; they are *all*
> for the 'git' binary and its builtin commands.

Nice joke patch to illustrate your point ;)

On a more serious note, please be a little more patient while everyone
copes with what you're attempting.  I've already made it clear that
I'm in favor of moving forward with your plan to lib'ify git.  The
problem is that you're sending your changes in fragmented comments and
diffs, and nobody is able to piece together what the big picture is.

Please write one cogent email (preferably with code included)
explaining your plan.
