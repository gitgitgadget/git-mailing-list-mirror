From: Lars Damerow <lars@pixar.com>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Mon, 15 Mar 2010 22:56:25 -0700
Message-ID: <20100316055625.GA10907@pixar.com>
References: <20100315214003.GB11157@pixar.com> <20100316023306.GA14253@coredump.intra.peff.net> <7vbpeovqyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 06:56:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPla-0003ir-F1
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab0CPF43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:56:29 -0400
Received: from cmx.pixar.com ([199.108.77.24]:33579 "EHLO cmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab0CPF43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:56:29 -0400
X-PixarMID: 1913488
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.49,648,1262592000"; 
   d="scan'208,223";a="1913488"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by cirrus.pixar.com with ESMTP; 15 Mar 2010 22:56:26 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2G5uQov010929;
	Mon, 15 Mar 2010 22:56:26 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2G5uPE7010927;
	Mon, 15 Mar 2010 22:56:25 -0700
Content-Disposition: inline
In-Reply-To: <7vbpeovqyi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142318>

>From Junio C Hamano <gitster@pobox.com>, Mon, Mar 15, 2010 at 09:19:17PM -0700:
> 
> How inefficient is it to repeatedly call getenv() in a loop, by the way?
> I think the patch would become easier to read if env_bool() is called once
> at the beginning to set a local variable, and not even do the initial stat()
> for "." if this feature is not asked for.

Agreed, I didn't do this too efficiently. Thanks for the feedback! I'll
make a new patch and resubmit.

cheers,
-lars

--
lars r. damerow :: button pusher :: pixar animation studios

When in doubt, use brute force.
