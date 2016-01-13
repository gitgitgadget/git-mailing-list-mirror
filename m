From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Teach 'git pull' to handle --rebase=interactive
Date: Wed, 13 Jan 2016 07:52:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130751560.2964@virtualbox>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <5ed91705cc70323dd3f175627acf86a4f594536c.1452612112.git.johannes.schindelin@gmx.de> <xmqqsi22s6x7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:52:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFIO-0003Yj-2J
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbcAMGwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:52:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:57976 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbcAMGwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:52:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LlDx4-1ZjMJH1NkE-00b0VC; Wed, 13 Jan 2016 07:52:29
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqsi22s6x7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qDc45sGyHAzWgl4KocR2Pz4FLanfYoOEfkNmCSAWkRgvgCC9esE
 rhFD//m4cvRTQVLPTTTm7amd3BtCNRjNmFH3GCG/e1sTMj/k8bz/na8o8kga7M0Wd4ng7XC
 81dYTGoC7VxX8LZJDPlHW3DqlIBHk8Jdob4KLI17Xx6LcmV6jPEKlT3rD6jqNHjJabbuDU3
 V9SAGx3w8PIxr8zcksAgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2GAoOwKXZ3U=:xkpJ/OBDvl9RZxc6/2PNq+
 G2+Vu+IYI9ZffxfA+FrVj25KcEhRKTP8DJXfK1hZfp9lDZjllaKisRyoTVrwhLDYux7Mj/iFG
 sH6v8xa3P/IphMuWPbYNOqhBKTLtipCjbGNd6o8XPWe+VGQEILfk/g1Sw8b0cgbjfrg15MAIV
 Gz+jlJchIk9sV4RWpYvcItccjj0Atr7ZlyRJKasVBMQHoeDELf3YVCVBeZuKACleL5lVowm+E
 Tju4Rpx0L+6+n3aP74RHe9Oj1AHU8WDLN1nbvzDKfCAc8Iuv+xX95nwzpaqt3U8ghvsKMqIHM
 1ujzxWoEHbGHsLhpFQ/4IDNucBkj+K5IgEFYEF/RI4NPzeIXDGGfm7/e8mizhs/gD7eILw7Vz
 kx06EjjNBMPZkRyqTVnBOIVjRdbcBLcsw1sxmuYw+RXTyAV0LMycOAvIxf6S2yrXEFvaqT6Hh
 arCwt+U4V/IQ+ecsjsn7nFD3CozLR4WUoDlp/vDX7Ca6gOeqmNAIHRFXqgA+ZrUARhdHFaZPE
 ae4a1+MtBBiJABJDcz9WoNt8MiX/iLV1P06sszmseODdCtBw5U3S0ryIjlDz13WYFznvZITMu
 Q6FmlsvKuhm5chC/oGGyP6mtnt7jaXgH0Qza7YmWzITPEzY2JK9KKjNbypaT+YSmVCKS+0AOV
 SjMK6+ylWIFEyQa68d1A3xoZfcdT7+g0CtzES28dtT7yVarvIFUtrWj4ZNF06Cqmdcid1AttR
 86V2qeI/PJLou0eZt4wjZ5/vIRdUpv8dxegiP3WxKor1Wln1GNlTYOtLMpBPAQY/m6lzJSvZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283884>

Hi Junio,

On Tue, 12 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Subject: Re: [PATCH 1/3] Teach 'git pull' to handle --rebase=interactive
> 
> Subject: pull: allow interactive rebase with --rebase=interactive
> 
> or something?  The same comment applies for the other patches in
> this series, and other recent patches from you in general.

Fixed in v2.

> > The way builtin pull works, this incidentally also supports the value
> > 'interactive' for the 'branch.<name>.rebase' config variable.
> 
> That, especially the "incidentally" part, makes it sound as if it is
> "because we can easily", not "because it is useful in such and such
> way, we must support it".  We definitely want to see patches that
> fall into the latter category, and from the sound of 0/3, I think
> this one should be advertised as such.

Also addressed in v2.

Thanks,
Dscho
