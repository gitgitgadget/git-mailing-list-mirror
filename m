From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Thu, 29 Dec 2011 18:29:24 +0000
Message-ID: <20111229182924.GA32392@sirena.org.uk>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
 <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguy???n Th??i Ng???c Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 19:29:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgKjO-00032A-Hs
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 19:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1L2S3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 13:29:30 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60358 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1L2S33 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 13:29:29 -0500
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.72)
	(envelope-from <broonie@sirena.org.uk>)
	id 1RgKjE-0008Qx-Q2; Thu, 29 Dec 2011 18:29:24 +0000
Content-Disposition: inline
In-Reply-To: <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187781>

On Tue, Dec 27, 2011 at 01:52:35PM -0800, Junio C Hamano wrote:

> And if the answer to that tongue-in-cheek question is no, what is the
> reason why the users will not find the messages disturbing, while loathing
> the auto-gc?

The main problem I've noticed with the auto gc is that git gui seems to
want to do one at a much lower threashold than the command line tools
(and far too aggressive), it seems that the logic that determines when
to do one isn't quite in agreement within all the git tools.
