From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] read_sha1_file(): report correct name of packfile
 with a corrupt object
Date: Fri, 29 Oct 2010 10:08:44 +0200
Message-ID: <4CCA810C.5090202@viscovery.net>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 10:08:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBk1B-0003q7-07
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab0J2IIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:08:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65032 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175Ab0J2IIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:08:49 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PBk0z-0006qB-Bm; Fri, 29 Oct 2010 10:08:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 046D11660F;
	Fri, 29 Oct 2010 10:08:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.11) Gecko/20101013 Thunderbird/3.1.5
In-Reply-To: <1288299210-27092-1-git-send-email-gitster@pobox.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160316>

Am 10/28/2010 22:53, schrieb Junio C Hamano:
> "Corrupt" is already an adjective, ... we do not
> have to say "corrupted".

> + * This function dies on corrupted objects; the callers who want to

Except sometimes. ;)

-- Hannes
