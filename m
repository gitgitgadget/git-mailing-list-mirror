From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 18:12:15 +0200
Message-ID: <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>
	 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	 <alpine.DEB.1.00.0805171102480.30431@racer>
	 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 18:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxP22-0004CU-B3
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 18:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbYEQQMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 12:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYEQQMS
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 12:12:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:32957 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbYEQQMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 12:12:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so625360wfd.4
        for <git@vger.kernel.org>; Sat, 17 May 2008 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=apyiwcfYFrG4rZPWxWBnq9zBbt3K+RwSJnAslD8clI0=;
        b=Wf3FaXTx9yWkWEnuQOQxVN/46xQ0XWCdJyK/UXsYzYfPOv+W7Vg2tFEv7nKcBGWKJfHhFvvdVXUpTNYpSubnkeMBhWQ18cI6kbI6VckMKJv7MZGxrFe02pbvVCMNEFPkKT7waNiT3DN0WTGVx8JlWK83ulZjlXMlBM1ovhpzwqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mspw6SO1W7yl/LT32IesHd1r4wibPP8KfgTh5UfnDNpPIQqF51+fM5UmWtbQjgIw8iAWyUNVkVsxstByYIp/admHFrUD6LlF+iOjcM7T0nsZncFm99/YbUclrCljf1mOLLiIDTvqtDqWOwLwl0Ek7IaNbcnZxYIo3hHzaKcBjGk=
Received: by 10.142.82.6 with SMTP id f6mr2044270wfb.340.1211040735410;
        Sat, 17 May 2008 09:12:15 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Sat, 17 May 2008 09:12:15 -0700 (PDT)
In-Reply-To: <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82353>

On Sat, May 17, 2008 at 4:44 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
> With this dedication to backwards-compatibility, we'll be at Windows
> Vista quality in no time.

I very much agree here, given the nature of scripts (that is, being
very easy to update), I think we should try not to be too strict in
backwards-compatibility or we'll lose the flexibility that is very
much needed when developing a Good Product (tm) As long as such
compatibility breaking changes are marked (in BIG LETTERS) in the
changelog/release notes I think that would be a 'sacrifice' we should
consider making.

-- 
Cheers,

Sverre Rabbelier
