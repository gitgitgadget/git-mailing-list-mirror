From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to display a simplified graph of commits ?
Date: Mon, 29 Mar 2010 16:01:53 +0200
Message-ID: <4BB0B2D1.507@viscovery.net>
References: <20100329132439.GA734@aldebaran.xn--kwg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Madore <david+news@madore.org>
X-From: git-owner@vger.kernel.org Mon Mar 29 16:02:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwFXW-0003Pw-8H
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 16:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab0C2OB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 10:01:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:23847 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0C2OB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 10:01:57 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NwFXO-0000KM-Df; Mon, 29 Mar 2010 16:01:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2B4AB1660F;
	Mon, 29 Mar 2010 16:01:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <20100329132439.GA734@aldebaran.xn--kwg.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143475>

Am 3/29/2010 15:24, schrieb David Madore:
> I'd like to know if the following is possible and, if not, I'd like to
> suggest it as a possible useful addition to the git frontend/graphical
> tools: display a simplified graph of "interesting" commits showing the
> relationship between a specified set of commits.

git log --graph --simplify-by-decoration

You have to tag the interesting commits to show up in this chart.

-- Hannes
