From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GIT Architecture
Date: Sun, 26 May 2013 16:26:05 +0700
Message-ID: <CACsJy8B=Cv4D-FMjHjRkq1ZYc+CZRtO7pqbXjvMZkmvZoUwwng@mail.gmail.com>
References: <BAY162-W48D806F37DF73A07D849C593950@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Rafael_Abra=C3=A3o?= <rafael_abraao@hotmail.com>
X-From: git-owner@vger.kernel.org Sun May 26 11:26:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgXE5-0004oB-Qj
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 11:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616Ab3EZJ0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 May 2013 05:26:38 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:51236 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3EZJ0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 May 2013 05:26:37 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so5913530lbi.37
        for <git@vger.kernel.org>; Sun, 26 May 2013 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AYg93/Axt6nFRUkJL5eEPUSczWlXHNEHUvlivGd8MHA=;
        b=I7gJV4U6IUsE3mZunYlwo9+a5DWLoJfRqOtaDsDZmKN9mXhRRyYgIDRlVcORZG57P2
         GI9wf2rIz4UnvQsrZTxSCIMqaLsmiOWGFYgZpPlOYkcTGZVq/xkxhkkfuN54FgLHD2/3
         UzRQ58+upBH85lSeHqBV8GXufs+4Yme1elK3LRwAuRzGwiLmpvmJvbNcIjU4gYJErZzG
         1YDM6qkvAYnRZlN9p5tC+j4XBPNXnvdP13rbn9TdZcPkHQFkWNOCvtfngvdmXgB2wJ1N
         5R0vKBTuzHJ+mlGM4+onDZLy8Em+nTN9GDSMzatUX4m9N4UCqG47YFAb+NV0tbCAwVr9
         jTaA==
X-Received: by 10.152.28.130 with SMTP id b2mr12267194lah.32.1369560395633;
 Sun, 26 May 2013 02:26:35 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Sun, 26 May 2013 02:26:05 -0700 (PDT)
In-Reply-To: <BAY162-W48D806F37DF73A07D849C593950@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225543>

On Sun, May 26, 2013 at 12:36 PM, Rafael Abra=C3=A3o
<rafael_abraao@hotmail.com> wrote:
> Hello. I=C2=B4m postgraduate student in distributed computing and I'm=
 searching on git.
>
> I would like to know is there any website where I can find the main c=
omponents and connectors of the architecture of GIT. Is there any websi=
te where I can find components-connector view point.

This might be a good starting point: http://www.aosabook.org/en/git.htm=
l

There are some documents in Documentation/technical (in git
repository) but that's not really about architecture. Just dig in the
code and ask here. You could even look at early versions of git where
the code is much simpler.
--
Duy
