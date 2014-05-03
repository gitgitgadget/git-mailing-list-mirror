From: David Turner <dturner@twopensource.com>
Subject: RE: Watchman support for git
Date: Fri, 02 May 2014 22:24:57 -0400
Organization: Twitter
Message-ID: <1399083897.5310.0.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <536428224adfb_200c12912f010@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 04:25:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgPda-000879-3f
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 04:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaECCZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 22:25:03 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:41551 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaECCZC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 22:25:02 -0400
Received: by mail-qg0-f47.google.com with SMTP id e89so5459842qgf.6
        for <git@vger.kernel.org>; Fri, 02 May 2014 19:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=65X87xeCLNrV4wpsF11lg04H6FeaqDbTfQH15MwDJNA=;
        b=ijx6Y0M0dck/UFuj7OiiF+cjTXqlusWFsIalThFx4ngsLGbEmiBjs5LR2btpkNqkcA
         i38AhU+GBmKyJi6lIZCvC7296wt8lL3tDfy+Akac4dH/osAD5rvz30sf2DlzG/ek7zNu
         a/7vb8/UvC3aEO7WnHQXT01YiUEY0Nld657wtLjDr2DA2hITuyqs2oDcfhJRsRK5CsEQ
         b/NvzeAiXNjpwdvsmCUZHSYqSlmjwWMvEuNg3y0pcE4Dsi64YEraegXwk0tw/wbrju5+
         YFk2q0RvPpfWwz0jBAEqDI/x+8LLX55f0N/pd0Jknr4cA2VwMnorx7RG9AplNTPO0dWw
         31/Q==
X-Gm-Message-State: ALoCoQli5sD2jtu0DbqnLH4roGIpSpYCs9Hcf4YpX+I6ndqeHIN1t0D2cuUkANs09epuyFrH1OTV
X-Received: by 10.140.102.161 with SMTP id w30mr25558875qge.108.1399083901325;
        Fri, 02 May 2014 19:25:01 -0700 (PDT)
Received: from [172.18.25.156] ([8.25.196.25])
        by mx.google.com with ESMTPSA id z4sm1708576qas.8.2014.05.02.19.24.59
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 19:25:00 -0700 (PDT)
In-Reply-To: <536428224adfb_200c12912f010@nysa.notmuch>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248015>

On Fri, 2014-05-02 at 18:20 -0500, Felipe Contreras wrote:
> dturner@ wrote:
> > Test repository 1: Linux
> > 
> > Linux is about 45k files in 3k directories.  The average length of a
> > filename is about 32 bytes.
> > 
> > Git status timing:
> > no watchman: 125ms
> > watchman: 90ms
> 
> That's very interesting. Do you get similar improvements when doing
> something similar in Merurial (watchman vs . no watchman).

I have not tried it.  My understanding is that this is why Facebook
wrote Watchman and added support for it to Mercurial, so I would assume
that the improvements are at least this good.
