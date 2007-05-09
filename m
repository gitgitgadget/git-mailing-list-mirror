From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 9 May 2007 22:01:22 +0200
Message-ID: <8c5c35580705091301s19dcd2e0q20a4c84e3dd23d82@mail.gmail.com>
References: <11787000032830-git-send-email-hjemli@gmail.com>
	 <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
	 <20070509185440.GB3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsLo-0001CU-GJ
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXEIUBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbXEIUBX
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:01:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:58030 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXEIUBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:01:23 -0400
Received: by nz-out-0506.google.com with SMTP id o1so329298nzf
        for <git@vger.kernel.org>; Wed, 09 May 2007 13:01:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gxYd8T8S7+68a68U/eRMnNyPDUOMdF3deAV1qL+VbXzXnw+nQE8A6VyytfX4l1VrWAFwRZbDDoxM5WcS+l4ybZd0g13/ejyxexjBurOg/NHaO/sW7Tgx2TR6YgXd9wr7SZrAokvVTavvIZHUGgTf/hjdWT8IgEApduTJBVPr6A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jZd8C14onZJIGedbvkm8/Am2AZysNw7c1miMfCxGMlHnJGBF7sfxWo5RlDgPdqnkLyIkIwjDZBYpYivOY5Is02tYd/vnnf5v5XUfLmX/SwurqYnHxUehNi5vjrh9tcxKu1yjRW9ocIZHKHnRIIXNkxwLjQOcm4qBYL40/lJVv84=
Received: by 10.114.201.1 with SMTP id y1mr267335waf.1178740882093;
        Wed, 09 May 2007 13:01:22 -0700 (PDT)
Received: by 10.114.234.19 with HTTP; Wed, 9 May 2007 13:01:22 -0700 (PDT)
In-Reply-To: <20070509185440.GB3141@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46774>

On 5/9/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Lars Hjemli <hjemli@gmail.com> wrote:
> > I'm playing around with a gui frontend, and there I use
> > git-for-each-ref to obtain possible arguments for git-checkout. That's
> > how I discovered the 'problem', and solved it by stripping
> > 'refs/heads/' in my frontend. But then I thought it would be nice if
> > 'git-checkout' did the stripping on my behalf, since this might bite
> > others too :)
>
> If you are building "porcelain" to sit over Git and offer up a pretty
> view of things, I would encourage you to avoid the stock porcelain.
> Don't use git-checkout, its stock porcelain.  Instead go right to
> the plumbing.  The plumbing doesn't really change behavior as often
> (if ever).

Thanks, I probably will (also to avoid the shell scripts, since my
porcelain is aimed at my co-workers who are stuck on windows)

-- 
larsh
