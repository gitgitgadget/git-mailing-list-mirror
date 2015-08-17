From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] am --abort: merge ORIG_HEAD tree into index
Date: Mon, 17 Aug 2015 12:09:58 +0200
Organization: gmx
Message-ID: <33846154f448fa217389d91583ff081e@www.dscho.org>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
 <CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
 <03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
 <20150817094819.GA10375@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 12:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRHNE-0002kF-L0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 12:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbbHQKKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 06:10:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:50173 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbbHQKKH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 06:10:07 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M6fXs-1YX6Gp3gU0-00wRJa; Mon, 17 Aug 2015 12:09:59
 +0200
In-Reply-To: <20150817094819.GA10375@yoshi.chippynet.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:WaOhgzcu1UJMZBGR7dASKRUw8HuvjOSTJQSVGxqvweRyBQhUynH
 czMdpWIKQf9sQuG6bHBXlHHly55pLGvjRzay9nojkZXAWiUZ3ib2fXa6yFjmTPbZipQCBPO
 hIPwtp2VEw0BQOVh17SgQXNHYhbjQtlEif2EZhFYR7TETQvkrXIWX49wRF5od3Qkh+FzijH
 Nnnj0sHoMtoH67/WIU8hA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Nvx10dPK5e0=:hfC5npYn2B3ww3icNOpvvm
 894rp4QN9LR4T6Xz13weuPKBQ3eR9f6YIj/dJjYfa92w1OH5znMCTcn57+jNWLC5x0a0RWQ20
 RpPKdlh6Oz9fghFR4ZFj2hEYuHoEBKqog3Z7Yd7TVh7iryB4IrJzrg5DrnWb+CtrzstQt0KfL
 kPWaONCATNLv1aEMGLrwXYIHOcrRzwM2RPahK3S4N0FsCsvEAFizfuO0AjeB4hiaK6hOkyW16
 QFPhtDgbVKOvaz8TxGI+XyQLJ0wWlb8EG7ItPZdUfyO5bcdMODB2o4MEE1K9RbJTLoKlKQvtK
 khxRiGBXklRIn3yE33A8QjiicI90tTGp1iZ+dBOW+3rTx6Rc675ZeCPfly/U/t87TSB66TQPZ
 weRa4fBT5srQvLlYn6h89dzYfGa9D4tP+zCRRv75fUn7A8vOF8Jp/tjETpHq7MkoEETjgGJNx
 35OPwyf/cSNH5J7qAA48TS5VMepVbBROWiVbKZ0ce/TYzUwT6e8hBVQXujtvsKaPe5eDUMask
 71gM9eEOxDN3UNhXCtGb0LaIUvFQpHtOq3RlNIsBQiZ4wH9rYwdLruFWS9ign422epQQTKZht
 EkFdIBCWn5UBFAQ0jDlgA3tngvY9NQ7/L+P7EJNbGwe/FWNZhYSPafT3535lvDaS+1uuDMbk/
 ro4ekWR86+FanrW86fW/hoyu+4brtGAlAPjyUONwvqilBnaxSGJZdAk1FTFGErm+QVkZ7lb8t
 qs2ielK0amdFB4zbSG/a7mCwUTKBf+PdZXEwEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276046>

Hi Paul,

On 2015-08-17 11:48, Paul Tan wrote:

> It's true that we need to merge the ORIG_HEAD tree into the index
> instead of overwriting it. Patch below.

Thanks for your impressive, very responsive work!
Dscho
