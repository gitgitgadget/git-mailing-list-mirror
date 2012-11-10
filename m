From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: t9350-fast-export.sh broken on peff/pu under Mac OS X
Date: Sat, 10 Nov 2012 20:17:30 +0100
Message-ID: <CAMP44s2sKL4CJ_wcM7U9mYPX6bkaQA8hgDM6Z0QEj2TACh-8DQ@mail.gmail.com>
References: <509E66B0.3040308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGYp-0007Dg-UW
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab2KJTRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 14:17:32 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59852 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2KJTRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 14:17:30 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5087302obb.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=E0jbPzEu6Tcwuem13AhvbFQurNDLKiPBwl98tlSnnEs=;
        b=jGW60jKV5SwIvGYZbnjieHRPrs4etBNb457spkXS9of+ShofbXGQVLN7cUum4cKoG6
         ZHp813ZTUYFo0mcZoRXSuM+He32BFsuj4j4pVDdtkG37bTszcYQwAIY4BWQBJ2iUQ40t
         12ofqAO5LFbTfOHzg/r2iLTQ8q6ziBjnMaamWOgXKpFh2OA58DpuX1pW0TZ2uxxwltrg
         3A2cTOHuDevIOWkNkM4JhaUhqAUUBMSvcnFhljROODoiY1nr0D93OT2Jvd4GSePmpdkw
         6hGQVj0Xh4xzXlaHgcEzJ2Mnrma+WFMzfiyVWdQs/O8dFE915m7fMQb1yLixW23z+jSn
         dI2A==
Received: by 10.60.12.225 with SMTP id b1mr11073123oec.96.1352575050091; Sat,
 10 Nov 2012 11:17:30 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 11:17:30 -0800 (PST)
In-Reply-To: <509E66B0.3040308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209296>

On Sat, Nov 10, 2012 at 3:37 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> The short version:
> echo -n doesn't seem to be portable.
> The following works for me:

Right, I was supposed to change that to:

  true > marks-cur &&

I don't think the code below works everywhere.

> (And is this a typo: test_expect_success 'test biridectionality' ')

Right, thanks.

>  diff ../../git.peff/t/t9350-fast-export.sh t9350-fast-export.sh

Please use diff -u, I think everybody is more familiar with that.

Cheers.

--=20
=46elipe Contreras
