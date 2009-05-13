From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The 9th production of the msysGit Herald
Date: Wed, 13 May 2009 02:49:52 -0700 (PDT)
Message-ID: <m3d4adl4cl.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0905130225330.27348@pacific.mpi-cbg.de> <81b0412b0905130237h3bc29c80od4a8a8ad12a972a7@mail.gmail.com>
Reply-To: jnareb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, msysgit@googlegroups.com, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed May 13 11:50:14 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-1516.google.com ([209.85.146.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4B6F-00008a-IR
	for gcvm-msysgit@m.gmane.org; Wed, 13 May 2009 11:50:07 +0200
Received: by wa-out-1516.google.com with SMTP id k39so313393waf.53
        for <gcvm-msysgit@m.gmane.org>; Wed, 13 May 2009 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:received
         :received:x-authentication-warning:to:cc:subject:references:from
         :date:in-reply-to:message-id:lines:user-agent:mime-version
         :content-type:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=+mDRC1O8kv1TWgM774vs22WzNfjfTBwXQFBXnFhEPmM=;
        b=LdW1u7cE6c5+53eF59CiVAfYsMUXuxpA9CDA69AwgX9x4Dkr6j5uIqX1ZGmaqbZbg9
         aKCNhKyq/gz7qNIdR6RuNsv0hL5UsL9goLD/P7llN4XBw/7BXt8K8eJgz8ltzIh8v8IQ
         s+K+9OVGc/sEDe+W3kmVNOIwJqnfe0+7w1mLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:x-authentication-warning:to:cc
         :subject:references:from:date:in-reply-to:message-id:lines
         :user-agent:mime-version:content-type:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=5Q+NQTzD0oslw8dd4lC564k+cCHpUfi6V/AshTYU9jpKyTXUGgGU1KhMFvOFoGOQUK
         UMkAGx3xBdFvOW5v4UxhlNJOZv8zK81teADaYRp4iafIYRGoYFcrLLAnFY82Hp4dBEVz
         t9EBc+N/ERFjuc9JYTOA+uj+I3BNNXEPBnVh4=
Received: by 10.114.73.6 with SMTP id v6mr130216waa.25.1242208196004;
        Wed, 13 May 2009 02:49:56 -0700 (PDT)
Received: by 10.107.5.24 with SMTP id h24gr5214pri.0;
	Wed, 13 May 2009 02:49:56 -0700 (PDT)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.123.1 with SMTP id v1mr138919wac.1.1242208195573; Wed, 13 May 2009 02:49:55 -0700 (PDT)
Received: from mail-pz0-f107.google.com (mail-pz0-f107.google.com [209.85.222.107]) by gmr-mx.google.com with ESMTP id k19si465606waf.5.2009.05.13.02.49.54; Wed, 13 May 2009 02:49:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 209.85.222.107 as permitted sender) client-ip=209.85.222.107;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 209.85.222.107 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by pzk5 with SMTP id 5so204585pzk.14 for <msysgit@googlegroups.com>; Wed, 13 May 2009 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:received:received :x-authentication-warning:to:cc:subject:references:from:date :in-reply-to:message-id:lines:user-agent:mime-version:content-type; bh=5cx7RDZsa3meA9bowq175szfpwjzRstzenqE6WKHRDw=; b=P4vsR+z82EChR5dAwvGtszVvI7iBasetZGvwRjwIz+C+qRGEXf5koJkXCKRiYGlXQ3 fbA13/mYiUlUMXSxx4icX+RaXMS/1BFt0FH+GNseLVGkw1GoyBptDu+mQ+tLJImukxxW 0j6xVTkVwTYprkOYpjo2fchuaFb18GwZ5Dvj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=x-authentication-warning:to:cc:subject:references:from:date :in-reply-to:message-id:lines:user-agent:mime-version:content-type; b=J5Cd/MiqAShI0f/NACdAWl/NVyI73NgEVT3a1T6Z+SbNYRW5pycMq1bF2sHHH0SF+j Tofv0whPFe3sXd8Nr22T+AVc9WlIMWi+QmaC2r8yh2SDVDGTErN3j9BDLSBItbrb2hNO +jBlwkPtL3dfOrFpepd05hIaAEgJgUSbIh1Nc=
Received: by 10.115.92.2 with SMTP id u2mr607415wal.228.1242208194413; Wed, 13 May 2009 02:49:54 -0700 (PDT)
Received: from localhost.localdomain (abwb156.neoplus.adsl.tpnet.pl [83.8.225.156]) by mx.google.com with ESMTPS id a8sm3484414poa.3.2009.05.13.02.49.51 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 13 May 2009 02:49:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4D9nkJL009497; Wed, 13 May 2009 11:49:47 +0200
Received: (from jnareb@localhost) by localhost.localdomain (8.13.4/8.13.4/Submit) id n4D9nk1U009494; Wed, 13 May 2009 11:49:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <81b0412b0905130237h3bc29c80od4a8a8ad12a972a7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119016>


Alex Riesen <raa.lkml@gmail.com> writes:
> 2009/5/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> > I will delete comments on the Wiki that do not contribute value, I
> > will delete comments on the Wiki if they are just not comments but
> > insults (and I will even delete commants that are useful after
> > addressing their concerns), I will remove comments on the issue
> > tracker that I do not like because they are abusive or just rantings,
> > and I _will_ delete all mails in the Google Group that I find
> > offensive.
> 
> You can try to setup bogofilter (the spam fitler) or spamassassin on
> the comments. IOW, I fully expect you to be overwhelmed with all that
> housekeeping one day.

Errr... spam filter wouldn't help deleting insults / abusive comments
/ rantings...  Besides, wouldn't Akismet be a better solution for
anti-SPAM on *wiki*?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
