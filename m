From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: Git issues with submodules
Date: Mon, 25 Nov 2013 19:15:42 +0100
Message-ID: <20131125181542.GA9761@sandbox-ub>
References: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 19:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl0hO-0006jr-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 19:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab3KYSPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 13:15:50 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.95]:36788 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab3KYSPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 13:15:50 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vl0hH-0002D3-1e; Mon, 25 Nov 2013 19:15:47 +0100
Content-Disposition: inline
In-Reply-To: <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238326>

On Mon, Nov 25, 2013 at 11:57:45PM +0600, Sergey Sharybin wrote:
> Heiko, yeah sure see what you mean. Changing existing behavior is pretty PITA.
> 
> Just one more question for now, are you referencing to the patch "[RFC
> PATCH] disable complete ignorance of submodules for index <-> HEAD
> diff"? Coz i tested it and seems it doesn't change behavior of
> add/commit.

Yep, that was just an RFC for status and diff. I think teaching add and
commit to skip submodules if ignored are a separate topic and thus will
be in a separate patch. I have to add tests and probably some more
commands. The logic of ignoring submodules is implemented quite deep in
the diff code. So changing it can affect quite some commands so we
have to check quite carefully what will be affected and if we can change
it without to much fallout.

> Also, i'm around to test the all patches which are related on submodules :)

Thanks, good to know. Stay tuned!

Cheers Heiko
