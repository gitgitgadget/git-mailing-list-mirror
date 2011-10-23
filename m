From: David Aguilar <davvid@gmail.com>
Subject: Re: git mergetool ignores configured command line
Date: Sun, 23 Oct 2011 03:35:01 -0700
Message-ID: <20111023103459.GA29816@gmail.com>
References: <CAARCrw6D7CKy2Jn43zUZ3EefyqdY6Tk4A39ZQ74H6hySA5eCBQ@mail.gmail.com>
 <m21uu4hzmq.fsf@linux-m68k.org>
 <7vaa8s592k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Alexander Vladimirov <alexander.idkfa.vladimirov@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 12:35:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHvOy-0004r1-SY
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 12:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab1JWKf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 06:35:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:54063 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1JWKf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 06:35:26 -0400
Received: by pzk36 with SMTP id 36so14059364pzk.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7Z4dLQG7mzAWC0hBIRtpvtGk8Zjp5tSRtux+KMpTA6Q=;
        b=FvMXL8kLdnL+2ESMGALLmSX2wjqHUMjYuOtmG+7b9kOrXJ1RuDAjuIq8Zw0Zs64ksI
         JaQGXZSqU2fUcT4M6l4FhBuoS6x08drSiLBiEPWNl4b6NRlYRcy7ngasKWloh9c/lKmx
         nvPYFKWJ4gvSWcEUU3qTV0NxYqacsuerm2qLI=
Received: by 10.68.38.132 with SMTP id g4mr37101503pbk.122.1319366125454;
        Sun, 23 Oct 2011 03:35:25 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ko15sm53767097pbb.9.2011.10.23.03.35.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 03:35:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaa8s592k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184134>

On Sun, Oct 23, 2011 at 02:52:19AM -0700, Junio C Hamano wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > diffuse is already a predefined merge tool, so mergetool.diffuse.cmd is
> > ignored.  Try using a different name.
> 
> I wonder if we can improve this, though.
> 
> It is nice that we give canned definition of argument order to so many
> obscure tools, but instead of ignoring mergetool.<tool>.cmd when the user
> told us to use <tool>, couldn't we simply ignore what we have internally
> as canned definition?
> 
> Even if such a change were too intrusive (I didn't check), could we have
> a decency to at least warn that we are ignoring the configuration?

I agree.  Ideally, we should honor their configuration.
I'll see if doing so is not too intrusive.
-- 
					David
