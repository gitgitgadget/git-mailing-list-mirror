From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Don't select the wrong file if the last listed
 file is staged.
Date: Wed, 25 Jun 2008 12:49:10 +0200
Message-ID: <486222A6.70205@viscovery.net>
References: <1213308730-12707-1-git-send-email-ams@toroid.org> <20080625103650.GA20492@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:50:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBSZo-0004XB-Fr
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbYFYKtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbYFYKtN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:49:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48087 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYFYKtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:49:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KBSYo-0001fz-Em; Wed, 25 Jun 2008 12:49:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4662BAFCC; Wed, 25 Jun 2008 12:49:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080625103650.GA20492@toroid.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86271>

Abhijit Menon-Sen schrieb:
> Johannes Sixt noticed that if the last file in the list was staged, my
> earlier patch would display the diff for the penultimate file, but show
> the file _before_ that as being selected.
> 
> This was due to my misunderstanding the lno argument to show_diff.
> 
> This patch fixes the problem: lno is not decremented in the special case
> to handle the last item in the list (though we still need to use $lno-1
> to find the right path for the next diff).

Thanks. It works here, too:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
