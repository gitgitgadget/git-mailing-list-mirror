From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: Use of tac in git-rebase--interactive
Date: Sun, 27 Apr 2008 16:33:25 +0900
Message-ID: <200804270733.m3R7XW72012537@mi1.bluebottle.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:34:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq1Ou-0000z7-Eo
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 09:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYD0Hdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 03:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYD0Hdd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 03:33:33 -0400
Received: from mi1.bluebottle.com ([206.188.25.14]:43839 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbYD0Hdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 03:33:32 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3R7XW72012537
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 00:33:32 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=xkwa4azoiSlL6VE3QiS7oCbe1fYYoPg048CsR9VeA58c1YL/tgEcLJCt/xNpDmX+C
	DFu9XD3UetEeDRyqrR3sGKMr0qzalY4ROHdBFEoXrjYSP3c9QeVLjpBKvAEqVf7
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3R7UH97029757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Apr 2008 00:33:28 -0700
In-reply-to: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
X-Trusted-Delivery: <136fa369a90731af3db19ed3d1ea1d4e>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80429>

Quoting Brian Gernhardt <benji@silverinsanity.com> writes:

> Commit d481bcc9: "Do rebase with preserve merges with advanced TODO
> list" uses the command tac, apparently to reverse the TODO command
> list.  (I don't use rebase -i much, if you can't tell.)

That is very sloppy job on Junio's part.  He usually is very picky about shell portability, and I remember that he earlier rewrote somebody else's commit that originally used tac command.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
