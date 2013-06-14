From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 18:45:19 +0530
Message-ID: <CALkWK0=dN4oqgvu9FL+EpqyekoQ385tTGbd3Gnf4mee-eTBeOA@mail.gmail.com>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com> <20130614130910.GF23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTrK-0002Ms-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3FNNQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:16:02 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32943 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab3FNNQB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:16:01 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so1392049iej.15
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jNhKJtgoQL0thaR69kvw5xiWFi728YR2FaT8qjXw7zE=;
        b=ekH3tgIV8Y919TJl2GK5Cp3b1tsCs00vOT/yt9omWf7Ry12fUh79nMCbmAP+eYzQRu
         gGmAX2a0Ih0nwoam+k4e9QUKW+qqFX0Y5a9AOtUBzAC9SbwnMZs57Y95eKiAWE5cJReb
         6/ihckUBzXQrGkWxNz4/LhCp4AF7gFA96CYzXrgV4h/PgpMOvmY5hDGVhSOLfc9cuW/V
         PLNohVJcDzMLmA9G4OqX3rCVXipPgpj09vrV6E4rwfDPKSLRDN1VdSXUWXi+4qiwr4uu
         P60tmZynNS7vwD45I/1U4zbMgM2a0Q9j81hFBpi8XjwTI6cveQK/6Qk8Nhj+d6kiUP6P
         9wKQ==
X-Received: by 10.50.18.80 with SMTP id u16mr999785igd.13.1371215760718; Fri,
 14 Jun 2013 06:16:00 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 14 Jun 2013 06:15:19 -0700 (PDT)
In-Reply-To: <20130614130910.GF23890@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227825>

John Keeping wrote:
> I don't think this is the correct behaviour.  I can think of cases where
> I would want to output multiple things into the same directory.

format.cleanOutputDirectory = true|false?
