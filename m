From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Expose the raw timezone offset from PersonIdent
Date: Sat, 6 Sep 2008 17:05:56 +0200
Message-ID: <200809061705.56879.robin.rosenberg.lists@dewire.com>
References: <1220578639-11723-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 06 17:09:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbzQ9-0003df-2V
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 17:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbYIFPIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 11:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYIFPIq
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 11:08:46 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:49190 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYIFPIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 11:08:45 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id C18B737F40; Sat,  6 Sep 2008 17:08:43 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id A0F2B37F40; Sat,  6 Sep 2008 17:08:43 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 67DC237E42;
	Sat,  6 Sep 2008 17:08:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1220578639-11723-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95076>

fredagen den 5 september 2008 03.37.19 skrev Shawn O. Pearce:
> Applications may wish to have this value, much as they
> can get the raw seconds-since-epoch and reformat it
> for their own uses.

Necessary (performance) or just nice? We already provide the
timezone in java.util format.

-- robin
