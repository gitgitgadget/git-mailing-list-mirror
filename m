From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Wed, 27 May 2009 08:34:57 +0200
Message-ID: <4A1CDF11.4080507@viscovery.net>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com> <1243394364-13772-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 08:35:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9CjI-0007j1-RU
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 08:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137AbZE0GfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 02:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757659AbZE0GfE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 02:35:04 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45937 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbZE0GfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 02:35:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M9Cj4-0006Fp-Ig; Wed, 27 May 2009 08:34:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 167AF795; Wed, 27 May 2009 08:34:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1243394364-13772-2-git-send-email-davvid@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120036>

David Aguilar schrieb:
> +#include <libgen.h>

We don't have libgen.h on Windows :-( (at least not with my aging gcc
3.something). Would you please open-code the call to basename()?

-- Hannes
