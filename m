From: Tait <git.git@t41t.com>
Subject: Re: utf8 BOM
Date: Sun, 16 May 2010 04:26:12 -0700
Message-ID: <20100516112612.GV2480@ece.pdx.edu>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com> <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com> <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com> <20100514101648.GB6212@dpotapov.dyndns.org> <61355CFC-EB9E-4B76-9450-F2DF1B2903C0@gmail.com> <20100516051927.GA17200@dpotapov.dyndns.org> <00E0B9AC-2A2E-4F95-9B35-F3F63EBC3CF3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 16 13:39:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODcBg-0000Wt-0R
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 13:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab0EPLiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 07:38:00 -0400
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:57542 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab0EPLiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 07:38:00 -0400
X-Greylist: delayed 704 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2010 07:38:00 EDT
Received: from nemo.ece.pdx.edu (nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o4GBQCvK018686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 May 2010 04:26:12 -0700
Received: from nemo.ece.pdx.edu (localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o4GBQC8P016761;
	Sun, 16 May 2010 04:26:12 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o4GBQCJo016760;
	Sun, 16 May 2010 04:26:12 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <00E0B9AC-2A2E-4F95-9B35-F3F63EBC3CF3@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Sun, 16 May 2010 04:26:12 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147186>

> Okay, so something that checks text files to see if they're utf...
> "core.autoutf", anyone?

This (and crlf-conversion, for that matter) strikes me as something best 
handled outside of git core, such as through checkout/commit hooks. Perhaps 
examples of such hooks could be provided and adapted by each project and 
user as that user/project sees fit for their specific choice of repository 
format and development environment.

Given that git already chose not to screw around with encodings or define 
a canonical encoding for the on-disk format (it's just a string of bytes), 
it would be consistent and reasonable to not mess with these other things, 
too.

Tait
