From: David Aguilar <davvid@gmail.com>
Subject: Re: developing a modified Linux-style workflow
Date: Sun, 12 Dec 2010 19:31:47 -0800
Message-ID: <20101213033145.GA3609@gmail.com>
References: <7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Hans-Christoph Steiner <hans@at.or.at>
X-From: git-owner@vger.kernel.org Mon Dec 13 04:18:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRywE-0004eA-6s
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 04:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab0LMDSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 22:18:52 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49663 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605Ab0LMDSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 22:18:52 -0500
Received: by gyb11 with SMTP id 11so2771223gyb.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7RuGLbn/fjTySil3Q9tdxNAhE6V8MERSGSDlS71xYGg=;
        b=VyH0fqbmAFvfjBSrkqp0TlFVAq7fwJY5kaZaVXWNdDZ1+3xTLusBCnFp6UubFLi8Ig
         YeR+1DfxybZp4O8UwslhRIFtE7EgJx0JbYzJtsImww0DT55ivaynqPMBhdXoIk+uw4cv
         j9dkG/qE1eRbhsCMAu3VXFxUm89J46iMhYkks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZR+vKRXLP8LbUQ2iR00zTOHVRf0Rk/23ikew+ZKI7L+gg6JrXD+MT/0514XhdmLEdk
         9GzlTpg24NrN8NBiG8odthe8+f+wZ3SWaoBNI7UqrDHn8v+Gjwlmipn0klUMmX+Inh2+
         JMnn3Z9Fc5tKNinYrUVLRWLXIb+cZPhrWyS8s=
Received: by 10.151.42.9 with SMTP id u9mr5194302ybj.290.1292210331174;
        Sun, 12 Dec 2010 19:18:51 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id t38sm3678111yhg.9.2010.12.12.19.18.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 19:18:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163510>

On Sun, Dec 12, 2010 at 05:24:16PM -0500, Hans-Christoph Steiner wrote:
> 
> Hey all,
> 
> (and my second post on this list...)
> 
> I've gotten pretty good at git, and its helping me already with
> managing the very odd workflows I have with the software I work a
> lot on called Pd (http://puredata.info).  My role in Pd development
> is like a Linux lieutenant.
> 
> I also the main dev for an app called Pd-extended, which is based on
> Pd.  Now I'm stuck trying to figure out how to use git to match my
> current workflow for Pd-extended, which is a kind of long-lived
> branch, almost like a friendly fork.  So its kind of close to the
> Linux workflow with me as a lieutenant, but not quite.
> 
> What makes it tricky is that I make releases directly from my repo
> that are widely used.  So my repo is both lieutenant and dictator at
> the same time.  So that's where I am stumped.  I want to be able to
> rebase and push to a public repo, but that would be stupid.  So
> there has got to be another way.

Have you considered periodically merging Pd into Pd-extended
as an alternative to rebasing?  It might even be easier to
manage in the long-term.
-- 
		David
