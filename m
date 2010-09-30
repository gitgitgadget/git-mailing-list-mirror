From: <nolan.ring@emc.com>
Subject: Svn2git: question about --branches
Date: Thu, 30 Sep 2010 07:49:02 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B15CB469@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 30 13:50:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HeD-0003yM-S4
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0I3Lts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:49:48 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:53171 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642Ab0I3Ltr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 07:49:47 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8UBnkbx010851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 07:49:46 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.251]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor) for <git@vger.kernel.org>; Thu, 30 Sep 2010 07:49:37 -0400
Received: from corpussmtp5.corp.emc.com (corpussmtp5.corp.emc.com [128.221.166.229])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8UBn5if015319
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 07:49:05 -0400
Received: from mxhub01.corp.emc.com ([10.254.141.103]) by corpussmtp5.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 30 Sep 2010 07:49:04 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub01.corp.emc.com
 ([10.254.141.103]) with mapi; Thu, 30 Sep 2010 07:49:04 -0400
Thread-Topic: Svn2git: question about --branches 
Thread-Index: ActglXpNieCjN+O/QoSPFn9Cq7Tkbg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 30 Sep 2010 11:49:04.0609 (UTC) FILETIME=[7B5A2510:01CB6095]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157646>

Hi,

Our svn directory structure at the top level is:

trunk
branches
REbranches
tags

Branches is developer branches; REbranches is release engineering branches.  Is there any way to specify both using --branches?  If not, what's the best way to convert both of them?

Thanks much for your help.

Nolan Ring
