From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward
 slashes
Date: Mon, 4 Apr 2016 22:42:21 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604042242110.3371@virtualbox>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de> <56F8E435.3020304@kdbg.org> <alpine.DEB.2.20.1603281712470.4690@virtualbox> <56FAD506.4050701@kdbg.org>
 <xmqqwpolvyml.fsf@gitster.mtv.corp.google.com> <57001772.7090007@kdbg.org> <xmqqd1q574p8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 22:43:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anBLI-0007mP-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676AbcDDUmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 16:42:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:54492 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756492AbcDDUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 16:42:49 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MBWTO-1awZVv0a6Y-00AVRg; Mon, 04 Apr 2016 22:42:25
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqd1q574p8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:C8oZ/bA2+XSYCS5xtFMFco1qoKFSPcUIWlufQ6Q4xoky+WuhzFr
 pq5CrORm4uOfECXW7EAhPfwTjmQ0ZQr9Gk0b62zxBxYX77Zh9QLp4czsS16Lr3ABXNA1VFl
 t7QjgGKEtWmQW94EVjBp+fxiiubjbB3JIU4IO01wXPpS5AvwxrfVLkX5PW2Fe1aOYkEWQ0u
 PO8sqvSgYHh9Eu4Pj2wVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zG3ccEdixbc=:Ws2cafPew53gy5Ri6UgNx6
 L9alkJmMlFYh87d8rFUcJ5VaP7iw4bQ69tbjxriAFPrdgjfKaVx3AFS7TrXuWAoC6P57935t9
 Vx6+65ImkZyPK5rwAAQZnOs+x6yztWw/tMd5XSsgtjdT/4BJg1L1VnpTREvR/+m5KIteE9+7a
 2HhsVLUfCX4BJ6SOK40z4Pc0oHoO5zM2g/pct+utDhTgva7JtgDOVkq44jnGFht6Rjn5puhKu
 c2jYiVi95DZoyqV63xY/mhYMCHYeM2naFrLNpsEu9/+d9XdAkIzDce6Jo3Ni8xyaiTbWjiBCV
 S6YkIlJgCJ79qcE+B9Cl7yTYGbNqS+hPiX5Gqabg7oIo5Odvxgn6/oIVjBE8nSYFOXnyt8DYt
 Awe5xuEeXH9CY3Vp/ssrk3GAttZ5j6Avgvy+2+VLskTm3IDBxsz+s1Hk6m5KbOwB7XS634g/W
 ocPpWMroRShbu8o0wGadU0TKHN1fhDra20YT51wiVAa0vYkx2Mnc/7nC2PUe/moHwgHRbmf3B
 4n1sSyidXpkRDtAIv6rg9zMqzSzhHcPof6SZ7T8Qy5e5i6AWej9qi7w0K9G2CjBeTGDiF7yfu
 i/Ksl6IWbER6hDl7T7DY1eXDMKE69JNNfCMXPKDF8Sek76/MopYHg0sbbG419OBShq7vunuAf
 WkNRjuwqudOySbLjFZxz8I1n0QcteJ7G5x6a0c4lLD+BpLP1m99RwxxThSKd8ZIIo4zM9pEsa
 I2n7i1XI6GVD+QylxvgkK+rrdXSB7MCZmDBGl2137d01bJdouYHpKZaWXXmdspRPorS5WSdY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290725>

Hi Junio,

On Mon, 4 Apr 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Although I am convinced that the change is not necessary for
> > correctness, I can buy the justification that we should produce forward
> > slashes for consistency. There are a number of occasions where we
> > present paths to the user, and we do show forward-slashes in all cases
> > that I found. We should keep the commit.
> >
> > But then let's do this:
> 
> Sounds like a plan; even though I am mildly against adding more
> platform specific #ifdef to files outside compat/, this patch does
> not.
> 
> Dscho?

Fine by me!
Dscho
