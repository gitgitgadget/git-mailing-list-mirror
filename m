From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] gettext.c: only work around the vsnprintf bug on glibc
 < 2.17
Date: Sun, 01 Dec 2013 00:06:26 +0100
Message-ID: <529A6F72.9030909@web.de>
References: <1385776291-21006-1-git-send-email-pclouds@gmail.com> <1385812884-23776-1-git-send-email-pclouds@gmail.com> <529A6E48.4050001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Niedier <jrnieder@gmail.com>, vnwildman@gmail.com,
	schwab@linux-m68k.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 00:06:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmtcO-0003on-N4
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3K3XG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 18:06:28 -0500
Received: from mout.web.de ([212.227.17.11]:56189 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab3K3XG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 18:06:28 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lzrwh-1VZTDl2KB9-0154wE for <git@vger.kernel.org>;
 Sun, 01 Dec 2013 00:06:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <529A6E48.4050001@web.de>
X-Provags-ID: V03:K0:ZM6eM91MbxM5JWdz8fays8K2VcIn9DaTSptavxxAjz41DY5F55l
 2NpSOqJAXfmd4l0QLAFT1sQeXLpGst35iOGgkYJtSB4D+KzqDh9H+T8+aPgTDJbzyUfh9rT
 5i2jAnQtx8OHGpgzhDnp1wltdg9HfcEUp15vHAO11q1P4RwIQGxB5zY4yBzhtWdYR8/kUO9
 7rKd49qKE8wgWOhSmt6pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238574>

> gnu_glibc_version()=2.11.3 /* Ubuntu 10.4, no updates */
Sorry, Copy-paste error:
2.11.1
