From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 8 Sep 2006 19:28:46 -0400
Message-ID: <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	 <20060908184215.31789.qmail@science.horizon.com>
	 <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 09 01:28:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLpmE-0002RO-Km
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 01:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWIHX2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIHX2s
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 19:28:48 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:57634 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751283AbWIHX2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 19:28:46 -0400
Received: by py-out-1112.google.com with SMTP id n25so1018619pyg
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 16:28:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c4AvWVom5UYMXCOnN9Fz27pDBdgUFjf2HMtYz8+DszBCxuqbV1E6Xi+X+c8AB5qv6cE2zH/baWimMcGNNZEuqa0Soe5hVEVEfI5bPD8Gs1fyZ5LpMOiQMQDn+WvanqNpoAREWurs8fF/v/WhcXa4kRhMbNmIc/tTNKL3ukmK3p0=
Received: by 10.35.54.1 with SMTP id g1mr3856838pyk;
        Fri, 08 Sep 2006 16:28:46 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Fri, 8 Sep 2006 16:28:45 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26726>

On 9/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
>   Getting rid of the --topo-order requirement would speed up gitk
>   absolutely immensely, especially for unpacked cold-cache archives. So it
>   would probably be a good thing to do, regardless of any shallow clone
>   issues ]
>
> Hmm?

gitk takes about a minute to come up on the Mozilla repo when
everything is in cache. It  takes about twice as long when things are
cold. It's enough of delay that I don't use the tool.

>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
