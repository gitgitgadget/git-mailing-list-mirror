From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: "Sparse checkout leaves no entry on working directory" all the
 time on Windows 7 on Git 1.8.5.2.msysgit.0
Date: Thu, 06 Feb 2014 14:20:29 +0100
Message-ID: <52F38C1D.709@viscovery.net>
References: <web-57771132@mx45.intranet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: konstunn@ngs.ru, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 14:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBOsi-0007pW-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 14:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbaBFNUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 08:20:36 -0500
Received: from so.liwest.at ([212.33.55.18]:50317 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756522AbaBFNUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 08:20:35 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WBOsX-0001wu-Rh; Thu, 06 Feb 2014 14:20:30 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 97AF816613;
	Thu,  6 Feb 2014 14:20:29 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <web-57771132@mx45.intranet.ru>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241691>

Am 2/6/2014 12:54, schrieb konstunn@ngs.ru:
> However I typed the checkout directory in file
> ..git/info/sparse-checkout by using different formats with
> and without the leading and the trailing slashes, with and
> without asterisk after trailing slash, having tried all
> the possible combinations, but, all the same,
> nevertheless, the error occured.

Make sure that you do not use CRLF line terminators in the sparse-checkout
file.

-- Hannes
