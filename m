From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Mon, 1 Sep 2008 15:06:47 +0200
Message-ID: <48BBE8E7.5020001@statsbiblioteket.dk>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com> <20080831203427.GF10360@machine.or.cz> <48BB683F.6020308@zytor.com> <20080901042249.GI7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jeff King <peff@peff.net>, Lea Wiemann <lewiemann@gmail.com>
To: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 15:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka98r-00006e-4K
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 15:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbYIANGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 09:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbYIANGv
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 09:06:51 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:2735 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908AbYIANGu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 09:06:50 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Mon, 1 Sep 2008 15:06:48 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <20080901042249.GI7185@schiele.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94582>

Robert Schiele wrote:
> On Sun, Aug 31, 2008 at 08:57:51PM -0700, H. Peter Anvin wrote:
>> I believe RHEL4 is Perl 5.6.1, but I could be wrong.
> 
> No, that's 5.8.5.  RHEL3 is 5.8.0.  RHEL2 is what you are talking about.
> 
Indeed. RHEL 2.1 will be supported by Redhat until May 31, 2009 so has
about 9 months of support life left.
It is probably also the last still supported Linux dist with perl 5.6.x.

On RHEL 2.1 git 1.6.0.1 currently builds fine and it passes the
testsuite except for the tests using --interactive.

-tgc
