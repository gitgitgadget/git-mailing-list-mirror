From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Error using git-remote-hg
Date: Mon, 12 May 2014 21:01:57 +0200
Message-ID: <53711AA5.4040001@web.de>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 21:02:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjvUK-0005pS-6G
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 21:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbaELTCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 15:02:07 -0400
Received: from mout.web.de ([212.227.15.14]:64599 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbaELTCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 15:02:06 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MEmc2-1WZU1J3Zqk-00Fyjr; Mon, 12 May 2014 21:02:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
X-Provags-ID: V03:K0:4PRz/bn6NyY0gA3F1Wjtw/vsh3vCqXe9CV4L+Y8zYxjfLPuNWtD
 hNAOfre/6ABiXESUJfQ7v+2uGKnMXpx6I521bfyvgzprRFNMPDVEYWr+++j6rFuKTAfOdYg
 ixXHOE3YR/Fys/ueGiQtE0WsaOhx5tIVbnHgJSsiKfpuN7sF+/l/xC34FuKobrvuNmApwjt
 SlFffkWJ7e882RrClJQ6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248723>

> I'm using git 1.9.3 on Mac OS X 10.9.2, with hg 3.0 installed with brew.
> 
> It used to work before, on this same repository, since then git and hg were both upgraded.
In short: The remote helper of Git 1.9.3 is not compatible with hg 3.0
You can eiher downgrade hg, or rebuild Git and cherry-pick this commit:

commit 58aee0864adeeb5363f2a06728596f9c9315811f
Author: Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat May 3 21:16:54 2014 -0500

    remote-hg: add support for hg v3.0

HTH
/Torsten
