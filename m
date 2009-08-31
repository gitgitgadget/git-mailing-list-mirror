From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is given
Date: Mon, 31 Aug 2009 20:33:02 +0200
Message-ID: <4A9C175E.6020905@hartwork.org>
References: <20090805201937.GB9004@coredump.intra.peff.net> <20090805202326.GC23226@coredump.intra.peff.net> <7vhbwm0zcs.fsf@alter.siamese.dyndns.org> <20090805204835.GA24539@coredump.intra.peff.net> <7vws5ix9dz.fsf@alter.siamese.dyndns.org> <20090805211700.GA24697@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiBlx-0004tJ-62
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 20:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbZHaSiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 14:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZHaSiP
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 14:38:15 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:50390 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbZHaSiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 14:38:14 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Aug 2009 14:38:14 EDT
Received: from [85.179.29.7] (helo=[192.168.0.3])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1MiBgd-0002P9-Bq; Mon, 31 Aug 2009 20:33:03 +0200
User-Agent: Thunderbird 2.0.0.22 (X11/20090820)
In-Reply-To: <20090805211700.GA24697@coredump.intra.peff.net>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127490>

Hello!


I run git push in a cron job, too.  I want mails in error cases only
so I need git push to print errors but _only_ errors to stderr.  That
seems impossible with 1.6.4.* and related to what you're discussing here.

Does the patch you're building address that case already?  has it been
applied to any branch already?  I got a bit lost in this thread, sorry.



Sebastian
