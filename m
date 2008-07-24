From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Fri, 25 Jul 2008 01:59:57 +0700
Message-ID: <fcaeb9bf0807241159u6c296156q93d45c7e87dcce9a@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
	 <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807231753240.8986@racer>
	 <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
	 <alpine.DEB.1.00.0807241340490.8986@racer>
	 <fcaeb9bf0807240629v6958014bpfa9aebde281ff57@mail.gmail.com>
	 <alpine.DEB.1.00.0807241443230.8986@racer>
	 <fcaeb9bf0807240650v6eab6ad4n63c39973b3b43658@mail.gmail.com>
	 <32541b130807240922r733dce6aw8b123bbb28c9002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM63j-0002e1-Ud
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYGXTAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYGXS77
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:59:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:49838 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYGXS77 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:59:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1474637fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4GGmnS5NvZN2gYVarkZxYb5my5SRLAkrUJDcFl2NyKM=;
        b=qcrl9Ye2r28RGc2I2hg3V3ML1I6gpA+QrabaxWYDERCLTwXZ9kNa5ZzITzLmO05iR2
         R1yHyPKPFSoCGAZU9ma+At76/vA/HJWLKr7OScqia6qnt/flHJUthwBwRqCwuIDufss8
         woba1RCqlIsz0MPs7rQLxRZb/RwbtVI8uWHsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AOCbVrw1uHCV5hih66Mys3PR+GOcTLCtAzljqQSI/jNZrfmdbBrq53ZM3/obcG4F34
         ghRr90/VNFYHnolEsVgYruDtZkMM0iQUZ9S9Ew18RTzq4iP7/78n28xMamky7HFXtWoX
         Oers6GSKJXKWDXEGG16TuWbfJIEgsViqf7uH4=
Received: by 10.86.1.1 with SMTP id 1mr1130476fga.61.1216925997838;
        Thu, 24 Jul 2008 11:59:57 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 11:59:57 -0700 (PDT)
In-Reply-To: <32541b130807240922r733dce6aw8b123bbb28c9002@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/24/08, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 7/24/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>  > OK. I am lost here. I do not know how putting sparse prefix and index
>  >  together could fix "it" (I think you meant the index guarding).
>
> [snip]
>
>  The information required to do a checkout is in the index.  And
>  "sparse checkout" is all about checking out :)

That was better Dscho's questions ;) Thanks for the enlightenment.
-- 
Duy
