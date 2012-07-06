From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 5 Jul 2012 19:30:24 -0500
Message-ID: <20120706003023.GA15387@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1374057.qfvOg1c6C6@flobuntu>
 <23122876.7xH9dZiP4M@flobuntu>
 <20120702110741.GA3527@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 02:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmwRY-0007a3-95
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 02:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952Ab2GFAaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 20:30:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65228 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793Ab2GFAac (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 20:30:32 -0400
Received: by yhmm54 with SMTP id m54so8863865yhm.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 17:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OvJNDq7UftHaC5Hz4ryb4gnUo74mJSO01yuADP0WG4M=;
        b=cVTjCW/NRHUVDLD46/bVxCfp+kJpQBEQzf2Ek5lmlR6B9PR3G2xpR+OUrsF7zKeaDT
         taTEWNQbcKbnCQfvQmQ2w75pky4+l00Nmp3hEx4WRj86hy6aWvU8bga26WKjto3ivHap
         yKTv27JkSJ9UOA24efBieAjZ5b3k7MdGHygj72ZQJ0ZVNAOl2v1Zf5cNUxchAd1H6MVW
         72oe4AA9Hw4hI5QUGkDh/qg/+QK8eDrs9iI7RrT/fKYg1wQnkEwfHKhQQ7V/1r91UUI3
         jEoVoyePePK7c11pHxE0vMaKkUICEs5N02hgGEsLBBV8UAZ15hyY6UWMAihnxvTo8OOE
         mygQ==
Received: by 10.50.168.1 with SMTP id zs1mr1175172igb.45.1341534631274;
        Thu, 05 Jul 2012 17:30:31 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ai6sm2460394igc.0.2012.07.05.17.30.30
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Jul 2012 17:30:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120702110741.GA3527@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201081>

Jonathan Nieder wrote:
> Florian Achleitner wrote:

>> Experimental implementation.
>
> Ok, so this adds a new program named "remote-svn".  How do I build it?
> What does it do?  Will it make my life better?
[...]

I forgot to say: thanks for working on this!  I hope my comments are
not demoralizing.  They are meant in the opposite vein --- if I
expected you to be a one-time contributor then I would just take what
is useful from the patch and let it be, but I would be happy to see
more changes from you in the future so I gave some hints to explain
how.

The next step is to work with the list to figure out what a second
version of the patch should do, and then to send that with something
like "RFC/PATCH v2" in the subject line to clarify that it supersedes
this one.

If you have any questions about the review or the codebase in general,
please don't hesitate to ask.  Especially, if you get stuck on
something and documentation is unhelpful, please do complain. :)

Hope that helps,
Jonathan
