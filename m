From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/9] t3510 (cherry-pick-sequencer): remove malformed
 sheet 2
Date: Fri, 9 Dec 2011 14:24:49 -0600
Message-ID: <20111209202449.GI20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ706-0001Lu-Ux
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab1LIUYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:24:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46982 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766Ab1LIUYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:24:53 -0500
Received: by yenm11 with SMTP id m11so2400910yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=e5FXaaOr+cheMdycEc8utAntjdMe88/iWwxTgb2prrs=;
        b=rIMwl286gf2tQwzDn53OjwimB3+htZTDOth+RTG4D1AISkaekQS6hmaVLccLi0Mhgb
         Fs/7U1AKsQAu5Bkv0j5BVaZVpiXDojF/9n9b7EqA5EumQ7/DyLOcqmNQ9pugRIUXVnR+
         RK7l+EvPtdpc/NAvaqC7O4/NyhgciARA5bduM=
Received: by 10.236.170.1 with SMTP id o1mr14634790yhl.16.1323462292579;
        Fri, 09 Dec 2011 12:24:52 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y58sm16765226yhi.17.2011.12.09.12.24.51
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:24:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186687>

Ramkumar Ramachandra wrote:

>                          By removing the "malformed instruction sheet
> 2" test in advance, it'll be easier to see the changes made by the
> next patch.

So, this is a regression in test coverage without a redeeming upside
other than allowing the next patch to be prettier.  Naturally, I don't
like it.
