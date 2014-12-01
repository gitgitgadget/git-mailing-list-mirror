From: Christoph Mallon <mallon@cs.uni-saarland.de>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Mon, 01 Dec 2014 17:00:08 +0100
Message-ID: <547C9088.7000800@cs.uni-saarland.de>
References: <547C8610.8080301@cs.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 17:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvTOc-0002js-SU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 17:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbaLAQAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 11:00:12 -0500
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:22871 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaLAQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 11:00:11 -0500
Received: from laptop-cm.absint.com (mail.absint.com [212.88.138.67])
	(authenticated bits=0)
	by theia.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id sB1G08Fb019254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 1 Dec 2014 17:00:09 +0100
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.5 at HIZ-Mailrelay theia.rz.uni-saarland.de
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <547C8610.8080301@cs.uni-saarland.de>
X-Enigmail-Version: 1.4
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (theia.rz.uni-saarland.de [134.96.7.31]); Mon, 01 Dec 2014 17:00:09 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260488>

This commit seems to introduce the bug:
4207ed285f31ad3e04f08254237c0c1a1609642b
