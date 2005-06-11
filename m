From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: split Makefile targets of Cogito/git
Date: Sat, 11 Jun 2005 15:09:18 -0700
Message-ID: <7vbr6csfzl.fsf@assigned-by-dhcp.cox.net>
References: <20050611195033.GA22713@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 00:05:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhE6Z-0005pc-DZ
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 00:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVFKWJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVFKWJX
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 18:09:23 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12703 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261267AbVFKWJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 18:09:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611220919.JPOY12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 18:09:19 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <20050611195033.GA22713@vrfy.org> (Kay Sievers's message of
 "Sat, 11 Jun 2005 21:50:33 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "KS" == Kay Sievers <kay.sievers@vrfy.org> writes:

KS> -
KS> -all: $(PROG) $(GEN_SCRIPT)
KS> -
KS> +.PHONY: all it cogito
KS> +all: git cogito
KS> +git: $(PROG)
KS> +cogito: $(GEN_SCRIPT)
 
(Tongue in cheek)  How about this instead ;^) 

    -
    -all: $(PROG) $(GEN_SCRIPT)
    -
    +.PHONY: all git coo
    +all: git coo
    +git: $(PROG)
    +coo: $(GEN_SCRIPT)


