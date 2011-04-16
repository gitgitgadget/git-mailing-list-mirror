From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] status: store format option as an int
Date: Sat, 16 Apr 2011 00:29:59 -0500
Message-ID: <20110416052959.GB10807@elie>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
 <20110416004544.GA5628@elie>
 <20110416013723.GA23105@sigill.intra.peff.net>
 <20110416052704.GA10807@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 07:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAy5E-0007LC-1b
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 07:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab1DPFaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 01:30:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49668 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1DPFaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 01:30:04 -0400
Received: by iyb14 with SMTP id 14so2630109iyb.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=F4Qaf4hqR0Fhig+H3lRUfJndVwjQ/EgCPSd3fOw3VV8=;
        b=WnIYdZmulm7zguRihkxdr6l7VCmRi3nq+ktHDBK7viea/bxdoo2L8kPeaFQH9FQk5t
         P1mH/g6ghsXgUWHr++tmeYZfRiCvknDOOZjyYEYJYSDLclVZ9N47mQ8zXqAUy0DXgimX
         7eoAxB98mVmvMfeoXyrGyUVozfvIl2VCfdjgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kLSouVTEiOhz0OUwUF8UA2on4HoW8WWxgBr2MYEVeIX+ve6W1csllLa/4AVBoLK0ef
         ogDdIFXbCaJMk/Ot/aU0lQzvunAdiLBSHzirH/VM/L2DJ3PJZrhXRNVcorRwkNFGl0n5
         EqmuwjXKw3Bc9qAd9XhJYdm8sjs29yJsZ0GDs=
Received: by 10.231.123.165 with SMTP id p37mr1039453ibr.10.1302931804060;
        Fri, 15 Apr 2011 22:30:04 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.sbcglobal.net [69.209.51.5])
        by mx.google.com with ESMTPS id 19sm1938874ibx.52.2011.04.15.22.30.02
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 22:30:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110416052704.GA10807@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171658>

Jonathan Nieder wrote:

> It is unsafe to pass a pointer to a value of enumerated type to
> OPT_SET_INT (as v1.7.0-rc0~137^2~14, 2009-0905) does, since it might

Agh, proofreading fail.  For the confused, this is supposed to read as
"(as v1.7.0-rc0~137^2~14, status: refactor format option parsing,
2009-09-05) does".
