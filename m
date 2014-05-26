From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 5/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 14:00:35 -0700
Message-ID: <20140526210035.GB11888@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
 <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
 <20140526203304.GA11888@hudson.localdomain>
 <CA+g4mq8iGNVm-2Uj8j2bJLDazaTS_U76BO9-jeS9Aw4RZnki5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 23:00:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp20j-0006eS-5J
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 23:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaEZVAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 17:00:41 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54677 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbaEZVAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 17:00:41 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so8159594pbb.13
        for <git@vger.kernel.org>; Mon, 26 May 2014 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=J6OqeWh5SJYecb3ZxMdo2k87r8DqJZJ+2sou2oLMCfQ=;
        b=qHjZh4ucXJexGb9pZ3ZOGfvc9epe/N22li9vpvK2xYMwh80gX2TflEUbEJc9NlaPhz
         MTeP+PrxMDm4FtrGVCCFkzo9SByIADPm1fc4ebq0TdVqkN6W78C0q4aqxCa6BG0kXbIV
         Vyl7T3/HdPFM5rDERBUC06F1ne/Y3EzVacmsBP8eKUcpMSVLatQgqb/ScySxdRdZD552
         cI8nDOpC9jO8l13H3+8y1o1nRN57SruBJng6BIbtNHkf+KcSJ9Ov3D3zuSls78ORojt7
         9dR1C1a80U5v1iy0f3zGpmegnr3Q80BNT5AumJliV3Kqmv2FNle0IkgvzNjnxTUAw8mM
         ND+A==
X-Received: by 10.68.161.101 with SMTP id xr5mr7201728pbb.168.1401138040596;
        Mon, 26 May 2014 14:00:40 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id rc3sm19767193pbc.5.2014.05.26.14.00.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 14:00:38 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 14:00:35 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CA+g4mq8iGNVm-2Uj8j2bJLDazaTS_U76BO9-jeS9Aw4RZnki5A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250123>

On Mon, May 26, 2014 at 03:39:55PM -0500, Caleb Thompson wrote:
> The editors, `check-for-diff` and `check-for-no-diffs`, are grepping for
> the output and lack thereof, respectively.
...
> >
> > It appears that these tests still aren't checking to see if the
> > "verbose" output appears in the commit message.
> >
> >

OK, got it.  The editor, set by test_set_editor, is run as part of
the commit.  Thanks for explaining that.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
