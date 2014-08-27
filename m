From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Wed, 27 Aug 2014 22:53:37 +0200
Message-ID: <53FE4551.20108@alum.mit.edu>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com> <047d7b624d36142d46050131f336@google.com> <20140822154151.GK20185@google.com> <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com> <20140822184515.GL20185@google.com> <20140823054646.GA18256@peff.net> <CAL=YDWk5FxnNWaFXJk3t+H0Q_axETmNeb=puuUqhiDBNeQVDGQ@mail.gmail.com> <20140825182636.GO20185@google.com> <20140825190939.GC30953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:53:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMkDw-0000fo-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 22:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935684AbaH0Uxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 16:53:41 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:60890 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932159AbaH0Uxk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 16:53:40 -0400
X-AuditID: 12074413-f79ed6d000002501-7b-53fe4553c302
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CB.BA.09473.3554EF35; Wed, 27 Aug 2014 16:53:39 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB04AB.dip0.t-ipconnect.de [93.219.4.171])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7RKrb1d015803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 Aug 2014 16:53:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <20140825190939.GC30953@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqBvs+i/YYPFqC4uuK91MFg29V5gt
	3t5cwmjxo6WH2eLfhBoHVo+ds+6yeyzYVOrxrHcPo8fFS8oenzfJBbBGcdskJZaUBWem5+nb
	JXBnnFlnW/COueLbx13sDYxtzF2MnBwSAiYSF15eZIWwxSQu3FvPBmILCVxmlHjxjb+LkQvI
	Psckce39Q3aQBK+ApsTHhXPBbBYBVYnvT88zgdhsAroSi3qawWxRgSCJ2Z/nQdULSpyc+YSl
	i5GDQ0TAWeL2enmQMLNAM6PErVZtEFtYwEfiwfubbBC7tjNL3Fm/E+w4TgE9iXXr5jCB9DIL
	qEusnycE0Ssvsf3tHOYJjAKzkGyYhVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	5nq5mSV6qSmlmxghgS28g3HXSblDjAIcjEo8vB8W/AkWYk0sK67MPcQoycGkJMqbb/wvWIgv
	KT+lMiOxOCO+qDQntfgQowQHs5IIb9mBv8FCvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZ
	qakFqUUwWRkODiUJXj8XoKGCRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoBiNLwZG
	KUiKB2jvNWegdt7igsRcoChE6ylGXY6Wpre9TEIsefl5qVLivLkgRQIgRRmleXArYGnsFaM4
	0MfCvFEgl/AAUyDcpFdAS5iAlvzqAHmuuCQRISXVwMhje2Rv0nqlP2zvf0T9Dj8etOtipI/Y
	tUt9nDNLfx34t62v/KLjxsgFXAqWdiFbi+/tOPEpg+2hserso2edD3MU/i4Xs7gV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256042>

On 08/25/2014 09:09 PM, Jeff King wrote:
> [...]
> This patch introduces a new "always" mode for the
> core.logallrefupdates option which will log updates to
> everything under refs/, regardless where in the hierarchy it
> is (we still will not log things like ORIG_HEAD and
> FETCH_HEAD, which are known to be transient).
> [...]

I like the idea. I would use this setting on all my repos (information
packrat that I am).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
