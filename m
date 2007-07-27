From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: git-gui: i18n introductory document (2nd draft)
Date: Fri, 27 Jul 2007 17:02:07 +0900
Message-ID: <200707270802.l6R82YpC013213@mi1.bluebottle.com>
References: <7v4pjq7net.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Christian Stimming <christian.stimming@ibeo-as.com>,
	Irina Riesen <irina.riesen@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Xudong Guan <xudong.guan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 10:02:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEKmZ-0007NJ-Oe
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 10:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765395AbXG0ICi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 04:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757205AbXG0ICh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 04:02:37 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:54535 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765380AbXG0ICf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 04:02:35 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6R82YpC013213
	for <git@vger.kernel.org>; Fri, 27 Jul 2007 01:02:34 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=oaCuTgmnQrHAkBtlCT4MGJguppDW6bbb+WQgw6s/nMvpRKawqKMNtrKLIKTxkh22O
	GTCn83GLdXF6iSqe6F+Dys3jbaZG/PXLKn/ChCSNeFRwTxUkwX2ZCeADQTECjsz
Received: from nanako3.mail.bluebottle.com (67.245.104.77.line.cz [77.104.245.67] (may be forged))
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id l6R82KFv020127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jul 2007 01:02:24 -0700
In-Reply-To: <7v4pjq7net.fsf@assigned-by-dhcp.cox.net>
X-Trusted-Delivery: <ca48b941470d41f6550632531ce8ebe6>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53907>

Quoting Junio C Hamano <gitster@pobox.com>:

> This short note is to help a translation contributor to help us
> localizing git-gui message files by covering the basics.

Thank you for this document, and thank you for helping me the
other day with my translations.

I tried to follow your message and updated my Japanese
translation.  Almost everything worked as described, but this
part.

> +After setting up such a symbolic link, you can:
> +
> +	$ make
> +	$ LANG=af ./git-gui
> +
> +[NEEDSWORK: this symlink trick needs to be verified if it works.]

I used LANG=ja instead; this did not work.  A "fatal error"
dialog said:

	couldn't open "/home/nanako/git/share/git-gui/lib/tclIndex":
	no such file or directory

But this worked:

	$ LANG=ja ./git-gui.sh

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
