From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 13:43:39 +0100
Message-ID: <AANLkTi=RVW8osJaSi1mDhNuOrFksHhAjtPdfdeXQoFeC@mail.gmail.com>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
	<20110303185918.GA18503@sigill.intra.peff.net>
	<AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
	<20110303203323.GA21102@sigill.intra.peff.net>
	<20110309174956.GA22683@sigill.intra.peff.net>
	<AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
	<20110309215841.GC4400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 13:43:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py1h4-0006Ha-Og
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 13:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab1CKMnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 07:43:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37421 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab1CKMnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 07:43:40 -0500
Received: by fxm17 with SMTP id 17so925932fxm.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 04:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BEehbz+ua4NIfwAdjO5DCph9hBW1x7iZKjg+XdSf2uw=;
        b=yDoyZNIgyBCWF8PH19fXHxBcTPR1axkiqjj7IX4MqmsQxT9sqc+GcRuho9Nbrugcy6
         1NbKgMoBRp3GS4LXvhnF6tbAQER4/hMmAxfa8JKtV+qo6pG8gl+++zbSkyc46r+JwDd4
         vgyUAvjnDdhWET/vC142FbuWPWH7OgSQL0Jcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=HOBUXnIuamUNCT7zk8s1XXZxC069ZV6Mm+6CjkUCktEGD5JwKZfkJE/8l1ZCFwb2Cl
         dS1XBIMyKGxK7v738tfA1cxbLEA+owKrv8g2GBR66N3vc5pj9sz+OdKT7lcrmZRHGGon
         Zt/OlRSBBcYZiUFaeBCBq/yYE31cSnB8rXGCU=
Received: by 10.223.95.135 with SMTP id d7mr1031609fan.65.1299847419565; Fri,
 11 Mar 2011 04:43:39 -0800 (PST)
Received: by 10.223.108.130 with HTTP; Fri, 11 Mar 2011 04:43:39 -0800 (PST)
In-Reply-To: <20110309215841.GC4400@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168894>

On Wed, Mar 9, 2011 at 22:58, Jeff King <peff@peff.net> wrote:
> If you have any ideas, please add them to the page!

Here's a simple one:

Currently we have a global UI color setting, but pretty much only
git-status/log/etc use it.

Change git-bisect, git-am etc. to also support color output. It would
be a easy but big UI win.
