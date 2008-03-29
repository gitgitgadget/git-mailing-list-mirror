From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 08:19:07 +0100
Message-ID: <200803290819.07280.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <20080328212900.GB9656@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 08:20:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfVMu-0004cF-Jc
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 08:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYC2HUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 03:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYC2HUA
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 03:20:00 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27208 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbYC2HT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 03:19:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DDB9D800782;
	Sat, 29 Mar 2008 08:19:57 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QugjpHonrOu4; Sat, 29 Mar 2008 08:19:57 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0F91C8026E9;
	Sat, 29 Mar 2008 08:19:57 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080328212900.GB9656@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78449>

Den Friday 28 March 2008 22.29.01 skrev Jeff King:
> We always use 'utf-8' as the encoding, since we currently
> have no way of getting the information from the user.

Don't set encoding to UTF-8 unless it actually looks like UTF-8.

-- robin
