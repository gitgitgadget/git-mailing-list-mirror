From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Sun, 4 May 2008 10:44:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041040560.30431@racer>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>  <1209815828-6548-1-git-send-email-pkufranky@gmail.com>  <1209815828-6548-2-git-send-email-pkufranky@gmail.com>  <1209815828-6548-3-git-send-email-pkufranky@gmail.com> 
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>  <1209815828-6548-5-git-send-email-pkufranky@gmail.com>  <7vy76rtfns.fsf@gitster.siamese.dyndns.org> <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsamj-0000os-M3
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbYEDJoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbYEDJoq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:44:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752919AbYEDJop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:44:45 -0400
Received: (qmail invoked by alias); 04 May 2008 09:44:43 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp035) with SMTP; 04 May 2008 11:44:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/UDkl8JqfUBgnoQ4iX5mg+DspTHX/Da/YoCafVVT
	OtY6choSiQqETb
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81157>

Hi,

On Sun, 4 May 2008, Ping Yin wrote:

> If we set diff.nonwordchars to "()", the example above will show as "if 
> (<r>foo(</r><g>bar(</g>arg))". It's much better, athough not the best.

Okay, let's use the power of Open Source, and come up with the best 
solution.

The problem: given two chunks of text, where a word was changed, and a
non-word-character was moved to the next line.  Example:

	The quick,
	brown fox

vs

	The fast
	, brown fox

IMHO the layout of the new version should be retained, i.e.

	The /quick/fast/
	, brown fox

should be shown.

If everybody is fine with that, I'll try to come up with an 
implementation. 

Ciao,
Dscho
