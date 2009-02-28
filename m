From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 14:43:33 -0800
Message-ID: <e38bce640902281443x69bd64ebuf4aa784be220b6bb@mail.gmail.com>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
	 <20090228045531.14399ebf@perceptron>
	 <e38bce640902280824x3ae41d95qab1f1a450235e096@mail.gmail.com>
	 <76718490902280852y2f2657ck7459c138205bb874@mail.gmail.com>
	 <e38bce640902280934u3d9da650ke64865d7149b3c66@mail.gmail.com>
	 <20090228183427.GN4505@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 23:45:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdXw1-0002QL-1p
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 23:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbZB1Wnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 17:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754242AbZB1Wng
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 17:43:36 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:49029 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbZB1Wnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 17:43:35 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1199803ywh.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0SpOtQl5rCvXXDDyXQ2JLqLA1UCnWuDLv1xBCblJrGs=;
        b=UT+wnwMFGEw/HUciPN4aFlRBo1c9F84NyFS0UdH976bK+WiGzo8qMhtblm4T8Qbj/O
         3MHDZgT1UdpZH5AdV8m8sXCVAaXE0mB/mJhPxjR0dKdSzTz/ENbcJdcJ1eH0soe51GQs
         Sf/foDMPvlLO8XqQ+wJCVKHsEq4HNffJuDYjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=evKnbhOB2JlhMKlXXB+mpy5W+SILO2ZmSTCjoNNBN0rr1dl7OQOwTqkOpcAXwINyQX
         9IkjUOZ47xxjUo05+XETORLwM8wgtwThQ6eDp5H5mL4eJH3CXywtcKkvHQxIcoVrW61M
         eYdT3oMe32onGkLTzrNjMmEUEUn1oDRH6YUpY=
Received: by 10.90.115.17 with SMTP id n17mr1985405agc.31.1235861013412; Sat, 
	28 Feb 2009 14:43:33 -0800 (PST)
In-Reply-To: <20090228183427.GN4505@inocybe.teonanacatl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111797>

On Sat, Feb 28, 2009 at 10:34 AM, Todd Zullinger <tmz@pobox.com> wrote:
> You may want to check contrib/hooks/setgitperms.perl as well, if you
> haven't seen it already.

Yes I did see that. I'll be varying that approach a bit since I won't
need to preserve perm bits before and after the git operation, but
just force them to be a specific value all the time after checkout and
update.

bg
