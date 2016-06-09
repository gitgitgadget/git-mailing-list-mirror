From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Thu, 9 Jun 2016 00:21:50 +0000
Message-ID: <20160609002150.GA28547@dcvr.yhbt.net>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-5-samuel.groot@grenoble-inp.org>
 <xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
 <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
 <fb7795c4-60db-94b3-a584-8fadd0440773@grenoble-inp.org>
 <CAPig+cQ5OKFTA8pEge=0e2RMT3ghmat-szw73aO_3WVW1=eAFQ@mail.gmail.com>
 <xmqqy46fjuzm.fsf@gitster.mtv.corp.google.com>
 <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:21:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAnjQ-0005k1-0Z
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 02:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbcFIAVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 20:21:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50912 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbcFIAVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 20:21:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F69A20078;
	Thu,  9 Jun 2016 00:21:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4c1dcf95-d8bb-4649-8980-fa947617b96e@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296866>

Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> Email::Simple library uses qr/\x0a\x0d|\x0d\x0a|\x0a|\x0d/ [1].
> Should we handle \n\r at end of line as well?

"\n\r" can never happen with local $/ = "\n"
 
> [1] * http://cpansearch.perl.org/src/RJBS/Email-Simple-2.210/lib/Email/Simple.pm
