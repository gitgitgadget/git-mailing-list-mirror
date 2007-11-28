From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 15:24:19 +0100
Message-ID: <85lk8ia1nw.fsf@lola.goethe.zz>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
	<fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Benoit Sigoure" <tsuna@lrde.epita.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNpy-00057h-8k
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXK1OYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbXK1OYF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:24:05 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:41403 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010AbXK1OYD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 09:24:03 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 360D91F4FEA;
	Wed, 28 Nov 2007 15:24:02 +0100 (CET)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 2754B2540B2;
	Wed, 28 Nov 2007 15:24:02 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id B61FB34A6BA;
	Wed, 28 Nov 2007 15:24:01 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1EC931C4D3AA; Wed, 28 Nov 2007 15:24:19 +0100 (CET)
In-Reply-To: <fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 28 Nov 2007 21:19:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4936/Wed Nov 28 11:55:15 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66342>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Nov 28, 2007 8:57 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>> It might be POSIX, but there are shells that do not like the
>> expression 'export VAR=VAL'.  To be on the safe side, rewrite them
>> into 'VAR=VAL' and 'export VAR'.
>
> Why leave test scripts behind?

Good keyword: how about starting the basic tests by testing for shell
features that are known and accepted to be used in git?

That way, we get direct feedback when feature assumptions are
problematic with some shells.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
