From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Fri, 5 Sep 2008 08:34:51 +0200
Message-ID: <48C0D30B.4030302@statsbiblioteket.dk>
References: <20080830173947.GF7185@schiele.dyndns.org> <7v63ph40at.fsf@gitster.siamese.dyndns.org> <32541b130808311129u79f4179enfabab8f5845ed522@mail.gmail.com> <200808312223.38222.jnareb@gmail.com> <20080831203427.GF10360@machine.or.cz> <48BB683F.6020308@zytor.com> <20080901042249.GI7185@schiele.dyndns.org> <48BBE8E7.5020001@statsbiblioteket.dk> <fUNB92Q2XygkBhhleaxyWUGW8Ecwa-lU403JuDrY0JMrT1kmsFkWwg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robert Schiele <rschiele@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jeff King <peff@peff.net>, Lea Wiemann <lewiemann@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 05 08:36:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbUvt-0001R1-RT
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 08:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYIEGf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 02:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYIEGf2
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 02:35:28 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:14490 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752718AbYIEGf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 02:35:27 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Fri, 5 Sep 2008 08:34:51 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <fUNB92Q2XygkBhhleaxyWUGW8Ecwa-lU403JuDrY0JMrT1kmsFkWwg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94997>

Brandon Casey wrote:
> Tom G. Christensen wrote:
> 
>> On RHEL 2.1 git 1.6.0.1 currently builds fine and it passes the
>> testsuite except for the tests using --interactive.
> 
> Even t9700-perl-git.sh? Or perhaps it is skipped since Test::More
> is missing?
> 
Exactly.

> t9700-perl-git.sh doesn't run successfully for me on perl 5.8.0 without
> changes since test.pl uses
> 
>     'File::Temp->new()'
> 
> object form, and
> 
>     'open our $tmpstderr, ">&", STDERR'
> 
> bare STDERR as 3rd argument which this perl version complains about.
> 
I saw your patch for this.
I haven't got this far with 5.8.0 since t9100-git-svn-basic.sh kills the 
build because of File::Temp->new() in Git.pm.

-tgc
