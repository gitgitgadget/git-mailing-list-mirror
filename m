From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t/README: tests can use perl even with NO_PERL
Date: Mon, 28 Oct 2013 14:04:20 -0700
Message-ID: <20131028210420.GC4242@google.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
 <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
 <526EA7C8.2020607@kdbg.org>
 <20131028182718.GA4242@google.com>
 <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
 <20131028192216.GB4242@google.com>
 <20131028195429.GA8299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:04:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VatzA-00027x-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab3J1VEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:04:24 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63229 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab3J1VEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:04:23 -0400
Received: by mail-pb0-f41.google.com with SMTP id um1so2784783pbc.14
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Bl9QDoY8F76OGDq2FFgCZaLfyGURVb6Br9kO/y5jBPQ=;
        b=cngJfxZG5Kf+f9xWAbJKsXYtJxky51bHjPwM11RIKBRxkIMyjKzlt34N0+skUP1QgV
         I12LxK0pmSB9f0NxzOdY5hU0k8GZIMSum0ZCLFUUmlGZeKTtxDNu7YP9E6WaFK3PdddK
         n+a2TaN9Xt/0LWx9kKHF/CVbXA/p6v4ctziyRZZX5OEtJKX9J5JuBLSrA3W9zRBf3BIJ
         7/hPtq0guWQTP9R2rnnXrFVkVNMUzk2ro+s6XFDABf0QpmsG2EEnk3eWbhM/Z04T9lyG
         uB59b2/Mg55/9RUa6ZemRR7PwGi2tzKy1we6zh3n73X3lfvYf5OYFmYx6l/k3CJ7mZ47
         ulOw==
X-Received: by 10.66.66.202 with SMTP id h10mr27702161pat.70.1382994263400;
        Mon, 28 Oct 2013 14:04:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id go4sm30616570pbb.15.2013.10.28.14.04.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Oct 2013 14:04:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131028195429.GA8299@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236859>

Jeff King wrote:

> Speaking of which, is there any reason to use the ugly "$PERL_PATH"
> everywhere, and not simply do:
>
>   perl () {
>     "$PERL_PATH" "$@"
>   }
>
> in test-lib.sh?

Sounds like a nice potential improvement to me. :)

Thanks,
Jonathan
