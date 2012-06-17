From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git commit-tree documentation incorrect parameter sequence
Date: Sun, 17 Jun 2012 09:57:42 +0800
Message-ID: <CAHtLG6S3ZyBV+0KxKLUSCO7yOXLGD1NGhM62sJfKPUMSeQTSoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 03:57:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sg4kO-0000vi-HH
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 03:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab2FQB5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jun 2012 21:57:44 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43802 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753535Ab2FQB5n convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2012 21:57:43 -0400
Received: by lahd3 with SMTP id d3so2840859lah.19
        for <git@vger.kernel.org>; Sat, 16 Jun 2012 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hMayhjGK0Czs1aAgL44kxzQh1UdAOEJjZtmnHv9NnZQ=;
        b=Fm1ZPQLFoumbOEvFcvQomVbsuq39A1V34yyWqzwQw7oiwMl/d7WoTUr6HxtA3fvsRl
         1OQASs734UreQNpTfwz/fahWkBCizt609eZJwfqIjeIcwyxT7+y408gjUAPVGa1C8CaF
         vjK2WcPS1pjotHilOUndP8Kdub/d7tOuur3BhKFK6TPlQg08nWW2lIKwwI4lgm4/ENhI
         4hJjSMZG+E7QdCntzT76Oewkupam0VzQDJ/GPIvHwwFkqJvwRRiFKPf8LRuxZ0WpG4Ji
         MRK1ofv/+4keKPzyk6zyop1b0ft8A0AO7DwoAKMu55zfzBVOnLevKBzH8PI5p0dBkien
         yq7A==
Received: by 10.112.30.226 with SMTP id v2mr4499721lbh.103.1339898262342; Sat,
 16 Jun 2012 18:57:42 -0700 (PDT)
Received: by 10.112.42.72 with HTTP; Sat, 16 Jun 2012 18:57:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200115>

Dear Sir,

In current git commit-tree documentation,
the parameter sequence is incorrect.

git commit-tree <tree> [(-p <parent>)=85] < changelog
git commit-tree [(-p <parent>)=85] [(-m <message>)=85] [(-F <file>)=85]=
 <tree>

The second line in incorrect, and <tree> should come first
git commit-tree <tree> [(-p <parent>)=85] [(-m <message>)=85] [(-F <fil=
e>)=85]

Regards,
ch3cooli
