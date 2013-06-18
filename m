From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/Makefile: move infodir to be with
 other '*dir's
Date: Mon, 17 Jun 2013 21:32:41 -0700
Message-ID: <20130618043240.GA2896@elie.Belkin>
References: <4857ab4f4097c582063f064f657a8e5dfbfee232.1371402684.git.john@keeping.me.uk>
 <ffea107da7b3b7d5e390d27397d3a72155e942b4.1371402684.git.john@keeping.me.uk>
 <7vppvkbikk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 06:32:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UonbB-0001DC-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 06:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879Ab3FREct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 00:32:49 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54328 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3FREct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 00:32:49 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so3555025pab.10
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=K9V+JWtUYRNwaRw0eUR0dk0f9C0sUU+qLMhCpXiTtV4=;
        b=qpNVNoyaMnT2wNx89I+TrzRRTXZyFhbV0n8W+/QvjHwGKjl36jCDI3X5TfWAgC9+tD
         ArUcYzkXWPYgDuzaGcobIW9CbqoaD15uLfKIGmU7VNiQJyFmsctS5QCoztuYVSoAzAnt
         DvxD74U1O2P3h7ZWdApaSRNR19fhP8djYB6jt+lp4OLjNtykIgtjyO4ZjjJTfh0UHSxx
         oJ/dGzDlswyIrFq8+vU7K2dIGNgYHl6IqLntrTKDez5Cd8zuKxAZ/sGJ96HanMatGYeD
         m0aJsjVVLkkTEt2ivs6BXUDqs3PJzm+YgAEUOPpiASqIq+kSubgnmeh7I4X5QAJEOk4l
         BRAQ==
X-Received: by 10.68.211.36 with SMTP id mz4mr15301998pbc.191.1371529968768;
        Mon, 17 Jun 2013 21:32:48 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id fr1sm16440814pbb.26.2013.06.17.21.32.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 21:32:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vppvkbikk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228151>

Jun 17, 2013 at 01:14:51PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:

>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
>
> Thanks; will directly apply 1/2 on maint.  I am not absolutely sure
> about this one, where variables related to an optional "info"
> support used to be in one place but with the patch only "infodir" is
> separated away.  Maybe it is not a big deal, though.

In practice, I think keeping the variables that specify the filesystem
hierarchy together is more useful (or in other words, this looks like a
good patch).

Thanks,
Jonathan
