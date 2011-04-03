From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH maint resend] compat: add missing #include
 <sys/resource.h>
Date: Sun, 3 Apr 2011 14:13:25 -0500
Message-ID: <20110403191324.GE3830@elie>
References: <1300271879-2050-1-git-send-email-stsp@stsp.name>
 <20110318202351.GA22696@elie>
 <20110331225909.GA21429@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stefan Sperling <stsp@stsp.name>,
	Arnaud Lacombe <lacombar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:13:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Sjv-0007gP-QJ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1DCTNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:13:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62662 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab1DCTNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:13:30 -0400
Received: by iwn34 with SMTP id 34so5129082iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P6EV8Aq5BDlK01ur0nvuwkxKF8FkwJ0Z6fOIgEVkBNg=;
        b=DzEW7f7i9w0ylDYbsRCy+/0cbokhmS++N2idoo26eNC+iEmYl4Zdi8n/1Ffdn+IedJ
         Vr+xPcZHcvq+5s7ytk/Dlel7o2k3yth2Njr0kH2ouQB1UZBP3nUYNupDn+yNhsxeUlgu
         HON+HF6fSLcnppGsVE8SDXHmh/XsXCX2qxoSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ujhFqR4QKy6jUD5QmJ4y5ax2WUJGz1w2/5nUr4HJWXWWRIW44wW7/FZp4da0qAw50M
         5a5tgZ5mdNzgTTF2AOcz1i1nY0rXsduRzY6HF7c20Pl2tDlRR9JDQ9cPb1LHFAGfbopP
         dhNWBZ5RvhVGm31Ba0HgljrKJqXLq5HR4J7zY=
Received: by 10.42.151.131 with SMTP id e3mr9536026icw.157.1301858009647;
        Sun, 03 Apr 2011 12:13:29 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.sbcglobal.net [69.209.53.77])
        by mx.google.com with ESMTPS id g16sm3167665ibb.20.2011.04.03.12.13.27
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 12:13:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110331225909.GA21429@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170774>

Hi Junio,

Jonathan Nieder wrote:

> Date: Fri, 18 Mar 2011 15:23:52 -0500
[...]
>  sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in this function)
[...]
> Reported-by: Stefan Sperling <stsp@stsp.name>
> Tested-by: Stefan Sperling <stsp@stsp.name> [on OpenBSD]
> Tested-by: Arnaud Lacombe <lacombar@gmail.com> [on FreeBSD 8]
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Ping?  Would you like a shorter commit message, or was this just lost
in the noise?
