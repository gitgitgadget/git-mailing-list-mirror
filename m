From: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
Subject: git fast-import --export-marks flag
Date: Mon, 28 Mar 2011 18:16:23 +0200
Message-ID: <4D90B457.9040607@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 18:16:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4F7M-0006uI-7F
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 18:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab1C1QQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 12:16:29 -0400
Received: from berith.lunarbreeze.com ([216.97.239.175]:48666 "EHLO
	berith.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1C1QQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 12:16:27 -0400
Received: from 198.red-80-28-79.adsl.dynamic.ccgg.telefonica.net ([80.28.79.198] helo=[192.168.2.33])
	by berith.lunarbreeze.com with esmtpa (Exim 4.69)
	(envelope-from <psantosl@codicesoftware.com>)
	id 1Q4F7A-0003Pe-DU
	for git@vger.kernel.org; Mon, 28 Mar 2011 09:16:24 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - berith.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - codicesoftware.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170149>

Hi,

git fast-import --export-marks is able to export to a file the marks and
its associated commit hashes created during import.

So far I've seen the marks are not the ones provided in the input but
some "internal ones" not related with the input.

Wouldn't it be much better, for import/export interop, if it kept the
original marks?

It would be certainly easier to do incremental import/export with
external systems not dealing with SHAs...

Thanks,

pablo
