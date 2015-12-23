From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Building Git with HTTPS support: avoiding libcurl?
Date: Wed, 23 Dec 2015 20:35:52 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512232033170.14434@virtualbox>
References: <1450798780.11255.22.camel@mad-scientist.net>  <CAD0k6qT+s4e_7y1DxVTN63V0tO_xFv-9i-Fmq5O0SrpQAyAzVA@mail.gmail.com> <1450805416.11255.58.camel@mad-scientist.net> <alpine.DEB.2.11.1512231059380.23702@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Smith <paul@mad-scientist.net>, git <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Dec 23 20:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBpCe-0003cX-4y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 20:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934011AbbLWTf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 14:35:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:53080 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933852AbbLWTf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 14:35:58 -0500
Received: from virtualbox ([37.24.143.185]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MhQxO-1ZpBk02CoM-00MfrG; Wed, 23 Dec 2015 20:35:54
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.11.1512231059380.23702@tvnag.unkk.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:vTAjh8vARYcCXWtQ/xu8EQRa9ex6bk3jCfajzsh/KDvx2RqcGTX
 mAeaTvznO73S8cwveJiDBY673Mo1EpNyr8t9sqv7d65uDlnYR0cTh22hCbbftw+1+xulK8v
 X0WZZYjU/KCV8/NLcIbRh1vx4GtkRrCZkVHClCRVaOkR32/NBP9yRtaqf3U8+dBJDHGzFJF
 QHgIGsTvNaJdSQTWNZJ8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KDz3D6WLtcc=:cIZBr7yBRR2c6rygc1iR+i
 830g7nru2Nq5EQWGW9PSstzJcPnglcvj8ba2yKy97pBublTFfrB5xyaim3VOQBvBS+Z/S0Uok
 +0ttyWT8iehxIenwue38hDhNffRjceuzePmyvhbvTdpn275550RlU3Pi0Ikt4OOjgX+Gv/z6D
 rDkBh2UDo1tbfavrVuJthoe8+JpCLyK8HuOaVn1Xw4oPi1mVmjqmVb4lqKH8cwwpw8dGBY718
 Pm1mxSoCN0FsZAFKoLQZam7BhlVtveoYBpEGPzRcWqeaN4w2OEOwWos72HIoDE2lUm1f2HdEm
 3nkLSKXfdaFCak2sY5EnOcnEmIcGmyGTCzWURHF96/egs0Q1BeTAUP3s4ddOJaB5kB4SdNtRm
 NVPcEz52rPa2zU7mWQ9Mr68QQZaMt/t5hf0o34yw4DyXWWbm0mV/Hf0bzvH1zIEzlDEaJPjJv
 YV7qetAPX4jWBgDMe9UegOOmvpHp+ccNFA6X4TIhqDIrdCn65t/K4IzXPHkq8HkGzWT+TESAG
 2jtw9uvNUDLM+C2Cmj1PF9SHmHEI5n8PB8AVNeJFiWE1IWztHoItIbfnKKEHzERGUsld2L1Vl
 rFoeVGRnqCA+KLWDa6ReEBe7MkfQo8ZrPDhzk+pzbsI0nEzJ/HLodIitb5vKQdaHQgsrQVEiK
 eYeaLvbbBrWII88OaNidQ+aWTr0X7kFU+Wr0nUxxRlUwx8I+qSfSE0wEVlrBsMSexj/GqZtYU
 DCnIcONcLadEvdLbVVw6EUsTt5KnUR7wymhL04tKYqiQ7rqpVK9S7bdlVevcwaR0oQIcqhWD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282950>

Hi Daniel,

On Wed, 23 Dec 2015, Daniel Stenberg wrote:

> By re-using a very widely used, well developed and properly documented
> library [libcurl] (yeah, I claim it is but you don't need to take my
> word for it) that is available everywhere - git benefits.

For what it's worth, I fully agree. My perspective: By using a pretty much
fully-configured cURL, Git for Windows has supported the largest number of
use cases with minimal requirements from myself. It has been a boon. If
every library was as easy to use and as high quality, anybody could
maintain Git for Windows ;-)

Ciao,
a very grateful Dscho
