From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/7] completion: add tests for invalid variable name among
 completion words
Date: Sun, 18 Nov 2012 09:34:02 +0100
Message-ID: <CAMP44s1-YS_39KfFoRG_K-xvw+iu0_B097bv3kTv=3S2QWwaZA@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-5-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:34:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0KY-0003cv-Vg
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 09:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab2KRIeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 03:34:04 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60978 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2KRIeD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 03:34:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so4026777obb.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 00:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8S6F4EWhpEZMgtDcDlWVXvQHJqAmhF9l3AKQ/XUwqko=;
        b=RuccQbjnHDydla+w2PWOWlsHZOvwJ9CgN8uqUs2lDfi31pHUGFoQUOvQbiO8VUhHHl
         wPWRg18+uE7eehPH+UeMbzsUnAAt3D3/xfY85mO/tsiCDGEyykTpKwB6PXkR6HDAuE0/
         OiICNb7EFd4SwjY1OWjxAA6YztNcbHNSJQG8QBQDfzkdObBhD/F4NH0E1aKcw322rFsm
         V1Xv2eCb1PdO5PyRL1VWtBrEK4vG4kioBJMpesG1YJaDRgZykLZzEUQ+X8+PBPf30HM/
         NYOrVyUIBkqE8xioxHMwZpdGOZDGgGEuY0RcFBjVU4chlsqvOGZOUMcu3bIcZbXyT/nO
         yUXA==
Received: by 10.60.31.241 with SMTP id d17mr7809739oei.107.1353227642511; Sun,
 18 Nov 2012 00:34:02 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 00:34:02 -0800 (PST)
In-Reply-To: <1353150353-29874-5-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209993>

On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

> @@ -155,6 +156,12 @@ test_expect_success '__gitcomp - suffix' '
>         test_cmp expected out
>  '
>
> +test_expect_failure '__gitcomp - doesnt fail because of invalid vari=
able name' '
> +       (
> +               __gitcomp "$invalid_variable_name"
> +       )
> +'

Why in a subshell?

--=20
=46elipe Contreras
