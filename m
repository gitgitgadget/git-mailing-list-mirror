From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to force git to use authentication as author
Date: Thu, 14 Jul 2011 14:45:52 -0500
Message-ID: <20110714194552.GA14632@elie>
References: <20110714160638.065b6542@shiva.selfip.org>
 <CACBZZX4X8qRBXqwi70kZ0eZ+mb7rdD6p36xD=GoX6soha0TZcg@mail.gmail.com>
 <20110714161838.1e30893a@shiva.selfip.org>
 <1310641202.18730.16.camel@bee.lab.cmartin.tk>
 <20110714164547.0b359e60@shiva.selfip.org>
 <CABPQNSY3qyQXO4hyM6xhHq2VYhK5369ihuqJ5PDAonN7+UpcGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bakshi" <joydeep@infoservices.in>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:46:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRrM-00009U-TU
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234Ab1GNTqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:46:02 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52082 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab1GNTqB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:46:01 -0400
Received: by iyb12 with SMTP id 12so525877iyb.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FKB8n6YQyQVupLHovRRVlJYeU8CN+x78+o7cli1N8Z0=;
        b=DbxZ8nCewdkZzyD5r3DRRPwFldMixs1xpXGu4dh0QiWJZ3lUFK1d/hOdPALF7l3Hdp
         EnCSKihVuJsdS++ad3p7TEoC04WFWPH1Wxm2BCUhJjwESgXnvXU5bDXHuXWd64KaVEGs
         i1IrCDq93wigOmtX5TN71Msbj+2FYNl0/HGFY=
Received: by 10.42.128.83 with SMTP id l19mr2846741ics.443.1310672760469;
        Thu, 14 Jul 2011 12:46:00 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id v16sm327689ibf.25.2011.07.14.12.45.58
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 12:45:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABPQNSY3qyQXO4hyM6xhHq2VYhK5369ihuqJ5PDAonN7+UpcGA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177165>

Hi,

Erik Faye-Lund wrote:

> So let's step back a little bit. Why do you want the author to be
> identical to the authenticated user in the first place? Is it to be
> able to *prove* (i.e not trust the users that push) who wrote what
> code? If so, let's me first tell you that giving someone push-access
> while not trusting them is a bit crazy. But if you're happy with being
> a bit crazy, you'd might want to somehow cryptographically sign the
> commits instead. I'd go for PGP-signing the patch-id, and putting that
> in a git-note.

Let's suppose you want to be able to decide who was to blame for the
latest breakage, not on a per-commit level but on a per-push level.
Then that seems quite doable to me through simpler means, on the
server side.  See

 http://sitaramc.github.com/gitolite/doc/3-faq-tips-etc.html#_better_logging

Hope that helps.
Jonathan
