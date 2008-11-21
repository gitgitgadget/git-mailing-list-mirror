From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: [PATCH] git-send-email: provide hook to send lines more than
	998 symbols
Date: Fri, 21 Nov 2008 21:34:53 +1100
Message-ID: <1227263693.3311.0.camel@therock.nsw.bigpond.net.au>
References: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 13:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3VYD-0005La-3N
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYKUMyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYKUMyl
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:54:41 -0500
Received: from nskntqsrv01p.mx.bigpond.com ([61.9.168.231]:39064 "EHLO
	nskntqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752664AbYKUMyl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2008 07:54:41 -0500
Received: from nskntotgx03p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas01p.mx.bigpond.com with ESMTP
          id <20081121102402.DMME18010.nskntmtas01p.mx.bigpond.com@nskntotgx03p.mx.bigpond.com>;
          Fri, 21 Nov 2008 10:24:02 +0000
Received: from therock.local ([58.173.132.215])
          by nskntotgx03p.mx.bigpond.com with ESMTP
          id <20081121102401.EWBJ1879.nskntotgx03p.mx.bigpond.com@therock.local>;
          Fri, 21 Nov 2008 10:24:01 +0000
In-Reply-To: <1227261564-13268-1-git-send-email-andy.shevchenko@gmail.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150204.49268C42.0007,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101524>

On Fri, 2008-11-21 at 11:59 +0200, Andy Shevchenko wrote:
> By default git-send-email does not accept patch which is contain lines longer
> than 998 symbols. Sometime it's inconvenient, i.e. you have a long list in one
> variable in shell script. So, define environment variable
> GIT_SEND_EMAIL_LONGLINE to something to avoid that restriction.

As a curiosity, why is such a check even neccessary?
