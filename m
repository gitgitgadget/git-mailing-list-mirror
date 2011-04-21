From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Fork or branch?
Date: Thu, 21 Apr 2011 22:33:20 +0400
Message-ID: <20110421183320.GA17298@dpotapov.dyndns.org>
References: <1303390999618-6293910.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: adam_kb <a-kyle@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCyh0-00024H-DR
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 20:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab1DUSd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 14:33:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64646 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab1DUSdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 14:33:25 -0400
Received: by bwz15 with SMTP id 15so33627bwz.19
        for <git@vger.kernel.org>; Thu, 21 Apr 2011 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0OWh5BEv2wlnsNDafblT/UwrrF2641cCByViH4p993M=;
        b=mC71cmhcUFcKPs5f2YWdJZ9EjwAkJVt6Lu4+8IQYSF7KjW04wpwnawuMzPGoTQGkr9
         0rk4hDcsxpUUACWkKM8dL3F8xvcyDSOwtmQmAr108gsKvgqIFKthVsQeHkPj4CvMiZPk
         E9R9PU4eXrAihjHY1pE8vL4YY+rcbfPwhCC0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IuefhRsmzYsNLWucohvFfIWowBVAq8S5sCoPGIfL4o3mvKqJJx3926QKLfSWZNK9n1
         iaC0OwYgMWwSmHnZYifZVoLvTBVVpzXKDFNDOByQUlIku87YbBbgF3TeLVRCNYxZYq3G
         TJSNyqJ5trKW7rJCIKaELzagYkSFpeqQgPxJU=
Received: by 10.204.82.74 with SMTP id a10mr226387bkl.96.1303410804075;
        Thu, 21 Apr 2011 11:33:24 -0700 (PDT)
Received: from localhost (ppp91-76-213-107.pppoe.mtu-net.ru [91.76.213.107])
        by mx.google.com with ESMTPS id q24sm1267026bks.9.2011.04.21.11.33.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Apr 2011 11:33:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1303390999618-6293910.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171912>

On Thu, Apr 21, 2011 at 06:03:19AM -0700, adam_kb wrote:
> I am new to git and understand most of it except for merge. My question is -
> if I have project X on branch master and its coded in python but I then want
> to take that same project and code it in say C or C++ would I fork or branch
> the project? 

It depends whether you want to have separate repositories (with separate
working tree) or you want to have in the same repository. Actually, it
does not matter all that much what decision you make now, you can always
change that later -- it is very easy to unite two repositories in one,
and, on contrary, it is always possible to split branches. Obviously, if
you split branches having some common commits, each clone will have them.

Personally, if I re-wrote some Python code in C or C++, I would probably
make a separate clone just to have two working tree. If necessary, it
is possible to merge changes between them using 'git pull'.


Dmitry
