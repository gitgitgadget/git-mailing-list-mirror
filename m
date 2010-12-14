From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname
 concatenation
Date: Tue, 14 Dec 2010 08:32:58 +0100
Message-ID: <4D071DAA.3070400@viscovery.net>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com> <1292233616-27692-10-git-send-email-pclouds@gmail.com> <7vlj3t35ol.fsf@alter.siamese.dyndns.org> <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com> <7vvd2wvs0m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 08:33:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSPNi-00066k-T1
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 08:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755949Ab0LNHdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 02:33:00 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65336 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab0LNHc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 02:32:59 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PSPNa-0005N3-OW; Tue, 14 Dec 2010 08:32:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7C80C1660F;
	Tue, 14 Dec 2010 08:32:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vvd2wvs0m.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163632>

Am 12/14/2010 6:32, schrieb Junio C Hamano:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> All paths should not exceed PATH_MAX, right?
> 
> Your PATH_MAX may be a lot shorter than the PATH_MAX on the system I
> created my trees on that you are reading.

And that is not just gray theory: On Windows, PATH_MAX is whopping 260
characters!

-- Hannes
