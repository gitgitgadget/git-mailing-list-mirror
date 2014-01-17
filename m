From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/WIP v2 03/14] read-cache: connect to file watcher
Date: Fri, 17 Jan 2014 16:24:29 +0100
Message-ID: <52D94B2D.2@web.de>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com> <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1389952060-12297-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 16:24:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4BHt-0003IF-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 16:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbaAQPYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 10:24:39 -0500
Received: from mout.web.de ([212.227.17.11]:58710 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbaAQPYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 10:24:36 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LZeYO-1VcqoH3hXQ-00lVBY for <git@vger.kernel.org>;
 Fri, 17 Jan 2014 16:24:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1389952060-12297-4-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:BmLBKjCgSII+UfXP3cSeeqV4gTidOeYO2/EqnWadIvqjO6VHnuy
 Iwip4vT/lbeN5cOgKifRKE5biZaz3IMMRPBFdE2oUF6qa3jTbzXtINEvtNlHW4VkwcPX43b
 LuV3kG0axhjXVe7IxWBEZdsFSVjXYLF6KctNxtZFf5N+Rhkl8YyDDQ9Nd6w7fXEuXLhuLk0
 igCllT9RxNLKpikE5Hwrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240599>

On 2014-01-17 10.47, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[snip[
> diff --git a/file-watcher-lib.c b/file-watcher-lib.c


> +int connect_watcher(const char *path)
Could it be worth to check if we can use some code from unix-socket.c ?

Especially important could be that unix_sockaddr_init() wotks around a =
problem
when "long" path names are used.=20
