From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal
 supports it.
Date: Tue, 23 Oct 2007 08:37:43 +0200
Message-ID: <471D96B7.4080200@viscovery.net>
References: <20071022081341.GC32763@artemis.corp> <200710230608.15124.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkDP7-0002Kx-5j
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXJWGhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXJWGhr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:37:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32114 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbXJWGhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:37:46 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IkDOJ-0002qM-Ri; Tue, 23 Oct 2007 08:37:28 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 02AEA6C4; Tue, 23 Oct 2007 08:37:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200710230608.15124.chriscool@tuxfamily.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62113>

Christian Couder schrieb:
> Anyway, perhaps having:
> 
> _red=1
> _green=2
> 
> and then using "say_color $_red stuff" might be easier to understand and 
> change if needed.

Good idea. But then better name it by its purpose:

fail=1	# red
pass=2	# green

-- Hannes
