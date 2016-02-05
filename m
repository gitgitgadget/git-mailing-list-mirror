From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/8] upload-pack: new capability to pass --skip* to
 pack-objects
Date: Fri, 5 Feb 2016 10:18:38 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602051017210.2964@virtualbox>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com> <1454662677-15137-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-933935907-1454663918=:2964"
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 10:18:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcXU-00066U-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 10:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbcBEJSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 04:18:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:62377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbcBEJSl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 04:18:41 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LgptO-1ZeneK3f4o-00oEUF; Fri, 05 Feb 2016 10:18:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1454662677-15137-5-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xZNbZFAsRk6VoaWxSuJfvfkHpuzXnT7VpsEGzvnySzhYy4VIGLd
 5Eq1GxgGsGKYrZhIaYhPEpbp3UUWByrHyvweaKuffe1mJyHUY3G/fWtlb6bCNFkO+iD+ops
 bMU74gEOrLd9hJaifvSlFIr5Xy11zxe9FNi4Cyq8xRa/M5265qS13GQo2P155ml19KOWuDw
 veR6AnH/NoBpRtDKZboXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QSRZgVb4e6c=:dsr5PFDh/oYNe0njZbJkIg
 lNagDRyiDbKllj7rO/Au52/JgZOH1IjCGInwhBkuHiGM6srT9cEx+fNtUyrYtSMEVj/4ofPPC
 uVIUrru5vlbv3G4GDkmZ6O2PxW4Jqq0K5nQV8UQDssOXjLJjLihXQzO1RZ0A1iP3PEQatOtfF
 RtprrsJhCYQvP+m41i5wFsFQE6eZSVCiQ3zx08VZx4VX8hZH5Zn0infUE+tMB0cC73ujt5D7C
 +c3Z3lY4+xRanoHVq4FwjDBuj4eJBaXvSoYSKKHxhQUVka5AKWzdI+ntHdRgd7InnjYrxKPv4
 v6/VJb1PLcZ/IePRqE0YyfJzkD2R7VbyY+Z+zlEnzv/F52Z1LTG1QFr3PibJSrMEeURpwEBuj
 VswTnxAZ+5lrl+E41O3lMsXzBbdH7lMdhwZQgx+rnLOfrw+H5z9gd5r1BL9VKf+8rG+spzw9T
 EN42dfoLhKXJDHwJnb8V6yRXvVMgluwbB2N2n2/CDMowxKN++6k7u7SEC+3i4vk/Ht+yaVDlu
 Vg97SiO79+DtPAjwbWCbaCuSkWo0NllY5yzkJvoz7GDtIctw0yOCIKCXIb2V2tHl/3tYbkF9C
 K2OGUb7UnL48/qzidaaUh5u79PMCR+97SA8pH0/0noXxcZCPwuXeDv42SdKV0ZeWgJkhAxlv3
 PuYEA1YiX6Wws+r0/LK/E3+2TH6iCZudjrGwXoeWZhoN+xtM8GPgTLbk7VuoPLwZvaw1qg3zn
 1m9VhSlE2vUp12r8dT6imEoa+c14EXrV577iKJR6r/73DVz3dwTT5YtsvOy64k/A8zq+5y4l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285565>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-933935907-1454663918=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Fri, 5 Feb 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> [... empty commit message body...]
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>
> [...]
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Document=
ation/technical/protocol-capabilities.txt
> index eaab6b4..0567970 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -275,3 +275,12 @@ to accept a signed push certificate, and asks the <n=
once> to be
>  included in the push certificate.  A send-pack client MUST NOT
>  send a push-cert packet unless the receive-pack server advertises
>  this capability.
> +
> +partial
> +------
> +
> +This capability adds "skip" line to the protocol, which passes --skip
> +and --skip-hash to pack-objects. When "skip" line is present, given
> +the same set of input from the client (e.g. have, want and shallow
> +lines, "skip" line excluded), the exact same pack must be produced.
> +

Would you care to elaborate on this idea a bit more? The commit message
would make an excellent place for describing the underlying idea, as well
as comparing it to the alternatives.

Ciao,
Dscho
--8323329-933935907-1454663918=:2964--
