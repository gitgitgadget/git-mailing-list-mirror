From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Tue, 23 Dec 2014 21:12:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412232109120.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info> <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info>
 <xmqqtx0n710m.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info> <xmqqppbb6zx9.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231049250.21312@s15462909.onlinehome-server.info>
 <xmqqmw6e499u.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231736490.21312@s15462909.onlinehome-server.info> <xmqqa92e47ap.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231829020.21312@s15462909.onlinehome-server.info>
 <xmqqwq5i2qtl.fsf@gitster.dls.corp.google.com> <xmqqsig62q78.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231911470.21312@s15462909.onlinehome-server.info> <xmqq4msm2o1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 21:12:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3VoX-0003gK-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 21:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbaLWUMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 15:12:13 -0500
Received: from mout.gmx.net ([212.227.15.15]:50153 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbaLWUMM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 15:12:12 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0M3RVA-1XlhsV1dLM-00qyyR;
 Tue, 23 Dec 2014 21:12:07 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq4msm2o1n.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:r2MB4+5VGikAdqyVqYGts9+YahDYBw2T/9rgLMvJNiAzNB9yB+B
 O6N7/t+vPA54azmEBbN+trpe4NPbVHKbjvlnXldDpDOLi1UuD6moQXeNBe6IckfLlkwu7M0
 HjfXH4bis1VUsUXRffuYrSzsY6D1UNpLtWMI8UMlNqK3rQjwEZ3Xi9eSBSB3VLGgeJHjY1u
 /RiqkUKYaLFkhvXQm2Nzw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261770>

Hi Junio,

On Tue, 23 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 23 Dec 2014, Junio C Hamano wrote:
> >
> >> Having said that, I think "missingTags" etc. should not be
> >> configuration variable names (instead, they should be values).
> >> 
> >> Because of that, I do not think we need consistency between the way
> >> these "tokens that denote kinds of errors fsck denotes" are spelled
> >> and the way "configuration variable names" are spelled.
> >
> > Okay. That makes more sense.
> 
> I am sorry that I didn't step back and think about it earlier to notice
> that we shouldn't be talking about configuration variable name syntax.
> I could have saved us time going back and forth if I did so earlier.

Do not worry. You were just trying to make this software better, same as
I tried.

Unfortunately, I will not be able to submit v2 of this patch series this
year, but I will do so in the second week of January (including the change
to the global array with the default severity levels because I do want to
see this feature integrated).

Ciao,
Dscho
