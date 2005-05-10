From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Mon, 9 May 2005 21:36:26 -0400
Message-ID: <118833cc05050918367319d740@mail.gmail.com>
References: <20050509233904.GB878@osuosl.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 03:33:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVJcS-0001w2-TQ
	for gcvg-git@gmane.org; Tue, 10 May 2005 03:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVEJBiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 21:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVEJBit
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 21:38:49 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:60761 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261519AbVEJBg0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 21:36:26 -0400
Received: by rproxy.gmail.com with SMTP id a41so885068rng
        for <git@vger.kernel.org>; Mon, 09 May 2005 18:36:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=moPqORlpz83XZRrPciNcV2z4jLjfN4Et6iupv2quxRaZRaKjsOXvU5XXz2wCAdNzQms4jYUt4i+SXdjc9+zpF4cwisUvfiqWYafKfaWGasb9KSqe9C1gG+ckgaoV+vd/aqYXVNsN19sWNdA3CJV7tqn1azh0ZryUMbNQdCllISo=
Received: by 10.38.151.37 with SMTP id y37mr1802221rnd;
        Mon, 09 May 2005 18:36:26 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Mon, 9 May 2005 18:36:26 -0700 (PDT)
To: Brandon Philips <brandon@ifup.org>
In-Reply-To: <20050509233904.GB878@osuosl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

And it is also unhappy when the directory is empty or contains dotfiles only.

Morten
