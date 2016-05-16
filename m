From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push --quiet option does not seem to work
Date: Mon, 16 May 2016 15:28:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605161526510.3303@virtualbox>
References: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com> <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com> <20160515212332.GB31809@sigill.intra.peff.net> <CADKp0pzPOdcSfBESzGMhrY5itSa4KDeOQ2VgwewuwH8CGZcwCw@mail.gmail.com>
 <20160516005824.GA1963@sigill.intra.peff.net> <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris B <chris.blaszczynski@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 15:28:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2IZh-0006oG-Sm
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 15:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbcEPN2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 09:28:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:58255 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbcEPN2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 09:28:40 -0400
Received: from virtualbox ([88.128.80.193]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjLwB-1baWn73X4h-00dW0F; Mon, 16 May 2016 15:28:27
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CADKp0pzOLs5g9Jc6_sA6jr-XOifx0Yn6b7wDW2qcC2UB5Q_WPQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XxIFL1GND1L3tEJOjcRFpgKgPjVtE+pN6m31kW1nv5WOaMfyhFz
 cZ+uNZx+M6Qy0abZ7f/fOT8yfn0KiF+xhKESOi39eAeeZ36WytJCGGIJvV9dp8EasIFOpBO
 +zUMr/WwoDeVA+LtYnaOzqIKhGJtzDoRYMKr9lYKFuIzoKx2sPQuZUxzhE1r4I8T8i2LjAD
 uY8KFYbogfofhCFFg54VA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZKhCb+JTWCU=:ep6klCQlaPArvjGPYwbQEH
 Axd9cPegCiMZVzwyZzknIEAjwhXak587YR0JgXVpAzpPqciZJI5/Hk6gea146vTR1NqhmUp3K
 RRlLAqj+YYpMl3jTT8mG0oDCdik8Kf40QlD1FRAnshFCdQEL4PQZzP8mIIkmD49qG8h4TZeZr
 GlRXyLFy4U7KcQmzfEX831ZnKWDGWwSrFNEE4++D5+mMPJwVFcmN3YGrNyaTwBvWbmmfW1zv7
 UFxGiKuT3f0hL7jqDBFgRHrgV+gHwfQdxz/06P6hi1GIlVZiP7vdLf94suNvr/QgZfsm5gKUv
 ZuSasuDdI34jvw23xJxCSRr6xSKAIfkwdOvqwqBx+mj7lSWLHC3iklHCav/8gYs9oueFwFu9Z
 FAGtcsAKBzGpm42Y4ah0gftcie2dbny1r6BRRGzSUTsuUlFaO12dQ+w753gfsqajDntHDwJhK
 b+ymhBkcRwT35Oqm+dqQa/51ZMrXNIuz9+2LQs+t6LNE4WDRcpim0DaPCtY1+WW/Mi98FDG3i
 c86qd6rdcCAJIFsNOqEytZVmYaVLdtqp7GBuhpDA6HhHKAZt022A2ChmacU0eqQoMEUgwjTXt
 jhiQHdkMsSNZH7rPpM+NC8eP5i2Hso3/nbBARfPnAf9HgrG6Q4HEqoEIrdRbb32jjTCro/xKP
 j1cD6ODNiNogvEEMrdx9qNEgLE+yk2JoXPXyVrkk2BE4b7LAEiUKeXTbO29Wq52puETIC1yYp
 mUMR7n7f4ibleZA9oBIr8+mJGrx64V/Vhc4zBLlWIhyXdVTaN/0BUDb2QBgje6jWCF7xQYd7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294735>

Hi Chris,

could you please quote just the parts of the mail you are replying to, and
*not* top-post? It would be appreciated.

On Mon, 16 May 2016, Chris B wrote:

> PS H:\test-ps\myrepo> git push --quiet
> git : remote:
> At line:1 char:1
> + git push --quiet
> + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     + CategoryInfo          : NotSpecified: (remote: :String) [],
> RemoteException
>     + FullyQualifiedErrorId : NativeCommandError
> 
> remote: Analyzing objects... (3/3) (119 ms)
> remote: Storing packfile... done (113 ms)
> remote: Storing index... done (29 ms)

So it actually works, eh?

Could you please verify that this is a PowerShell-only problem by
performing a similar push in Git CMD and in Git Bash?

Ciao,
Johannes
