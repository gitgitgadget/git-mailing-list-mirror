From: Yuri <yuri@rawbw.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 04 Feb 2014 15:00:29 -0800
Message-ID: <52F1710D.70304@rawbw.com>
References: <20140117041430.GB19551@sigill.intra.peff.net> <20140117042153.GB23443@sigill.intra.peff.net> <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com> <20140121054927.GD5878@sigill.intra.peff.net> <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com> <20140204221220.GA5457@sigill.intra.peff.net> <xmqqiosu7ca2.fsf@gitster.dls.corp.google.com> <20140204222507.GA6031@sigill.intra.peff.net> <52F16D77.2000604@rawbw.com> <20140204224803.GB6317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 00:00:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoz5-0004dq-21
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 00:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933937AbaBDXAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 18:00:44 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:49312 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933109AbaBDXAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 18:00:43 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s14N0TJw020497;
	Tue, 4 Feb 2014 15:00:29 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140204224803.GB6317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241584>

On 02/04/2014 14:48, Jeff King wrote:
> But this is not a build-time problem, but rather a run-time problem. We
> do not know what the environment of the user will be at run-time.

Ok, git can test the pager on the given system before its first use and 
remember the result in ~/.git for later use for example. Such 
'experimental' approach is maybe more reliable.

Yuri
