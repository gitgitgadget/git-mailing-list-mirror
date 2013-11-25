From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Git issues with submodules
Date: Mon, 25 Nov 2013 18:49:45 +0100
Message-ID: <20131125174945.GA3847@sandbox-ub>
References: <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 18:50:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl0IN-0001x1-4f
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 18:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab3KYRt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 12:49:58 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:59366 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255Ab3KYRt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 12:49:57 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vl0IC-0001k0-D4; Mon, 25 Nov 2013 18:49:52 +0100
Content-Disposition: inline
In-Reply-To: <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238324>

On Mon, Nov 25, 2013 at 03:02:51PM +0600, Sergey Sharybin wrote:
> Am i right the intention is to make it so `git add .` and `git commit
> .` doesn't include changes to submodule hash unless -f argument is
> provided?

Yes thats the goal. My patch currently only disables it when ignore is
set to all. I will add another patch that implements the -f and
--submodule-ignore option to both of them so the user has an easy way to
bypass that. But having said that we changing existing behavior here so
we have to investigate carefully whether we are not breaking peoples
expectations (and script). That also applies to the other patch
that enables showing them in diff and friends again.

Cheers Heiko
