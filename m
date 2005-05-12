From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Fri, 13 May 2005 03:12:13 +1000
Message-ID: <2cfc4032050512101211bc030b@mail.gmail.com>
References: <1895.10.10.10.24.1115890333.squirrel@linux1>
	 <1115896713.22180.314.camel@tglx>
	 <3745.10.10.10.24.1115897090.squirrel@linux1>
	 <1115898230.11872.8.camel@tglx>
	 <20050512132922.GB20785@delft.aura.cs.cmu.edu>
	 <2cfc4032050512084426ea3d4d@mail.gmail.com>
	 <2cfc403205051208483132921@mail.gmail.com>
	 <2cfc403205051208506249c9aa@mail.gmail.com>
	 <20050512162023.GA14010@delft.aura.cs.cmu.edu>
	 <2cfc403205051210093e1a396d@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 12 19:05:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWH71-0006DC-1b
	for gcvg-git@gmane.org; Thu, 12 May 2005 19:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVELRMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVELRMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 13:12:16 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:17493 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262081AbVELRMN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 13:12:13 -0400
Received: by rproxy.gmail.com with SMTP id i8so86006rne
        for <git@vger.kernel.org>; Thu, 12 May 2005 10:12:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gI4iGKoE9IKrkZ57pX/vFgMks1ABa4K2PYTEK0PXo19B/u07/k0YM66Iifp27guxYUa3cy0o7m/ol0v9Pb0hMONYhmkia4vvQiMVe8m2HL7QhL4aU9YxEIvKzfULeOH5h2oeLsQ7ISdPgNUt+3j1X5uewdq+/VWYJq6O6egasI4=
Received: by 10.38.104.76 with SMTP id b76mr285378rnc;
        Thu, 12 May 2005 10:12:13 -0700 (PDT)
Received: by 10.38.104.37 with HTTP; Thu, 12 May 2005 10:12:13 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205051210093e1a396d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

| added "local" to clarify what I meant the first-pass should do

> My previous algorithm was incorrect, but I suspect it could probably
> be fixed with a 2-pass algorithm that marked any nodes in the "local" path
> between the merge base and the merge head as local and then ensured
> that nodes marked that way are sorted after any nodes reached via
> "foreign" paths.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
