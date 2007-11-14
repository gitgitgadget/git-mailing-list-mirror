From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-clean: consider core.excludesfile
Date: Wed, 14 Nov 2007 11:02:59 +0100
Message-ID: <473AC7D3.3000801@viscovery.net>
References: <30046e3b0711132340y2c503dd4laea24b9b1c79a160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: shunichi fuji <palglowr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 11:03:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsF5e-0005tJ-MI
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 11:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXKNKDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 05:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbXKNKDG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 05:03:06 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5862 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXKNKDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 05:03:05 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IsF4l-0002gy-KZ; Wed, 14 Nov 2007 11:02:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7C38D6B7; Wed, 14 Nov 2007 11:02:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <30046e3b0711132340y2c503dd4laea24b9b1c79a160@mail.gmail.com>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64976>

shunichi fuji schrieb:
> --- /usr/bin/git-clean  2007-11-14 08:26:20.000000000 +0900
> +++ git-clean   2007-11-14 09:43:03.000000000 +0900
> @@ -81,9 +81,14 @@
>        if [ "$ignoredonly" ]; then
>                excl="$excl --ignored"
>        fi
> +       core_excl="`git-config core.excludesfile`"

Please make this

	core_excl=$(git-config core.excludesfile)

-- Hannes
