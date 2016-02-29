From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Mon, 29 Feb 2016 14:01:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602291359580.3152@virtualbox>
References: <56D3E56A.5010608@web.de> <20160229092816.GA23910@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 14:02:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaNSq-00007a-HX
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 14:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbcB2NCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 08:02:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:50165 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbcB2NCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 08:02:09 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MGAdz-1aeYjc1rh1-00FACV; Mon, 29 Feb 2016 14:01:55
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160229092816.GA23910@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qiN1B3/Sl+3P1xWQRV0A+K6vQg3je2CPO/TUmqT7/yeiVwYAReW
 ZW3+C+daaas2wHXzBz/EPOBxqHLZmb2uazD2aMwS348u3wwgnP3xIZPcG4u/XuV4YaM66et
 LfYtXjAjouJV/bbI6qb1o9RRWoFmOFQznaSmNNaWt4TRJtthEnIKFQnS2dGbAIkyzEO1417
 vRKFVYhQx0Cyi4uKxntSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F/1Jtbb5uXE=:/X6C5EmIwon1XsVkbhFoxR
 brRt9goyRrKP8T75/GeRlFIK0z7xqTNU6aLF9WZd4szmcr9GLEGWDRgGJRAdCQlRehit4OhSy
 LdRpjwY4Jo2yVRFGetuk/Ri1eoUcCSGLnb3QAStko+kSsHEAwz4dz7fkEy4kT5xUGCs5wmOy4
 oDO2eSJNKwC4Dg9/FBYhuEIysW6tsgfVvSRLxvBvznctutHVZeRGRFJZk3Kv6gNxwI2Q+311W
 s3ocsQw9YBHBEKXvSEd+JcOrYstqhR7za8HdMwqec1dceyKjgzpVDz0tj8DqXIEfBCDBlHRxN
 LVCaJJy1gkjDR/eiEJX7dHKEtD2fXj6hynz5i6Qo5UUYD7tyxnZEIbNU4znPTNFK+/yB8e08/
 J25PQbnpQFZ9VjjmJcT0wRKN5nKinpPK7HdYJ2RnTnb4bVOzutKU2FrKidOHPjLTYnmMdZeg2
 YYlvf1VAY0sYg9kb2khlmkruvvQmVq8Ju/APaWcyxHBurboYtWawbUQvscVfSmCQOC19MN0Gn
 2ipShU3UOypc0ZCvcEhJ8ThuHwNbV6tnSpLw4JBXs9QLabO43WKT/K4UGJNBQQkMzsdfc7WOm
 FHpl7LBirAIsiarPFmfmXDREEYnvwO//gsLYYeLhVAYE1QmQy/H0CB1dC1ZosNljkjHqjrg/k
 yBGZDU75DNPP8hv/oHDlN+a/IiG3KWS8vUYStcqaLf4IhWVqyBd82p8oZ+tnZylMxF5y1+Bgx
 lDs7EdNJVx61F/MeZUwAhSAqrrY2WLxDnEckzzdAylYiSNXtSGZPMRWcT/n/1d2PjnQkkYRt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287834>

Hi Peff,

On Mon, 29 Feb 2016, Jeff King wrote:

> I think this means "master" is broken for mingw builds.
> 
> Sorry, Windows people, for breaking your build. I'm happy to hold back
> such repo-wide cleanups from the mingw code in the future, since I can't
> actually compile them. But the flipside is that if I _do_ improve
> things, you don't get the benefit until somebody manually ports it over.

No, I do not think that you need to hold back cleanups. We will catch such
issues before long, anyway.

Thanks for all your hard work!
Dscho
