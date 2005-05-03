From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: git and symlinks as tracked content
Date: Tue, 3 May 2005 15:10:57 -0400
Message-ID: <118833cc05050312101f2715d3@mail.gmail.com>
References: <1115145234.21105.111.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:05:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT2hK-00053R-84
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVECTLC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVECTLC
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:11:02 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:62905 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261613AbVECTK7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:10:59 -0400
Received: by rproxy.gmail.com with SMTP id a41so20881rng
        for <git@vger.kernel.org>; Tue, 03 May 2005 12:10:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sdGI47CphtJ73EGqJWvmBphHfkH6/XMdI9ErvmXYUVzzg+iEQHsEvm+OwkgCCuh5/NNj04Evhl3UisDU0ZNrJD6rQNxSQtWiYol48DetQ/BzexbV8dJ1lU18vq5S4mrNM3FmFkLlVI2MWyOEyKlxpgg2+XF/Dko7szQv1lO00Ms=
Received: by 10.38.72.11 with SMTP id u11mr120890rna;
        Tue, 03 May 2005 12:10:57 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Tue, 3 May 2005 12:10:57 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Something in the patching food chain will also need to know how to turn
regular files into symlinks (and vice versa) in the same we ought to have
that for directories right now.

Morten
