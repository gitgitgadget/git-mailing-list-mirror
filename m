From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 14:06:03 +0400
Message-ID: <20070329100602.GM59098@codelabs.ru>
References: <20070327110714.GA14837@codelabs.ru> <7vps6um8wv.fsf@assigned-by-dhcp.cox.net> <20070328091209.GQ14837@codelabs.ru> <7vps6tf8te.fsf@assigned-by-dhcp.cox.net> <20070329074424.GD59098@codelabs.ru> <7vwt107a3g.fsf@assigned-by-dhcp.cox.net> <20070329082908.GH59098@codelabs.ru> <7v7it04fbo.fsf@assigned-by-dhcp.cox.net> <20070329085834.GJ59098@codelabs.ru> <20070329091239.GA8905@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 12:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWrWN-00082D-M6
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 12:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934064AbXC2KGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 06:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934073AbXC2KGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 06:06:16 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:64453 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934064AbXC2KGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 06:06:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=B3rn8Jpov3ZyCRnNR2FnhFfXdHecvcgRrJaor/G+Nm+ClSQDYuj865UaP9M6E6AsuIn/Znc3iFc3aJTFWMn1leAUmZX6JI9cbnVr2JALNtIaxBufDSOGi+1rBwuWk5a53Jnw2rZCO/q69SaDvkiq5DKoHFpd9n6VWmaOjtHTB+Y=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HWrWE-000DvM-3s; Thu, 29 Mar 2007 14:06:10 +0400
Content-Disposition: inline
In-Reply-To: <20070329091239.GA8905@hermes>
X-Spam-Status: No, score=-2.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43423>

Tom, good day.

Thu, Mar 29, 2007 at 01:12:39PM +0400, Tom Prince wrote:
> Definitely, when cross compiling, or generating packages, you often
> don't even have the program installed in the right place, so erroring
> out is the wrong thing to do in this case.

OK, the patch follows.
-- 
Eygene
