From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Mini bug report origin/pu: t1512 failed on Mac OS X (commit 
 957d74062c1f0e ?)
Date: Thu, 12 Jul 2012 09:21:14 +0200
Message-ID: <4FFE7AEA.6060001@viscovery.net>
References: <4FFDDD5E.3080309@web.de> <7vipdtdhla.fsf@alter.siamese.dyndns.org> <7va9z5dgff.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 09:21:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpDid-0006xT-D8
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 09:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab2GLHVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 03:21:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13868 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab2GLHVP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 03:21:15 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SpDjg-00068a-88; Thu, 12 Jul 2012 09:22:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3D6991660F;
	Thu, 12 Jul 2012 09:21:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7va9z5dgff.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201349>

Am 7/12/2012 1:30, schrieb Junio C Hamano:
> -	test "$(wc -l <actual)" = 16 &&
> +	test $(wc -l <actual) = 16 &&

We have a helper function for this:

	test_line_count = 16 actual &&

-- Hannes
