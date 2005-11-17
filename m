From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Thu, 17 Nov 2005 17:56:31 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.17.16.56.29.833519@smurf.noris.de>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org> <437BA6A6.8080900@etek.chalmers.se> <437BC7D1.1070605@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Nov 17 18:08:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcnAc-00086u-Hh
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 18:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVKQRDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Nov 2005 12:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVKQRDV
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 12:03:21 -0500
Received: from main.gmane.org ([80.91.229.2]:15259 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932438AbVKQRDT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 12:03:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ecn6J-0006R4-8C
	for git@vger.kernel.org; Thu, 17 Nov 2005 17:59:07 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:59:07 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 17:59:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12134>

Hi, Lukas Sandstr=C3=B6m wrote:

> After doing some maths; actually it is very exponential. 2**n - 1 to =
be precise.

In the general case, yes. However, you can just sort the packs by date
and sequentially drop all that can be dropped. That's not optimal in th=
e
general case, but for us it should be close enough.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.nor=
is.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.nor=
is.de
 - -
When was the last time you were drunk?
