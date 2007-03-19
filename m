From: Sam Vilain <sam@vilain.net>
Subject: Re: git push to a non-bare repository
Date: Tue, 20 Mar 2007 11:58:11 +1200
Message-ID: <45FF2393.6070700@vilain.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org> <20070319032130.GF11371@thunk.org> <20070319035351.GI20658@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 00:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTRkD-0007RR-MA
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 00:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030767AbXCSX6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 19:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbXCSX6W
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 19:58:22 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52759 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030767AbXCSX6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 19:58:19 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 2FCB913A384; Tue, 20 Mar 2007 11:58:17 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id CE84013A342;
	Tue, 20 Mar 2007 11:58:13 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <20070319035351.GI20658@spearce.org>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42684>

Shawn O. Pearce wrote:
> receive-pack isn't updating the HEAD reflog as its updating the
> actual branch, not HEAD.  If you pushed instead to HEAD you should
> see the HEAD reflog entry too.
>   

What about splitting HEAD when you push to the underlying branch, and
making HEAD a non-symref?

Sam.
