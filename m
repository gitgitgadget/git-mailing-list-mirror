From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Remove redundant "commit" link from shortlog
Date: Fri, 6 Oct 2006 11:27:20 -0700 (PDT)
Message-ID: <20061006182720.88733.qmail@web31812.mail.mud.yahoo.com>
References: <20061006135508.GO20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:28:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuQ8-0003Gn-Jw
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422820AbWJFS1X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWJFS1X
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:27:23 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:62395 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422820AbWJFS1W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 14:27:22 -0400
Received: (qmail 88735 invoked by uid 60001); 6 Oct 2006 18:27:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bEQPypA2wLwdGwUvSEBCemVPAd/v3POdX3Iy51u6FqchOxG9TXStckw/rOLBL5lBeKj0McM58sm242jbTP3gfyrERekzCN0mPPy6xFGTkqpAolCB3G46JDYUGWofI03PhelaAeKY/DUxV9WqvlMo63hhFNEdDA6IcuHo3oFHSpM=  ;
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 11:27:20 PDT
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006135508.GO20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28427>

--- Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Sep 29, 2006 at 01:48:40AM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
> > Remove the redundant "commit" link from shortlog.
> > It can be had by simply clicking on the entry title
> > of the row.
> > 
> > Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> 
> And what if the commit message is empty?
> 
> Witness at http://repo.or.cz/?p=test;a=summary

Clearly a pathological case.  Who or why would anyone do this?
I don't think we should worry about such pathological cases.

Commits without commit messages do not question GIT.  They
question the committer... (that's the morning chuckle)

    Luben


> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> #!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
> $/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
> lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
