Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61ABF1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 12:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbcFUMCQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:02:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:57285 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbcFUMCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 08:02:15 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MexaL-1azjSk45Yf-00OYJv; Tue, 21 Jun 2016 14:02:04
 +0200
Date:	Tue, 21 Jun 2016 14:02:02 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] mingw: let the build succeed with DEVELOPER=1
In-Reply-To: <xmqqinx3u14g.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606211401530.22630@virtualbox>
References: <200865f29df65ccc53ed76029c7f38578430e487.1466253284.git.johannes.schindelin@gmx.de> <xmqqinx3u14g.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GK/1M+ee41spIvKe+7MR8R4YRU0kjDGVjK++wP4Lrs2OR0BCmE0
 Aedi4LzS827wxUEOcEoGQGX5aDwpMHC0qL59o4nWk6gTTryOdbwZHduPwtkd7vvPVrwLj28
 C9fl4h3gHmCVw8r+c1TnImbUC0iea1Fk6DDcPyoBlZ8G/TNWYTa+GnUr7cX5OgnZXJjmFA7
 b9wRNc9XcJ8GS73uL2f6g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:T67TAreVDzY=:9T6lYfwq+r+8uAg0/L9KvP
 /928xe1al9t9DHZHg7ZnRZm4fMkjPfYs2vGoT7RKMsZC40nT8zRfu56ir5JOgUwS0MS20+6CW
 4dNAHhPJSfhpE0RW10QhT2KOQerM2lKBXR/+FB8HXF83zTRtsTypuX641VKiiLydGNUTT42hX
 G2nP3jzOnUY+5imHc4IOtZuHvzz2tjNSkooGP7G2JB2+Cr2FP8WaVNv2bFeSKyBOIm4PYfb5P
 jJcEZVPDi3wTj8LNSL+yOoKwtaGP3E2LhdNg3I/ZhcJLVMGNb/TLJNdkzJpvZOdnh5nvG/6uW
 2uUaKBjGueGgE91ehz5mdnqYZCX1LzkqxMaXSNx5kNERiHWJh0YFH9M2FJW/Qltv6p+p/RUc/
 M6tKoMUNVJfYDtuUpL90Jb78G5j8DS48LBzA7vmEoYbRC7axrX2IT+RiJGxV424PYW71sM76H
 o1LRfLu+lbukFpJoA1XsG/NZbvoQT9Sx1G6ESsDbfES9j/yAi9JqJGP/Ry35wVY0g8zHNTVXw
 ISsmn7m2jkNn/a19w1gvGi9P0zEfIVBYFOtkbo5yZCQiwAsY1aj9z5EKXRQMRJwpmO2sbF4xn
 SXgiiwvmSD/lFIbtz3J13XDSFidVkptV2I8HfhkCV8VC0dB1YAocVFEMy5uEJK5ufevXiGvDB
 Bx3SqhLWNr2YyuwVMz0SPPGYkdanb4GrJ1fPZs2WgYbpHygZbRFuFY4VbyWFk5BqqXb7pLrKe
 b49UmlJ/RCDDFfvieV5gijWtjKTHLJMRPfcIFMMyVM+2MHo7QI8asLrhnSXRxQZF3DZ/flV5b
 AaIdlMm
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 20 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The recently introduced developer flags identified a couple of
> > old-style function declarations in the Windows-specific code where
> > the parameter list was left empty instead of specifying "void"
> > explicitly. Let's just fix them.
> 
> Thanks.  It's about time for them to be cleaned up.
> 
> Will queue.

Thanks!
Dscho
