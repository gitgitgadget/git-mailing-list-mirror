From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Tue, 13 Sep 2005 00:03:07 +1200
Message-ID: <46a038f9050912050367418617@mail.gmail.com>
References: <46a038f905091101529e045af@mail.gmail.com>
	 <7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
	 <46a038f905091200245f6330d9@mail.gmail.com>
	 <46a038f905091202343306846@mail.gmail.com>
	 <7voe6yik0o.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 14:06:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEn1w-00031l-Cn
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 14:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVILMDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 08:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVILMDL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 08:03:11 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:45639 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750769AbVILMDK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 08:03:10 -0400
Received: by rproxy.gmail.com with SMTP id i8so334822rne
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 05:03:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TmNDpZpXK2F082S8B3hRA3KWRf9khdbiedZzQUE2kcx0L1Qv/n8yVcSoTHASQANbUBzDl4uHTRIhe8zY5eGjJTOc8JPuSv9fprjPS06ea0lQ6p98Inolwem4lWEcmqdW+rH5AifDocdZmEXZ7r2mkVLUbLdgHo2333brmu+p9JA=
Received: by 10.38.92.80 with SMTP id p80mr277938rnb;
        Mon, 12 Sep 2005 05:03:07 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Mon, 12 Sep 2005 05:03:07 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe6yik0o.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8378>

On 9/12/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
> 
> > Strike that. PEBCAK: my branch entry was pointing to the wrong place. Sorry.
> 
> Thanks for quick correction.  Just from a curiosity, do you run
> GIT from the proposed updates branch?  I am asking because that
> suspect git-format-patch change is supposed to be only in there.
 
I'm running git on ~5 different machines. On the box where I do my
development, I have both 'master' and 'pu' checkouts, but mostly
master. Elsewhere, I track master, with updates every few days, when
my gut feeling is that things aren't too risky. On the servers (add ~4
servers to the list), I deploy only tagged versions, usually from the
Debian package.

And it was a total PEBCAK. I had just pulled in your latest merges to
master and built/installed on a dev box, things were looking odd and I
jumped the gun badly. As you point out, I didn't even have the patch
in.

cheers,


martin
