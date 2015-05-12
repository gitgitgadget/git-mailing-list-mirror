From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetools: add winmerge as a builtin tool
Date: Tue, 12 May 2015 17:03:51 +0200
Organization: gmx
Message-ID: <f44bed1d712b4be11ee143cc33ef0bb1@www.dscho.org>
References: <1431422977-61243-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 17:04:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsBjD-0001TW-FR
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 17:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306AbbELPEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 11:04:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:64833 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933248AbbELPEL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 11:04:11 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LzKQf-1ZEgcj0GRd-014X0z; Tue, 12 May 2015 17:03:52
 +0200
In-Reply-To: <1431422977-61243-1-git-send-email-davvid@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:TRMv9jpRuqg8yzOGRwlrLeMitQaBLC/dUb/ZoSqu49mqKIBTlMQ
 g5BfK9sJrLa9uMXjMSBMJffsRev0wKUtzpeMB6DVP/XAWcp92WEqeXyZZxbVNpi4q+Qyaa9
 gllnU9RLSqzApngiaYdSK0P3Ghd39smCM8aOY19taQweOcI65W+zU2J16U9Tg/ZxKIKDDXZ
 XUP3sx3PpAU67CmE+bPfA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268855>

Hi David,

On 2015-05-12 11:29, David Aguilar wrote:

> +	# Look for WinMergeU.exe in the typical locations
> +	winmerge_exe="WinMerge/WinMergeU.exe"
> +	if test -n "$PROGRAMFILES" && test -x "$PROGRAMFILES/$winmerge_exe"
> +	then
> +		printf '%s' "$PROGRAMFILES/$winmerge_exe"
> +	elif test -x "/c/Program Files (x86)/$winmerge_exe"

At this stage you probably want to look for "$ProgramW6432" first.

> +	then
> +		printf '%s' "/c/Program Files (x86)/$winmerge_exe"
> +	elif test -x "/c/Program Files/$winmerge_exe"
> +	then
> +		printf '%s' "/c/Program Files/$winmerge_exe"
> +	else
> +		echo WinMergeU.exe
> +	fi
> +}

Ciao,
Johannes
