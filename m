From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] grep: do not segfault when -f is used
Date: Fri, 16 Oct 2009 15:46:02 +0200
Message-ID: <4AD8791A.8060500@viscovery.net>
References: <1255683204-28988-1-git-send-email-kraai@ftbfs.org> <4AD84C2F.5000809@viscovery.net> <20091016133908.GA3172@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 15:54:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynFR-0006Tq-J1
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 15:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759383AbZJPNql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759365AbZJPNql
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 09:46:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19595 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759077AbZJPNql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 09:46:41 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Myn87-0003gK-ES; Fri, 16 Oct 2009 15:46:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D4D3CA4A1; Fri, 16 Oct 2009 15:46:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091016133908.GA3172@ftbfs.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130486>

Matt Kraai schrieb:
> On Fri, Oct 16, 2009 at 12:34:23PM +0200, Johannes Sixt wrote:
>> there must be a better way to test whether grep -f behaves correctly.
> 
> How about the following test cases instead?

*MUCH* better! Now, if you could wrap them up in a patch...

-- Hannes
