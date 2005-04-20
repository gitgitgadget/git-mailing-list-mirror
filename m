From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 23:41:14 +1000
Message-ID: <2cfc4032050420064167186802@mail.gmail.com>
References: <200504191250.10286.mason@suse.com>
	 <200504191708.23536.mason@suse.com>
	 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
	 <200504192049.21947.mason@suse.com>
	 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
	 <42660708.60109@zytor.com>
	 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
	 <2cfc403205042005116484231c@mail.gmail.com>
	 <20050420132446.GA10126@macavity>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 20 15:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOFO9-0004sw-AQ
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 15:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDTNlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 09:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVDTNlT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 09:41:19 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:4238 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261624AbVDTNlP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 09:41:15 -0400
Received: by rproxy.gmail.com with SMTP id c51so140200rne
        for <git@vger.kernel.org>; Wed, 20 Apr 2005 06:41:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TWWgJIGw+fRracvbyl7xAOtprhIRvzwoPKYjh8Xgyw5RuELEEzGISntcqv6rcwxJjQ5OoczhzN/Ht1Xi+hUwP8Vp8kYiaHF+JxAwu4eb7Vj2yl2nn37f5tmX9D1QjCvaw/9z4xMWfCJPp/HPKlExs6ygBt/llu9LYDv+mWpWn28=
Received: by 10.38.15.7 with SMTP id 7mr872481rno;
        Wed, 20 Apr 2005 06:41:14 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Wed, 20 Apr 2005 06:41:14 -0700 (PDT)
To: Martin Uecker <muecker@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050420132446.GA10126@macavity>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> The main point is not about trying different compression
> techniques but that you don't need to compress at all just
> to calculate the hash of some data. (to know if it is
> unchanged for example)
> 

Ah, ok, I didn't understand that there were extra compresses being
performed for that reason. Thanks for the explanation.

jon.
