From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: contrib/mw-to-git/Git/Mediawiki.pm
Date: Thu, 27 Jun 2013 18:25:38 +0200
Message-ID: <CAETqRCgctnVqrYaAYn7uZtv0rvQNawUAi513iTeWPufkZPRgAw@mail.gmail.com>
References: <51CC6189.6030701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 27 18:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsF0y-0003p1-IK
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 18:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab3F0QZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 12:25:40 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:33145 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab3F0QZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 12:25:40 -0400
Received: by mail-we0-f182.google.com with SMTP id p60so752303wes.27
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=vEHzpN0WdReN9czyKNGxo5JlnCVWBRsQTWAJ+2COp9I=;
        b=wWuOrx/QZuJ0x0QDbjXe+KG18GXGAeRfJtFLmooVbuP5Uo4EVDT4m72CfcN19NPOW7
         UdjuZT65MigYXQ6UIgElDgfMlBiYe8ul53V06p04ejyGNq1vk9sPVmLcy0XDwbTM+xku
         BGUCvlycHkNQJDKrx/E1MX7kTKobx/dgvcKnHHy8b8k9WGI3dIQa36t0OmgsdozbG2fv
         d64EGq1aiI7PNbAFp1KRcJi1CJerFLZpAG2P6sv5SWFhKW9VIbLCzv/FIvKQUicMUS4I
         iB82NfsScsbl63bmBC0CgK/oF9U35Z26qKsmyxYgJoAZeLBgX62pjcL/irnBtfcBtm0i
         31Pw==
X-Received: by 10.180.91.107 with SMTP id cd11mr6527605wib.12.1372350338991;
 Thu, 27 Jun 2013 09:25:38 -0700 (PDT)
Received: by 10.216.245.196 with HTTP; Thu, 27 Jun 2013 09:25:38 -0700 (PDT)
In-Reply-To: <51CC6189.6030701@web.de>
X-Google-Sender-Auth: d2DpX8aGBDna8KZY4VKUhtn9dXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229115>

Oops, so sorry :/

It's defintely doable since the lowercase 'git' is only a bin-wrapper
for git to ease development in contrib/mw-to-git/ .

Junio, Matthieu : should I resend a new version of my serie which
renames the 'git' (lowercase) file into something like 'git-dev' ?
(some comments directly mentionning the 'git' (lowercase) file needs
to be updated as well in the Makefile)

Benoit
