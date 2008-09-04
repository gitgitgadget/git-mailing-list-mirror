From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Thu, 04 Sep 2008 12:28:30 -0500
Message-ID: <fUNB92Q2XygkBhhleaxyWUGW8Ecwa-lU403JuDrY0JMrT1kmsFkWwg@cipher.nrlssc.navy.mil>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com> <20080831203427.GF10360@machine.or.cz> <48BB683F.6020308@zytor.com> <20080901042249.GI7185@schiele.dyndns.org> <48BBE8E7.5020001@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jeff King <peff@peff.net>, Lea Wiemann <lewiemann@gmail.com>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Thu Sep 04 19:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbIg5-0004Qa-E1
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 19:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbYIDRaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 13:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYIDRaT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 13:30:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57501 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYIDRaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 13:30:18 -0400
Received: by mail.nrlssc.navy.mil id m84HSUB5015860; Thu, 4 Sep 2008 12:28:30 -0500
In-Reply-To: <48BBE8E7.5020001@statsbiblioteket.dk>
X-OriginalArrivalTime: 04 Sep 2008 17:28:30.0304 (UTC) FILETIME=[A5F59600:01C90EB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94942>

Tom G. Christensen wrote:

> On RHEL 2.1 git 1.6.0.1 currently builds fine and it passes the
> testsuite except for the tests using --interactive.

Even t9700-perl-git.sh? Or perhaps it is skipped since Test::More
is missing?

t9700-perl-git.sh doesn't run successfully for me on perl 5.8.0 without
changes since test.pl uses

    'File::Temp->new()'

object form, and

    'open our $tmpstderr, ">&", STDERR'

bare STDERR as 3rd argument which this perl version complains about.

-brandon
