From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Wed, 28 Nov 2007 00:14:53 +0100
Message-ID: <200711280014.55114.robin.rosenberg@dewire.com>
References: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com> <474BD90C.5020102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix9c7-0008Hf-Ff
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755697AbXK0XMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbXK0XMu
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:12:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12880 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbXK0XMt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:12:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 42F748026F5;
	Wed, 28 Nov 2007 00:03:31 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05022-03; Wed, 28 Nov 2007 00:03:30 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D242E800199;
	Wed, 28 Nov 2007 00:03:30 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <474BD90C.5020102@viscovery.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66269>

tisdag 27 november 2007 skrev Johannes Sixt:
> Robin Rosenberg schrieb:
> > +test_expect_success 'add files using absolute path names' '
> > +echo a >afile &&
> > +echo b >bfile &&
> > +git-add afile &&
> > +git-add $(pwd)/bfile &&
> 
> Please use "$(pwd)/bfile" (d-quotes) throughout. Otherwise the test would 
> fail if conducted in a directory with spaces.

AFAIK, None of the tests works in directories with spaces. But I'll fix it, just in case, so 
noone can blame /me/ for the tests breaking in /my home/. I cannot verify it because
the testing infrastructure breaks before the actual tests start executing.

-- robin
