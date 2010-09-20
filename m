From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 36/37] merge-recursive: Make room for directories in D/F
 conflicts
Date: Mon, 20 Sep 2010 13:40:45 +0200
Message-ID: <4C97483D.8030605@viscovery.net>
References: <1284971350-30590-1-git-send-email-newren@gmail.com> <1284971350-30590-37-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 13:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxeju-00073w-90
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 13:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab0ITLkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 07:40:49 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37014 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab0ITLks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 07:40:48 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Oxejm-0007E4-4c; Mon, 20 Sep 2010 13:40:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DCE491660F;
	Mon, 20 Sep 2010 13:40:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <1284971350-30590-37-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156617>

Am 9/20/2010 10:29, schrieb Elijah Newren:
> +	 * NOTE: This function relies on the fact that entries for a
> +	 * D/F conflict will appear adjacent in the index, with the
> +	 * entries for the file appearing before entries for paths
> +	 * below the corresponding directory.

I don't think that this is a generally valid assumption. There can be
other entries in between:

   this
   this.txt
   this/file

(where your focus is on "this").

-- Hannes
