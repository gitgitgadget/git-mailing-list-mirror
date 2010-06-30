From: Sam Vilain <sam@vilain.net>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Wed, 30 Jun 2010 14:20:34 +1200
Message-ID: <1277864434.23613.15.camel@wilber>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
	 <20100624173956.GA1600@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 04:20:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTmv3-0007ES-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab0F3CUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:20:52 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54974 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab0F3CUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:20:51 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 86E0DFCD31; Wed, 30 Jun 2010 14:20:47 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [IPv6:::1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A4870FCD2D;
	Wed, 30 Jun 2010 14:20:24 +1200 (NZST)
In-Reply-To: <20100624173956.GA1600@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149935>

On Thu, 2010-06-24 at 12:39 -0500, Jonathan Nieder wrote:
> FWIW, I like the idea.
> 
> If you want to keep stdout unpolluted, this could work like
> 
> 	git fast-import --print-marks=<fd>
> 
> We would have to make sure output to the fd is always flushed to
> prevent deadlock.

That works, it could default to --print-marks=0 if STDIN happens to be a
socket.  Works for FastCGI :-)

Samn
