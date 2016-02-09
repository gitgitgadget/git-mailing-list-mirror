From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Tue, 9 Feb 2016 11:13:12 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602091112570.2964@virtualbox>
References: <20160208222155.GA17395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 11:13:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT5Il-000422-HF
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 11:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674AbcBIKNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 05:13:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:59697 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754344AbcBIKNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 05:13:33 -0500
Received: from virtualbox ([89.204.153.48]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MU0pN-1abdso2kFN-00Qn7g; Tue, 09 Feb 2016 11:13:15
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160208222155.GA17395@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0XAVEmVoqHSDApnjwcwOKOmQpq07vXrjXrYPdu6YWS3OwMkOopJ
 UQM0SnWPGYWT2TN/mI+8UknRPtibWTXa9wcL2yz9HhXYXnloCIMBTftV/TaUClu6RkjBng8
 4ulcGE7uAgK7fNZTZPrhhpHI0bKFetpHZC2yQtnuzc/soodpdFDlZBACMhaMw2a8Q/BBcZV
 eGk99NqW+xV5Dp+95BcRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mlTUstm8NWo=:857GFXGDKMXqgbqjA7oX8Z
 wv2Zj2/wP7wmcvT6TKFgJDrX8J8vCgWjyKXphWRsdFvy4Vboe2vtsOJRd5pujEV/JtX06n0Tf
 hN+Qy06PJbWuEcYc0snG3dsKXzYW/cMTrIzl5PzWEZYfQCyHqkumjyEedkDGrY4xn1ivMDTWD
 J7AcpIgU4Bb/sjRvS8okZH22NXbf8u0vSMECuH0Yv3fqj+YSrx+ejuJo9i7sG3Nq9YWhmgoMQ
 mLk9Ulcz1xZ0Maw4WEJiw3Uyhg4g7A+Fkg4ZQfD8X/7vIsIwPQEGFuSHDsteWx3Jbv9bK2Bz3
 6WGn+D76h3qEBaqFeRUP2TMuvH6eK2qdYs9E6FbCX0VosI9CeVmvMCk7nA8jNeCZ8/NuDvmhb
 X3G+S/IH+E/YOkdHrD3//Fr1VWLh1YVb82m6XirW4S1L11EfU2Up/Chdg+8+CugVWJhjPcWxX
 7i7yBHzaB5HbyVIo2eMJXNwaAVg8l8qb9GjiAM7oSN5jhwpWiUPXnH9A/bxphJthVfUb5dOzC
 ZiRzxSJb3mQdB5DWPqKdXblaKzrFyMpXgGOuc+ZQCWY5p2pMfqF8tPrkfk2XLs7uQ2xyGSOhN
 9+0LiTrW1BjeQdpNTxRw+lCXE5ojlTkbC22k20xjH6b9M9emWR7CGJpKNmnLd6DOAiN2UmPXz
 rMfTlEgkJsNCAcX/2t/SNGlLVPTfv8X31YPFIJrGiMz2kKAL7TbgjywktRNEwrzM28Jzs4/Lr
 lmbsisH1KV7ms8R+CGNWF4eviFBwrBSWal8JrQNnsN8xPMRT2tRwUjIJ/sfvHTijF+nP6Dc0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285836>

Hi Peff,

On Mon, 8 Feb 2016, Jeff King wrote:

> This strcpy will never overflow because it's copying from
> baked-in test data. But we would prefer to avoid strcpy
> entirely, as it makes it harder to audit for real security
> bugs.
> 
> Signed-off-by: Jeff King <peff@peff.net>

ACK, of course.

Thanks!
Dscho
