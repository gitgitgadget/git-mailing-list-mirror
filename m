From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Allow cloning branches selectively
Date: Sat, 24 Dec 2011 11:31:51 +0700
Message-ID: <CACsJy8ANZvkY+na-tM95prHEfXD+N2OT8+3NLeccycGL1BmbCg@mail.gmail.com>
References: <1324671199-7074-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Dec 24 05:32:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReJHY-0001lF-7f
	for gcvg-git-2@lo.gmane.org; Sat, 24 Dec 2011 05:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab1LXEcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Dec 2011 23:32:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42392 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab1LXEcX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Dec 2011 23:32:23 -0500
Received: by eaad14 with SMTP id d14so3160461eaa.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 20:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UZasZLAfHhf4Uq8d2cjytydzx6cvcwiZDN3D3Sorn+M=;
        b=W/dsNasJSeaQzByq8GdZi+vo05zxXFYTUel0KYqssr3nHqU8kYqYSxkm1+1EtdIupf
         opQCBYf2gP0xyRN8pSvjvG+6z+nWjhelVtFpGJAKa2QSxOGD4Pe5qEdNqdIiCxFS6EW/
         7E+1OqUBPnaTZ6m3+TCtHbGGzvIm0VHI7erhE=
Received: by 10.204.145.74 with SMTP id c10mr4771343bkv.62.1324701142231; Fri,
 23 Dec 2011 20:32:22 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Fri, 23 Dec 2011 20:31:51 -0800 (PST)
In-Reply-To: <1324671199-7074-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187652>

On Sat, Dec 24, 2011 at 3:13 AM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> Sometimes it's useful to clone only a subset of branches from a remot=
e
> we're cloning. Teach clone the --fetch option to select which branche=
s
> should get fetched.

What about tags? Are all tags fetched or only ones part of the
selected branches?
--=20
Duy
