From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 2/2] filter-branch: nearest-ancestor rewriting outside
 subdir filter
Date: Thu, 29 Oct 2009 08:38:47 +0100
Message-ID: <4AE94687.3070009@viscovery.net>
References: <6e01558f719f4bfcd12f3c6dc5657790e86c874d.1256770377.git.trast@student.ethz.ch> <a11809cee976bb42102dbd9b2afb06b9e5b587bf.1256770377.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 29 08:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Pav-0004Yz-SU
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 08:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZJ2Hio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 03:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752197AbZJ2Hio
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 03:38:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65395 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbZJ2Hin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 03:38:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N3Pap-0004bK-Em; Thu, 29 Oct 2009 08:38:47 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 43C844E4; Thu, 29 Oct 2009 08:38:47 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <a11809cee976bb42102dbd9b2afb06b9e5b587bf.1256770377.git.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131570>

Thomas Rast schrieb:
> @@ -358,7 +365,7 @@ done <../revs
>  # revision walker.  Fix it by mapping these heads to the unique nearest
>  # ancestor that survived the pruning.
>  
> -if test "$filter_subdir"
> +if test "$remap_to_ancestor" = t
>  then

The comment whose last lines are in the context of this hunk talks about
"subdirectory filter". You may want to revise it.

-- Hannes
