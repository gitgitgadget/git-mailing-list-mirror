From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 02/18] parse-options: add two helper functions
Date: Thu, 5 Aug 2010 22:43:46 +0200
Message-ID: <201008052243.46738.trast@student.ethz.ch>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com> <1281024717-7855-3-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:09:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7gn-00009I-9F
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082Ab0HEVJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 17:09:08 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:31066 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932576Ab0HEVJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:09:05 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 5 Aug
 2010 23:09:04 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 5 Aug 2010 23:09:03
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1281024717-7855-3-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152717>

Bo Yang wrote:
> 2. parse_options_next: make the API to deal with the next
>    option/argument.

Now that I'm re-reading it, this would be clearer as

2. parse_options_next: skip the current argument, moving to the next
   one.  Unless 'keep' is set, discard the skipped argument from the
   final argument list.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
