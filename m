From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Tue, 16 Sep 2008 12:17:03 +0200
Message-ID: <48CF879F.6020006@viscovery.net>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com> <1221397685-27715-2-git-send-email-pclouds@gmail.com> <1221397685-27715-3-git-send-email-pclouds@gmail.com> <1221397685-27715-4-git-send-email-pclouds@gmail.com> <1221397685-27715-5-git-send-email-pclouds@gmail.com> <1221397685-27715-6-git-send-email-pclouds@gmail.com> <1221397685-27715-7-git-send-email-pclouds@gmail.com> <1221397685-27715-8-git-send-email-pclouds@gmail.com> <1221397685-27715-9-git-send-email-pclouds@gmail.com> <1221397685-27715-10-git-send-email-pclouds@gmail.com> <1221397685-27715-11-git-send-email-pclouds@gmail.com> <1221397685-27715-12-git-send-email-pclouds@gmail.com> <1221397685-27715-13-git-send-email-pclouds@gmail.com> <1221397685-27715-14-git-send-email-pclouds@gmail.com> <1221397685-27715-15-git-se
 nd-email-pclouds@gmail.com> <1221397685-27715-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 12:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfXdT-0003z5-BC
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 12:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYIPKRM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Sep 2008 06:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYIPKRL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 06:17:11 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61843 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYIPKRK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2008 06:17:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfXcJ-0001l1-Lw; Tue, 16 Sep 2008 12:17:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EC6816EF; Tue, 16 Sep 2008 12:17:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1221397685-27715-16-git-send-email-pclouds@gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95993>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> +--full::
> +	Quit narrow checkout mode. Return to full checkout.
> +
> +--path=3D<narrow_spec>::
> +	Re-apply new narrow spec on current working directory to
> +	form new checkout area.
> +
> +--add-path=3D<narrow_spec>::
> +	Checkout more areas specified by narrow spec to current
> +	checkout area.
> +
> +--remove-path=3D<narrow_spec>::
> +	Narrow checkout area by removing files specified by narrow spec
> +	from current checkout area. This operation will fail if there
> +	is unmerged or modified files in the removing areas.

The option --path is named a bit too generic for my taste. How about
--narrow=3D...? And how would you like --more=3D instead of --add-path=3D=
 and
--less=3D instead of --remove-path=3D? I do think that --full is OK.

-- Hannes
