From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Wed, 5 Jan 2011 18:13:57 +0100
Message-ID: <201101051813.57603.trast@student.ethz.ch>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com> <AANLkTimHb8O6s_KfhSGqvStZkEGWvPeAVcqQkYoyk49j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 18:14:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaWw2-0005QM-1w
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 18:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab1AEROA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 12:14:00 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:47345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170Ab1AERN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 12:13:59 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 5 Jan
 2011 18:13:14 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 5 Jan
 2011 18:13:57 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <AANLkTimHb8O6s_KfhSGqvStZkEGWvPeAVcqQkYoyk49j@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164575>

Luke Kenneth Casson Leighton wrote:
>  now that of course leaves you with the problem that you now have
> potentially hundreds if not thousands or tens of thousands of
> .torrents to deal with, publish, find etc. etc.

Umm, I'm counting 202400 objects in my git.git and 1799525 in a clone
of linux-2.6.git.  So I'm not sure how far you want to split things
into single transfers, but going all the way down to objects will
massively hurt performance.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
