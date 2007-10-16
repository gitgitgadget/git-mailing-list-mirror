From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] cvsexportcommit: get rid of temporary directory
Date: Tue, 16 Oct 2007 23:22:47 +0200
Message-ID: <200710162322.47324.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0710152332230.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhtqE-0002WP-CY
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 23:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965757AbXJPVUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 17:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965630AbXJPVUU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 17:20:20 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19539 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S965621AbXJPVUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 17:20:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7E6D6802655;
	Tue, 16 Oct 2007 23:11:39 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02007-08; Tue, 16 Oct 2007 23:11:39 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 2482680266D;
	Tue, 16 Oct 2007 23:11:39 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0710152332230.25221@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61257>

tisdag 16 oktober 2007 skrev Johannes Schindelin:
> 
> Since commit e86ad71fe5f53ae4434566bd09ea4256090e5a3a we do not use
> a temporary directory in cvsexportcommit.  So there is no need to set
> one up.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked

Discovered because Wingit made a lot of noise about $tmpdir being used only
once. 

-- robin
