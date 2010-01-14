From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Test t5560: Fix test when run with dash
Date: Thu, 14 Jan 2010 09:23:24 +0100
Message-ID: <4B4ED47C.1050300@alum.mit.edu>
References: <4B4EAB58.6040901@alum.mit.edu> <1263452477-15250-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:25:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVL1F-00011D-9X
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab0ANIZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772Ab0ANIZX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:25:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59871 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab0ANIZX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:25:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E8NOtk013268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jan 2010 09:23:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <1263452477-15250-1-git-send-email-tarmigan+git@gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136964>

Tarmigan Casebolt wrote:
> dash is more finicky than some shells and this change seems to make it
> happier.
> 
> Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
> 
> ---
> Michael, thanks for the report.
> 
> Ubuntu's /bin/sh is dash, which I had not tested with.  Installing
> dash on my machine, I was able to reproduce and this patch fixes the
> problem for me.
> 
> Could you please see if this works for you?
> [...]

Yes, that fixes it.  Thanks!

Michael
