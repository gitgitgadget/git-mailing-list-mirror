From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/5] teach config --blob option to parse config from database
Date: Thu, 9 May 2013 14:23:45 -0400
Message-ID: <CAPig+cQDz9Pzao+9LJ1jW_=x-iL7e_7GE3=6uBfCY6Ezq48mYg@mail.gmail.com>
References: <20130509154020.GA26423@book-mint>
	<20130509162018.GF3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu May 09 20:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaVVQ-0008VF-2p
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 20:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab3EISXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 14:23:47 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:57365 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab3EISXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 14:23:47 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so3135722lab.4
        for <git@vger.kernel.org>; Thu, 09 May 2013 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=f+LJZgBoEYYmZbMlS5dVecHAdtW7Ly2TLv/jWn8upt4=;
        b=d7bvPlOCRn/9VI+1YWPVvYHzZV7xBdLkIOkOA/AYE02Wvy5oeq97s2hqFOM/+DVTzM
         pn2RVqngkdGdILm7xisSXi1VGX4Cf315LO9d/FZsmUnkfbrBh0gHEDB/fAqumu8Zv0hK
         afMIU1dbJxZ+gv6+IxVggfXk+Lf9Xv4KifNeG3kuoblXKwERlXHrqOTrXrYo8EJDVXAD
         rEWBqbgluSFJJgPdnBlFBORnLYCQEPNBvIyjCgaiYbrvuUYYgjvEpKcUJodmIm15yrhw
         6LjZXJVg1btqSJRaeDtf7A8bmkQkhXlsD8SfHMco3jZQipD5gd7IWgNxE3vYSFB3npsp
         Zgkw==
X-Received: by 10.112.137.9 with SMTP id qe9mr5962575lbb.64.1368123825599;
 Thu, 09 May 2013 11:23:45 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Thu, 9 May 2013 11:23:45 -0700 (PDT)
In-Reply-To: <20130509162018.GF3526@book-mint>
X-Google-Sender-Auth: SMCeW-UjLz5A-J9hQ2kGStk2Nmc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223767>

On Thu, May 9, 2013 at 12:20 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> This can be used to read configuration values directly from gits

s/gits/git's/

> database. For example it is useful for reading to be checked out
> .gitmodules files directly from the database.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
