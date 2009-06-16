From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv3 2/4] git-sh-setup: introduce say() for quiet options
Date: Tue, 16 Jun 2009 10:13:12 +0200
Message-ID: <4A375418.8050401@viscovery.net>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com> <1245117905-19351-2-git-send-email-bebarino@gmail.com> <1245117905-19351-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 10:13:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGTnO-0002V5-8q
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 10:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbZFPINV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 04:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbZFPINU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 04:13:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:62519 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbZFPINT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 04:13:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MGTn7-0006wD-6m; Tue, 16 Jun 2009 10:13:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DB8A0C6C1; Tue, 16 Jun 2009 10:13:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1245117905-19351-3-git-send-email-bebarino@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121666>

Stephen Boyd schrieb:
> +say () {
> +	if test -z "$GIT_QUIET"
> +	then
> +		printf "%s" "$*"
> +		echo

You can squash these two lines into

		printf '%s\n' "$*"

-- Hannes
