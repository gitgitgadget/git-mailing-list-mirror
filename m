From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Compact view of history in gitk
Date: Tue, 29 Sep 2009 14:07:42 +0200
Message-ID: <4AC1F88E.7080802@viscovery.net>
References: <4AC1F435.4030802@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 14:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsbUm-0001wA-AU
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 14:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbZI2MHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 08:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbZI2MHn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 08:07:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17632 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbZI2MHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 08:07:42 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MsbUd-0007je-5z; Tue, 29 Sep 2009 14:07:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D5CFBBC81; Tue, 29 Sep 2009 14:07:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AC1F435.4030802@ubicom.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129296>

Yakup Akbay schrieb:
> Think of the gitk version of the history below:
> 
>                  E-*-*-*-F
>                 /
> A-*-*-*-*-*-*-B-C-*-*-*-D
>               \
>                G-*-*-H-*-*-*-I
>                       \
>                        J-*-*-*-*-*-K
> 
> 
> I want an output like this:
> 
>        E-~-F
>       /
> A-~-B-C-~-D
>     \
>      G-~-H-~-I
>           \
>            J-~-K
> 
> Is there an option in gitk (or in any other tool) to get such a view?

I think, --simplify-by-decoration comes close, even though it may not be
100% what you describe.

-- Hannes
