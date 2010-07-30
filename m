From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t4111 fails under valgrind
Date: Fri, 30 Jul 2010 20:39:05 +0200
Message-ID: <201007302039.05491.trast@student.ethz.ch>
References: <201007301218.52437.trast@student.ethz.ch> <20100730183122.GA7578@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 20:40:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuVG-0007wO-8i
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275Ab0G3Sjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:39:55 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:17484 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933328Ab0G3Sjc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:39:32 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 20:39:29 +0200
Received: from thomas.site (129.132.210.200) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul
 2010 20:39:08 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100730183122.GA7578@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152258>

Jonathan Nieder wrote:
> Thanks for reporting.  Does this patch work for you?
[...]
> -		cp "$2" objects/file
> +		cp "$2" objects/file &&
> +		test_might_fail git update-index --refresh -q

Yes, that solves it.  Thanks!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
