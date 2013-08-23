From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/6] sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
Date: Fri, 23 Aug 2013 21:41:39 +0200
Message-ID: <5217BAF3.2000702@kdbg.org>
References: <20130822231215.GA16978@sigill.intra.peff.net> <20130822231404.GB17060@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:41:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxF3-0001YT-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab3HWTlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:41:50 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:30864 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754474Ab3HWTlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 15:41:49 -0400
Received: from [10.70.84.217] (178.115.248.217.wireless.dyn.drei.com [178.115.248.217])
	by bsmtp.bon.at (Postfix) with ESMTP id 24A171300AD;
	Fri, 23 Aug 2013 21:41:43 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130822231404.GB17060@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232828>

Am 23.08.2013 01:14, schrieb Jeff King:
> +++ b/t/t5308-pack-detect-duplicates.sh
> @@ -0,0 +1,73 @@
> +#!/bin/sh
> +
> +test_description='handling of duplicate objects in incoming packfiles'
> +. ./test-lib.sh
> +. ../lib-pack.sh

This should be

. "$TEST_DIRECTORY"/lib-pack.sh

to support running tests with --root (also in patch 3/6).

-- Hannes
