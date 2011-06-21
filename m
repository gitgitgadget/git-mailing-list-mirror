From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] Add a lot of dummy returns to avoid warnings with
 NO_NORETURN
Date: Mon, 20 Jun 2011 17:17:03 -0700
Message-ID: <20110621001703.GA700@alboin.amr.corp.intel.com>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
 <1308445625-30667-2-git-send-email-andi@firstfloor.org>
 <7vsjr4b3tf.fsf@alter.siamese.dyndns.org>
 <20110620213001.GB32765@one.firstfloor.org>
 <7vfwn4b1vb.fsf@alter.siamese.dyndns.org>
 <20110620220347.GE32765@one.firstfloor.org>
 <20110620223156.GA695@elie>
 <20110620223705.GG32765@one.firstfloor.org>
 <7v1uyoaxu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <andi@firstfloor.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 02:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYoef-0006y1-4l
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 02:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab1FUARQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 20:17:16 -0400
Received: from mga14.intel.com ([143.182.124.37]:4633 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756151Ab1FUARP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 20:17:15 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 20 Jun 2011 17:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,397,1304319600"; 
   d="scan'208";a="15870187"
Received: from unknown (HELO localhost) ([10.255.12.248])
  by azsmga001.ch.intel.com with ESMTP; 20 Jun 2011 17:17:14 -0700
Content-Disposition: inline
In-Reply-To: <7v1uyoaxu5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176113>

> When the above is applied and compiled without NO_NORETURN, the extra
> return may be optimized out by the compiler as your commit log messages
> said, but wouldn't it introduce a new warning:
> 
>   builtin/commit.c: In function 'find_author_by_nickname':
>   builtin/commit.c:965: error: will never be executed
> 
> under -Wunreachable-code?

It may, but that option isn't set for git?

-Andi
