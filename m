From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] rev-parse: include HEAD in --all output
Date: Wed, 3 Sep 2014 19:18:56 +0300
Message-ID: <20140903161856.GC6385@wheezy.local>
References: <CAF7_NFRz6Zc-wTDSFdkW4N2wRATZ8-g05j6sFu1t7DB0X72dkg@mail.gmail.com>
 <1409437488-25233-1-git-send-email-max@max630.net>
 <20140831153054.GD17449@peff.net>
 <20140831213606.GB6385@wheezy.local>
 <xmqqsika2c2i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Paul Mackerras <paulus@samba.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPDPK-0003RO-EL
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 18:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568AbaICQ1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 12:27:24 -0400
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net ([173.201.192.234]:59987
	"EHLO p3plsmtpa07-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276AbaICQ1X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 12:27:23 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Sep 2014 12:27:23 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa07-05.prod.phx3.secureserver.net with 
	id mgKP1o0093gsSd601gKRpz; Wed, 03 Sep 2014 09:19:27 -0700
Content-Disposition: inline
In-Reply-To: <xmqqsika2c2i.fsf@gitster.dls.corp.google.com>
From2: "Maksim Kirillov" <max630@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256397>

On Tue, Sep 02, 2014 at 09:59:17AM -0700, Junio C Hamano wrote:
> 
> I would rather see "rev-parse --all" not to include HEAD,
> especially if it has been documented that way.

Ok, then probably I'll want to change it in gitk.

But, with the "multiple working trees" feature, I would also
want to get other HEADs in view, even if they are detached.
I could add it to --all when it returns detached HEAD (like
in git-rev-list), but if it does not, probably some
new dedicated option should be for that purpose. Something
like "git rev-parse --heads", for example.

-- 
Max
