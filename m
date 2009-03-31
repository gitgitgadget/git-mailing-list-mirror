From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] init-db: support --import to add all files and commit right after init
Date: Tue, 31 Mar 2009 18:09:43 +0900
Message-ID: <buomyb2cb3c.fsf@dhlpc061.dev.necel.com>
References: <1237946996-5287-1-git-send-email-pclouds@gmail.com>
	<20090325041934.GA15524@coredump.intra.peff.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 11:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loa0O-0003Nx-6O
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 11:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbZCaJKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755766AbZCaJKA
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 05:10:00 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:51792 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718AbZCaJJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 05:09:59 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2V99iCx006871;
	Tue, 31 Mar 2009 18:09:44 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Tue, 31 Mar 2009 18:09:44 +0900
Received: from dhlpc061 ([10.114.112.72] [10.114.112.72]) by relay21.aps.necel.com with ESMTP; Tue, 31 Mar 2009 18:09:44 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 034FE52E26D; Tue, 31 Mar 2009 18:09:43 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20090325041934.GA15524@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Mar 2009 00:19:35 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115234>

Jeff King <peff@peff.net> writes:
> I seem to recall that we were phasing out "--long-option <arg>" at some
> point, and that all long-options should use "--long-option=". But maybe
> I am mis-remembering.

Surely it should support both where possible, since both are standard
syntaxes for passing args to "--"-style long options (so users expect
both to work).

-Miles

-- 
Occam's razor split hairs so well, I bought the whole argument!
