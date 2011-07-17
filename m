From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/17] revert: Save data for continuing after conflict
 resolution
Date: Sun, 17 Jul 2011 13:40:57 -0500
Message-ID: <20110717184057.GD27787@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-12-git-send-email-artagnon@gmail.com>
 <20110712193716.GB14909@elie>
 <CALkWK0nyu6W2Nd=qcrjZZwkAdFGqTqAe53FmecS_n2cK_4UWMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 20:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiWHD-0005oY-92
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 20:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186Ab1GQSlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 14:41:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37509 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab1GQSlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 14:41:04 -0400
Received: by iwn6 with SMTP id 6so2519847iwn.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UFyXjkmmqFl1tyj2ZOF/3yEDyJTByj5TC7dsIGwq+yg=;
        b=lbduZW6y5VOuHjTLjZwCqXoLIDUJGloCH4Tn0UFZUh/F79/c3PSsyE+02pKgfv5+qu
         wSZk2JmDymmboHgFZ31WEp0H5lDF/NI9LSyfvZNew8lVBw5fTnOhLh6a7Q/Y9Zlqbb/r
         B4spwi33HoeAF7ZEQr1nc03KqaZutI1YEtEKg=
Received: by 10.231.171.201 with SMTP id i9mr4459754ibz.89.1310928063456;
        Sun, 17 Jul 2011 11:41:03 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id v16sm2371187ibe.0.2011.07.17.11.41.01
        (version=SSLv3 cipher=OTHER);
        Sun, 17 Jul 2011 11:41:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nyu6W2Nd=qcrjZZwkAdFGqTqAe53FmecS_n2cK_4UWMg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177310>

Ramkumar Ramachandra wrote:

> fatal: Malformed instruction sheet: .git/sequencer/todo
> Technically speaking, this is correct.  However, this may not be ideal
> from an end-user's perspective.  Anyway, this is going to change soon
> -- do you think this is worth correcting here and now?

Yes, thanks.  (A bird in the hand and all that.)
