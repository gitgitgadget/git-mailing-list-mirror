From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Why does "git config" output nothing instead of the default value
 for unset variables?
Date: Sun, 14 Apr 2013 16:30:00 +0200
Message-ID: <516ABD68.5090501@gmail.com>
References: <kke7o1$oo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 16:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URNwc-00065Z-3p
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 16:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab3DNOaI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Apr 2013 10:30:08 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:40176 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab3DNOaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 10:30:07 -0400
Received: by mail-ea0-f177.google.com with SMTP id q14so1788661eaj.36
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=dycaPgxjMB3CMgHlbzaR1CSfwsc6GLdkwhcx14neGCA=;
        b=cNhGzxUFAmgmcL4rMDw7SjGq7wtlZGd4QchxYXTObYGLq46K5lmZBqu2wBhh0MKO0Q
         WScRQbO8A97J9m8JkBdwRmnp5J+vDLGj3jwQtE77aPLSuLPGMyJ8MwmyhQ5XPipZh2Ys
         PFl0egPzTkxBBxsUijSn6wc7by2NeEwVMWSSO+N9iB94lAlL65UZ0KUXrhUbdBKbyRhZ
         MR9xqg/YKvWzJysIbpm1Vm8ErUICQTD96riKIftrYGMKbiHRqf/iiQXwY8hMEPdowAAA
         5CqyWinBHk47Vy71pZ9Yta3T2cdkZTnGCZOcCA9TT/JGafJMu7y6SOfBd8mWkfjiBgPi
         /tew==
X-Received: by 10.14.107.69 with SMTP id n45mr51312103eeg.23.1365949805366;
        Sun, 14 Apr 2013 07:30:05 -0700 (PDT)
Received: from [192.168.1.14] (dji243.neoplus.adsl.tpnet.pl. [83.23.242.243])
        by mx.google.com with ESMTPS id a41sm21833742eei.4.2013.04.14.07.30.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 07:30:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <kke7o1$oo$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221140>

Sebastian Schuberth wrote:
> Hi,
>=20
> I'm just wondering why it was decided to work like this. IMHO it's qu=
ite
> inconvenient that git config outputs nothing for any unset (but known=
)
> variable. Usually when I query a variable I'm not so much interested =
in
> whether it is at all (explicitly) set to some value or not, but what
> value is currently in use. With that in mind, it would make much more
> sense for git config to print the implicit default value instead of
> nothing if a known variable is unset. For unknown / custom variables =
it
> still could display nothing, which also gives a nice way to check
> whether a given variable name is known to Git or not.

I think git-config was meant to be git agnostic (and therefore usable
outside git, and for files other that git config files).

It would be better to add required functionality to git-var, IMHO.

--=20
Jakub Nar=C4=99bski
