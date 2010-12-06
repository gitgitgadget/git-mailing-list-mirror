From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 6/6] web--browse: look at the BROWSER env var
Date: Mon, 6 Dec 2010 19:28:17 +0100
Message-ID: <AANLkTikEzh2HJEKq-pF8-kfzrjHg4wJcMx3ChP8vEgg9@mail.gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291657790-3719-7-git-send-email-giuseppe.bilotta@gmail.com> <20101206175914.GD6272@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 19:28:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfnp-0001K3-QF
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 19:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab0LFS2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 13:28:40 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41982 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab0LFS2j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 13:28:39 -0500
Received: by iwn9 with SMTP id 9so509143iwn.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3hFpDmVctAaPcemTXsJwPHtb+EPnAaYxhtG2R47MLfE=;
        b=m1a08rbdBx1Q2x+rKkQ8f3c8/f3exq8Eg4oASvvwthgRzqQYCSI1YmFH3CoyQ/2ZB0
         CxbM6U6wBttgPzk5KcP2gve5GxRuBWxnj4sw0oR66aCIwUFW+rr7OdrgbQVHujbQlpkP
         sA0gblqUbtiH0idphy/XnJeTztYCj07u9upHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nx22COsOhKeHfqZhPRpw9CuY74ms4xPJawQaUH+4CWYOwie8lBFeciTRj0yJp6j5yX
         FHieNTaQTAXYp9l0KRc5EhDIX+YpzfjFEK6PwesMv+6D9/ZVS1y0+Eo8ppPwzoDc0E3e
         lauLUoIoVm+/6jpVtoalTivKvUO0/SQJtDaSw=
Received: by 10.231.19.139 with SMTP id a11mr6238717ibb.81.1291660117904; Mon,
 06 Dec 2010 10:28:37 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Mon, 6 Dec 2010 10:28:17 -0800 (PST)
In-Reply-To: <20101206175914.GD6272@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163013>

On Mon, Dec 6, 2010 at 6:59 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Giuseppe Bilotta wrote:
>
>> The BROWSER environment variables is used in Debian-based systems to=
 set
>> the user-preferred browser(s).
>
> I _thought_ BROWSER was not Debian-specific, but I cannot find any
> evidence of that online. =A0See:
>
> =A0http://www.catb.org/~esr/BROWSER/
> =A0http://www.dwheeler.com/browse/secure_browser.html
>
> At least xdg-open implements a variant on it, and I had assumed
> apps preceding xdg-utils did, too.

IIRC, RedHat's sensible-browser equivalent, htmlview, used to use
BROWSER. The package is now obsolete, though, and I'm not even sure it
used BROWSER at all in its latest incarnations.

xdg-open _does_ use BROWSER though. So maybe I should clear the
Debian-specificity of this patch.

--=20
Giuseppe "Oblomov" Bilotta
