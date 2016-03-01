From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Tue, 01 Mar 2016 06:49:43 +0100
Message-ID: <56D52D77.1030406@web.de>
References: <56D3E56A.5010608@web.de> <20160229092816.GA23910@sigill.intra.peff.net> <56D415C6.2040203@web.de> <20160229100258.GC2950@sigill.intra.peff.net> <xmqqtwkr9vu6.fsf@gitster.mtv.corp.google.com> <20160229213620.GD25342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 06:50:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aadCN-0004nJ-An
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 06:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbcCAFuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 00:50:13 -0500
Received: from mout.web.de ([212.227.15.3]:65204 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbcCAFuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 00:50:12 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MOj5C-1aVhEq45wM-0063FQ; Tue, 01 Mar 2016 06:49:47
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <20160229213620.GD25342@sigill.intra.peff.net>
X-Provags-ID: V03:K0:sZa4/Awxks8Aou4VLQD03uZ2SOHh5/2GoXSy68V5LvcaaUdcZyj
 Qr180wFjdoxP+howKuASHWQsdb4FyWOZwX2RAS3/4sl8iEmUrTRoQSy4CTjt8UvIQ8Hp9e/
 DnulhaiZ19s7fsKBCREg0Bnpu8JwKPG+pUis0pPNuGV441qAtipWyYrJtw6n41zn73sQ5Wt
 bo3dIV2wKYttQU0xo9jLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zRHJibGo1Bs=:6CkZ5s0s0GRPqCMO90whWM
 1QQ1lgp6XP/2Ln0359SssIjjqGqkyVzRamrw9+Ga6r01Xh1REwMyvyuKh2+iLlH3DMHwoICm/
 SVJxJxaEDIcl2ndqEreWaPTKhF8wGSdCpq6T92rtt2+cr2/tt7W2qomi+4qozxpbfPXdUFBC9
 w1kcrFCEW0RtRMEoIN09QuEhPV0LdawZVr9ekQ/JyTPSfFn0QMEX7Of6Vn5lMOjTNL5ud5dXu
 POr2VRrL+7YROaGn1qN4EqBDqJbPHO93tjeTMdMEB9PxHdK5I/TvZAPcA6wHzaFjbMD5qgcQo
 DhIOwHDbmq+YTSUgbwtG9N79Q26IxVH7751qqS+uA194dIJoryFPlNx5riQ32XxLXNZGTecDp
 xSsj+WyMLhw0Lq9Z/Iz7uYoMtCjt0JPDKgL+ybFgcddYcygT9cDHlRWcUGRY47f01+vnwVeAp
 NNjKtAw7lvFrhA3jJOtns8Tym40OF0sXnHQdMCiStPpBivwsNXabDRJHFnKYFnBV7qgA7x827
 srwo5xtqcpql4rnj6YGdu0ulslnjnULNX3RLeBVLlBtv7erhe1r7633jDWHCIIFDJBZ8EaZJe
 UEOzNFaOertML3cC0tXHq/AqX/ahMzGlMZZ5ZwikLUaDUkKfZsavwNP+M4RkBkzFZB6J3Yhdv
 9zUoNO4SQ2wo/Axq3yRQ4F0nM8PHqEenm6QghowmP4NqyZdtgBntELCWimod1fsyUPp3whW8y
 9BRMLv8MXeaIhl20PdaBcLltSAV4owxY8eSX0iuSy0darg4YmWGjfZpoZ9ynQQtLJIpJThl9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287998>


Oh, <phew>. I am only half as incompetent as I thought, then.

I didn't even re-check what I sent, and just assumed Torsten was quoting
it exactly (I _did_ write something like that while making the fix, and
assumed I had just failed to properly commit).

So yes, what I sent both times is the right thing. ;)

-Peff
--

I have no clue how my copy-paste programing could go so bad :-(
Sorry for the confusion, compat/mingw.c compiles now.

----------------

However, suspecting jk/epipe-in-async, I don't know if we can do
something against this warning:

  CC run-command.o
run-command.c: In function 'async_exit':
run-command.c:631:1: warning: 'noreturn' function does return
  }
  ^
