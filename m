From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Sat, 26 Aug 2006 07:43:04 +0200
Message-ID: <e5bfff550608252243n61ac8adar78c292f2f1cee50c@mail.gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
	 <200608252135.27894.jnareb@gmail.com>
	 <e5bfff550608251433o36713ee1na5544992320b5845@mail.gmail.com>
	 <7vveog45ff.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550608252144p2d234a7cnf2ca2922c98d921b@mail.gmail.com>
	 <7vejv43wq9.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550608252234u6d4e9efax8ca7e2225cef4cef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 07:43:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGqwo-0008GF-Qq
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 07:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWHZFnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 01:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWHZFnH
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 01:43:07 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:56112 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964807AbWHZFnF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 01:43:05 -0400
Received: by py-out-1112.google.com with SMTP id n25so1550746pyg
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 22:43:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XeDE/g6T+g2m/l7Op3UoaGo5Pku1CLVI6qZsxCNQfXUypMgv/ZHhbAQC/AgG8ENey0BlpMxPPwXGQNaxkZno1yF5RgW7j9UIKb/Ee/uym0XHG7fsV773Js5UAwiHIgUaPX6Qo0Wz6q+XGBH+ElVWW1Wjbs5oMZKt0QM+UvTiUaE=
Received: by 10.35.36.13 with SMTP id o13mr6754602pyj;
        Fri, 25 Aug 2006 22:43:04 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 25 Aug 2006 22:43:04 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <e5bfff550608252234u6d4e9efax8ca7e2225cef4cef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26032>

On 8/26/06, Marco Costalba <mcostalba@gmail.com> wrote:
> > Actually Linux git archive _is_ a special, odd-ball case.
>
> It's also our main customer ;-)
>

More seriously, do you foreseen reasons for an SCM to split old
histories (more then, say few years and some GB ago) in a separated
repository?

Now in Linux we have the historical repo and is splitted because it
was borne splitted, but do you think this could be also an acceptable
policy for a big project after years of git use: to backup old stuff
and keep recent one snappy?

With snappy I mean a long list of things: cloning, getting file
histories / blaming, packing, fsck-ing, etc...

The net effect could be a better browsing/handling experience in the
99% of cases where you need to check recent work (say last 2 years)
and in any case the possibility to do some archeologic research when
needed.

Marco
