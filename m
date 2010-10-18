From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] merge-file: correctly find files when called in
 subdir
Date: Mon, 18 Oct 2010 08:10:35 +0200
Message-ID: <4CBBE4DB.6080307@viscovery.net>
References: <64b470380b8f7bd8afe8f019553cb99f72091c7d.1287342969.git.trast@student.ethz.ch> <d0e540fdced31557e983d7503da3dcb75c622dc9.1287342969.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 18 08:10:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ivn-0008Ke-8q
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 08:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0JRGKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 02:10:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20951 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0JRGKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 02:10:40 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P7ivb-0003cb-TD; Mon, 18 Oct 2010 08:10:36 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8377C1660F;
	Mon, 18 Oct 2010 08:10:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <d0e540fdced31557e983d7503da3dcb75c622dc9.1287342969.git.trast@student.ethz.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159233>

Am 10/17/2010 21:23, schrieb Thomas Rast:
> With the last patch, we can safely pass a zero prefix length to say
> "there was no prefix".
> 
> This is a slight semantic change on Windows, because it now
> substitutes / for \ in paths, but I suppose that's harmless?

Yes, it should be harmless.

-- Hannes
