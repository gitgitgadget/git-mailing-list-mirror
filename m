From: Mark Struberg <struberg@yahoo.de>
Subject: RE: [JGIT PATCH 7/9] removing eclipse project files
Date: Thu, 24 Sep 2009 11:50:11 +0000 (GMT)
Message-ID: <212350.78171.qm@web27802.mail.ukl.yahoo.com>
References: <C89280B882467443A695734861B942B296767534@DEWDFECCR09.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: MatthiasSohn <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 13:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqmq4-00030U-Gj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 13:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZIXLuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 07:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZIXLuJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 07:50:09 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:45188 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751676AbZIXLuI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 07:50:08 -0400
Received: (qmail 78823 invoked by uid 60001); 24 Sep 2009 11:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1253793011; bh=IqsycR4vmC+3BqnQaMHB9of7QoDYs+qrPyjnAsRUBrU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=hY0JpV8AumNCtlHBbm3S80MLQaNPtr+RhSur53hslBPaaqbdHJw/3i5IxIZ6v4AVyqxsyyq7oDVYKVf1K1KuVdqH1QEx80Xb4kBhop9MrPHXX1k2ypZZL8Hce+TGQzvhCiB2drJu1X6Jpe0kdjd5F/C8rdwr0F0azCY79sOhUmw=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=JpOYqnqjlxnzTH2BWrM9ZLfVaqS5NbO1G0WIWP539JQXqocYEuiUPnr9JyAMlO0d6p40BN5vT2ENuLUdh6L8xP7sDef9Xskp8mkGvLCWhdybm0NGyK/0OHtL3AOCre2r4MD3jsVFraemUULb+2lOna4dHo33hRZTOzwOGTB494g=;
X-YMail-OSG: VHF.K_0VM1nbnFi1sev7Xpoi4nEeFxk3_eZGTBludN8vk0c6UTS4xqxxWrw_8k3uoPc4LkYNJ3ylPf8VzsDWZcV5T0t40nArTSKYfvpZyaSg2OIkuAjnjn41Ko8qZFqd3HwZED3vzB8wiboaVzz6ot3yaufZPUOumQa1R1sHDHOCNJnnR1vJCChVgNoGe.Es6AUg8WRmhcx04qqW1I6snsjvLal1kcnATdxG6VpQMcNXFtybty_ZRTmmPx6gStXn7YkHUEmkdfkHlb2N1oCme_SBQsE5dnEONCKgUwN6Slx4wco6QZNt
Received: from [81.16.153.112] by web27802.mail.ukl.yahoo.com via HTTP; Thu, 24 Sep 2009 11:50:11 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.2
In-Reply-To: <C89280B882467443A695734861B942B296767534@DEWDFECCR09.wdf.sap.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129039>

Hi Matthias!

the answer is a clear yes and no  - a 'jein' for german speaking people like you ;)

yes: we have the same settings for the compiler as used before: jdk 1.5 for source and target. This is exactly what has been taken in the ant build which was used prior to maven. 

Please note that the settings in org.eclipse.jdt.core.prefs never had (and must not have) any impact on the created jar!

and no: currently the very file you mentioned contains a lot more stuff. In fact most of this are only editor settings, preferred formattings etc which has nothing to do with the build per se. Eclipse has the ability to import/export all those settings in a XML file which is version independent. We should go this way and also supply similar setting-files for Idea and NetBeans. But forcing those settings via an internal Eclipse plugin config file is imho bad practice.

LieGrue,
strub

--- On Thu, 9/24/09, Sohn, Matthias <matthias.sohn@sap.com> wrote:

> From: Sohn, Matthias <matthias.sohn@sap.com>
> Subject: RE: [JGIT PATCH 7/9] removing eclipse project files
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "spearce@spearce.org" <spearce@spearce.org>
> Date: Thursday, September 24, 2009, 1:24 PM
> Can Maven control compiler settings
> on the same level as we do currently with 
> .settings/org.eclipse.jdt.core.prefs ?
> 


      
