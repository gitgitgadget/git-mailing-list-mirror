From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Thu, 12 Jun 2014 21:25:54 +0200
Message-ID: <5399FEC2.3020309@web.de>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 21:26:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAdo-0001ji-8C
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbaFLT0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:26:24 -0400
Received: from mout.web.de ([212.227.17.11]:52651 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbaFLT0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:26:23 -0400
Received: from [192.168.178.27] ([79.253.176.15]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Ls91n-1WlI6E2GeF-013slG; Thu, 12 Jun 2014 21:26:21
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1402589505-27632-1-git-send-email-mst@redhat.com>
X-Provags-ID: V03:K0:igsv4lyWi9kwn2p/5c7w41594btzzdvL3XxL4FDxkb2Bk9SU3Ve
 kahUFSnUrXW6kyBk+VdFfRkvUFlnH9IiyqqKn10rAeT98eGZYvQ3ZRWXE9R0HisFdJoTb0B
 XbNg0ycXT96b6a/TtN4qOGXk9fRFp2f19n7AzTm9cb9SIZMVp2n2dsEcX13ydyrD1ItNgLM
 WbBoQebao+Tx7gYcG6DwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251483>

Am 12.06.2014 18:12, schrieb Michael S. Tsirkin:
> @@ -136,7 +136,7 @@ fall_back_3way () {
>       eval "$cmd" &&
>       GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
>       git write-tree >"$dotest/patch-merge-base+" ||
> -    cannot_fallback "$(gettext "Repository lacks necessary blobs to fall back on 3-way merge.")"
> +    cannot_fallback "$(gettext "Repository lsignoffs necessary blobs to fall back on 3-way merge.")"

lsignoffs?
