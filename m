From: Joseph Leong <josephcleong@gmail.com>
Subject: Gitweb characters not encoded/decoded properly
Date: Mon, 10 Sep 2012 10:57:58 -0700
Message-ID: <CAMOg_eWBvkLFa7AB+cW-qTq8Z7_XmOsFWeB5KkwZHbF4d53ihg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 19:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB8FN-0008BT-4M
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab2IJR6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Sep 2012 13:58:00 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55488 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab2IJR57 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 13:57:59 -0400
Received: by vbbff1 with SMTP id ff1so2982585vbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8WsGWDTdAGAGEq2I1ZhbthoSJ5dAourhVuHdJ5wGlKQ=;
        b=zuokEsP+dRDUY8ZhrCKCFpmMe6j0xUKIT1Pmvfso5EXalT4TCsG3+OfWeyYgHubOPk
         dbe9y+gcTLpSX0MRY0TD5Y9gmP/F/gmd98lmYAX6/JI07wWG+ay8SDUfzhKwYIqYoaom
         Zl8HSmBqmXOcBSTbNKuK1xNbZkcl7Bw7zPkVW2GhENckjJdS+pTqaSj7Pe4Ls9iSJy3y
         3uQv9EfCfpKWbkewqvqFyJVyiFSqefQYypMzUqV1ZZXlONNEG7jg29qPJOie2td1d5Hj
         Yb420+SNpKIXvDfn8z2JJKc9p35fxCIMzx+goO2Q3qMSgRt+LhjwwfqNSw28siSd4f5j
         sgVA==
Received: by 10.52.88.19 with SMTP id bc19mr16969981vdb.39.1347299878498; Mon,
 10 Sep 2012 10:57:58 -0700 (PDT)
Received: by 10.220.207.220 with HTTP; Mon, 10 Sep 2012 10:57:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205156>

Hi Everyone,

I've noticed an issue in gitweb where git projects are created with
characters such as:
=E2=82=AC=E9=85=AE=D8=AE=D8=AF=E3=90=81=E1=A0=A1=EA=80=88=E0=BC=91=E3=98=
=9A.git

But in the gitweb page content, URL section,  a git project is
rendered incorrectly?

Example screenshot:
http://i.imgur.com/06skV.png


Thanks for your help!
