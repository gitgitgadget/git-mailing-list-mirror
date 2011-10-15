From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 17:17:11 -0500
Message-ID: <20111015221711.GA17470@elie.hsd1.il.comcast.net>
References: <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
 <20111014211244.GA16429@sigill.intra.peff.net>
 <20111014211921.GB16429@sigill.intra.peff.net>
 <CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
 <7vk486x0hq.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
 <m3r52e7js7.fsf@localhost.localdomain>
 <20111015082647.GA7302@elie.hsd1.il.comcast.net>
 <7vzkh1vrdq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCXr-0000uX-57
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1JOWR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:17:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38498 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab1JOWR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 18:17:26 -0400
Received: by gyb13 with SMTP id 13so2063207gyb.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 15:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+wZs/aPSr5ln8k/EeuvGiXKhwdVSJC2yd2WtPyLejp8=;
        b=WXGNQ33m6CCu63XdKXXAgJ/rtCkRBL84GJJvciAfTKCrVFt/HUEyHiIYYIRkO58PUH
         OtmeGm++eFlhcGcaYlwja1r2nrEmzsxEMJyXk0lreeHBbHBNew2CjIH+zYLrS7e5DvrU
         4tBrc7wzyYWv68OkQLwmiFC3Y9oDr5lAP770c=
Received: by 10.100.78.11 with SMTP id a11mr2896905anb.111.1318717046132;
        Sat, 15 Oct 2011 15:17:26 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 19sm6773533and.8.2011.10.15.15.17.24
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 15:17:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkh1vrdq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183679>

Junio C Hamano wrote:

> The admin has access to logs that record the real cause anyway, no?

Yes, you're right.  If this is a good admin then she will look at the
logs, preventing the back-and-forth Sitaram described.

Though that doesn't really change anything fundamental.  It seems nice
to remind the end user to check for typos, too.
