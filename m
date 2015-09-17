From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Thu, 17 Sep 2015 23:31:43 +0200
Message-ID: <20150917213143.GE606@cruxbox>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
 <CAPig+cRCF1prBKRCUdEZwiA5=VshMcYPi9Fo5bHxD2Fp8wgrfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 21:31:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZceuC-0002tD-D6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 21:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbbIQTbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 15:31:35 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42292 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbbIQTbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 15:31:35 -0400
X-Greylist: delayed 1091 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2015 15:31:35 EDT
Received: from mfilter25-d.gandi.net (mfilter25-d.gandi.net [217.70.178.153])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id D3417C5A46;
	Thu, 17 Sep 2015 21:31:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter25-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter25-d.gandi.net (mfilter25-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id FjLVEL_pM29N; Thu, 17 Sep 2015 21:31:32 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D22F1C5A43;
	Thu, 17 Sep 2015 21:31:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAPig+cRCF1prBKRCUdEZwiA5=VshMcYPi9Fo5bHxD2Fp8wgrfg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278163>

On Thu, Sep 17, 2015 at 03:25:00PM -0400, Eric Sunshine wrote:
> On Thu, Sep 17, 2015 at 5:12 PM, Remi Pommarel <repk@triplefau.lt> wrote:
> > For static linking especially library order while linking is important. For
> > example libssl contains symbol from libcrypto so the farmer should be linked
> 
> I hope you meant: s/farmer/former/
> 

Oups sorry for the typo, yes I did mean former.
