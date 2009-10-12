From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] git: add --no-replace option to disable replacing
Date: Mon, 12 Oct 2009 08:32:10 +0200
Message-ID: <4AD2CD6A.2020509@viscovery.net>
References: <20091011153227.8487.81803.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 08:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxEWt-0003Iw-0t
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 08:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbZJLGcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 02:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZJLGcx
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 02:32:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8276 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZJLGcx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 02:32:53 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MxES3-0000M6-4Y; Mon, 12 Oct 2009 08:32:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D416E4E4; Mon, 12 Oct 2009 08:32:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091011153227.8487.81803.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129989>

Christian Couder schrieb:
> So there is no way to disable it for some commands, which is annoying
> when we want to get information about a commit that has been replaced.
> 
> For example:
> 
> $ git cat-file -p N
> 
> would output information about the replacement commit if commit N is
> replaced.
> 
> With the "--no-replace" option that this patch adds it is possible to
> get information about the original commit using:
> 
> $ git --no-replace cat-file -p N

I think it makes sense. But given the exotic nature of this option, I'd
prefer a more specific name, e.g., --no-replace-objects.

-- Hannes
