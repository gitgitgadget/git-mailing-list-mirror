From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Fri, 09 Dec 2011 05:41:28 -0800 (PST)
Message-ID: <m3zkf1hnh9.fsf@localhost.localdomain>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 14:41:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ0hl-0008Al-Gz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 14:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab1LINld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 08:41:33 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33407 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab1LINlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 08:41:32 -0500
Received: by eekc4 with SMTP id c4so382604eek.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=T4UnJJnQL27Lo2i+yVhBkMjTDZJ51QRaGV1/vKGOlD4=;
        b=cEW376gnCgngQJ4OmZHo21naJKAr1R3fYPclnDNE0xjtzVaJrX0YRshymeaMY8KRcR
         U0LlRti5kEjkjgyf+G79nm9dJowQj7ioh4REibCEGbrPdOcyZuDQpOnCQLrK8zFOCrz4
         UL4SZ7FqyDG+SzbUETBV1gv6zNp0Cl4uAkkYk=
Received: by 10.14.20.9 with SMTP id o9mr887724eeo.28.1323438091002;
        Fri, 09 Dec 2011 05:41:31 -0800 (PST)
Received: from localhost.localdomain (aehn28.neoplus.adsl.tpnet.pl. [79.186.195.28])
        by mx.google.com with ESMTPS id 65sm31238134eeg.8.2011.12.09.05.41.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 05:41:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pB9Depuw019025;
	Fri, 9 Dec 2011 14:40:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pB9DeotQ019022;
	Fri, 9 Dec 2011 14:40:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186634>

Sidney San Mart=EDn <s@sidneysm.com> writes:

> *Nothing else* in my everyday life works this way anymore. Line
> wrapping gets done on the display end in my email client, my web
> browser, my ebook reader entirely automatically, and it adapts to
> the size of the window.

The problem with automatic wrapping on the display is that there could
be parts of commit message that *shouldn't* be wrapped, like code
sample, or URL... and in plain text you don't have a way to separate
flowed from non-flowed part.

Also with long non-breakable identifiers you sometimes need to wrap by
hand (or use linebreaking algorithm from TeX) or go bit over the limit
to make it look nice.

BTW. proper editor used to create commit message can wrap it for you
;-).
--=20
Jakub Nar=EAbski
