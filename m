From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 23:58:42 +0200
Message-ID: <200708272358.43021.jnareb@gmail.com>
References: <20070826235944.GM1219@pasky.or.cz> <20070827001634.GB1976MdfPADPa@greensroom.kotnet.org> <20070827004153.GN1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sven Verdoolaege <skimo@liacs.nl>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 28 00:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPmsv-0003tf-1R
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbXH0WC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 18:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbXH0WC7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 18:02:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:6231 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbXH0WC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 18:02:57 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1292816nfb
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 15:02:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=IEgcDXMJ5wBjTNDSqbDy4pQQz1/FuBDfa8BdCqLaVJOUG+bD1YzDiwHn8DW2KKzfQ2+Au/3QpNnZ6irnzagufSP1Y1k3Y/b+21TXSGvDVYgSVoZFWTE3a9++/X4uCsXy4qdRs5nEuFFRbNTLBqR6lcLMH1v0P7o1Y/6MQ81Fhxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=LXE30uNxUTqytreMUlJTQQ9ahdFVNsGnIaz6OIXXFd6JCo23OAqUvU3lZmejZCzkOMtObxxj9slSBCIE4lrCgbF8ABmsRjGzVgj5K7Mz/B5VTaphoI6lWpaz2IsD2bFOo5gPwd+6868w+Z6AjH0GFYLJzjjhVtiA991SqrFrOAw=
Received: by 10.86.80.5 with SMTP id d5mr5245304fgb.1188252173429;
        Mon, 27 Aug 2007 15:02:53 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id v23sm5383314fkd.2007.08.27.15.02.51
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 15:02:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070827004153.GN1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56885>

On Monday, 27 August 2007, Petr "Pasky" Baudis wrote:
> On Mon, Aug 27, 2007 at 02:16:34AM CEST, Sven Verdoolaege wrote:
>> On Mon, Aug 27, 2007 at 01:59:44AM +0200, Petr Baudis wrote:
>>>
>>>   So now I wonder, what is the thing you miss most there? Any cool stuff
>>> repo.or.cz could (preferrably easily) do and doesn't?

Is it now possible to _upload_ SSH key, instad of copy'n'paste it
when creating repository/account?

Would it be reasonable to limit repository name length, or at least
modify gitweb to truncate (cut) it if it is too long?

>> Just a minor nit, but how about dropping the "git+" from the
>> Push URL?
> 
> I'm a major proponent of the "git+" - it's just the correct thing to
> specify. ssh:// by itself means secure _shell_, and that's not what the
> URL means - ssh is literaily just a transport layer for the git
> protocol. This is not my invention but fairly standard thing which
> plenty of people use, and it makes it possible to select proper protocol
> handlers and so on, shall something generic crunch on the URL. I've
> never actually understood why do some people dislike it.

First, it is in the context of git, so one can say that "git+" is
implied. Documentation mentions only "ssh://". That said I prefer
"git+ssh://" to "ssh://" alone.

Second, IIRC Linus prefers scp-like syntax for SSH protocol, namely
"[user]@host:/path/to/repo", so perhaps that one should be used
instead.

>> Jakub was also talking about support in gitweb for specifying
>> the location of submodules.  It would be nice if admins could
>> set this information, wherever it ends up getting stored.
> 
> Hmm, this shouldn't be very hard to do if the support will get into
> gitweb. And adding the support to gitweb shouldn't be that hard either.
> :-) OTOH, it's not something that would get me terribly excited, so I
> guess I'll wait for the gitweb side.

The problem is that repo.or.cz needs support for that in gitweb, while
gitweb in turn needs support for that in git. This needs git consensus
on how to specify object database location (or just gitdir) for
submodules, to have later submodule support in gitweb.

-- 
Jakub Narebski
Poland
