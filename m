From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] status: be prepared for not-yet-started interactive
 rebase
Date: Fri, 22 Jan 2016 18:11:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601221811030.2964@virtualbox>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de> <vpqlh7h5zrh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:12:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMfFo-0000cd-Iz
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbcAVRME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:12:04 -0500
Received: from mout.gmx.net ([212.227.17.21]:49249 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbcAVRMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:12:03 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lb5Tp-1ZhFpk3YoT-00kfWg; Fri, 22 Jan 2016 18:11:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <vpqlh7h5zrh.fsf@anie.imag.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FXCIPr1fGXO2o25u9E/oVtSOtZ9PjjiKBH5ycqasmsUAePIZxu3
 fjX9RWuZ45I084kdloK2q+G+bufdhCLk09E9o/MMdbKYAdyprT+91jID3Rmtw7hoYdUKt4B
 fQsqvJ/lEO58v5g/sk35UcaQgCwGIlCqcKJG7rLCOh/pF2JEbUwpwWa7V9yJBQuDr8mAufa
 tV8kFuvGm6wcVbhU+Okjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FAN2EjOUJuw=:8vTIanzGyI2A1cbHTY40h9
 dm1N9JktDPti/rHhPZpHQkyDJPZg0/TV3Hg61jPsap4n8DID46SrUSjSp3JXMoAkaYJb+W5BF
 ZPqU+JUrJXAdNF4T9N6RrLjtTXI+/XGcezgjpCnJh/Ewfhs9TfGHbOURa5w2rj6LzpSAM79wC
 N+bwvks3np8Rh1FvhLgCV+pPQTMSxSfHjtT3Lz4q/MSTl41AW1+NsIZabJk/tPELcT61nX4UV
 D+lD4QiLJp/Dw4mMMG4gRW+IgSEIM/Xa67Q3ykGc/UJ4CideVoK1yonw5jACZq3ngJ1qHeuaN
 wIvVWct3iVBBQQ4tl3ovddkws9BUt1/htQI3c7QYGpPAxFt82ThIftUNYfUAeMTGzSiZF0Gmi
 eDvHw0wSLRwW7b1wh9CSIYDhV3K4zMDfi2u45pTYvxb5R3535OXRwKy4GUBFG0JVgIMaVFMiL
 yEOgfl5gUK+50d1t/rvCQbWWONMM4jxN0t2wWb6q0vvelJyytFIchJAEQiYQnli8GeY3UGo+x
 Tk6A02heV1A+KutIBpggupCAw8XSPm56yFgSWWt01ZpJ/DkOlEQ/x4AFp/pryOJsKdRc/c5jw
 ZBwuabDMGncUpdR09I80p3W7TbmftXQHgvMS+a1zhsiFpSfHV/JESwp35yeggGR9+3gdIAoJF
 TWuDpOSAArqdq+AXnHNIYUfhXNI4fE6QfaL/lQKihNdfL6e23cDDi1XgT/hlVoEw6U1luTCzY
 PJ6MytwvfmMzSIua9zcE6wtI9N7bX/rMD+QZg2UwS3F4xizXju/YUIe4jRDF8/+Mp8FOwm3B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284567>

Hi Matthieu,

On Fri, 22 Jan 2016, Matthieu Moy wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  wt-status.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> Looks good to me. You may want to add a test by overriding $EDITOR to a
> script doing "git status >actual" if you want to have fun with testing.

Sadly, I lack the time.

Ciao,
Dscho
