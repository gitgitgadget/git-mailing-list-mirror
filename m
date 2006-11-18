X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Possible but in gitweb
Date: Sat, 18 Nov 2006 11:06:52 -0800 (PST)
Message-ID: <20061118190652.29135.qmail@web31810.mail.mud.yahoo.com>
References: <200611181921.25873.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 18 Nov 2006 19:07:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0uqxtaj+8Er4Nf/TqyAhBgK2vxP3xDe+C4Oec6bpiq+jKwJuiiykAVfYgmESy2vjqYegtRt1JlDEhMcHcbbT9z5tmpgOwsY5SUh5H6vLu+ZNcDwq1qV4xwn+h0WPUrJCgKbUjfheqqvl15S5xyfqoeBK3issbwzUB+7jHzl24oA=  ;
X-YMail-OSG: h_XBAasVM1l.EIkYCrBg4A1kkNbSyfswrwMGmF1k3UFQ5FWBc99sG9MgsU7Jdh7De2XWua_Ua1G01sxKYOrkFWasKPLNpxH3YFyabdXX5ahNplFxp0zXJ5pFsYeTlID0fp7mvkg76_oDRitDfwST94gPocg8YwCJUsT5wIMbHS4ruISu_gvWdujdZDBaHYEzJJIydxbWyw--
In-Reply-To: <200611181921.25873.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31793>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlVWj-0003YD-CP for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755325AbWKRTGy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbWKRTGy
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:06:54 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:51358 "HELO
 web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1755325AbWKRTGx (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 14:06:53 -0500
Received: (qmail 29137 invoked by uid 60001); 18 Nov 2006 19:06:52 -0000
Received: from [68.186.56.98] by web31810.mail.mud.yahoo.com via HTTP; Sat,
 18 Nov 2006 11:06:52 PST
To: Jakub Narebski <jnareb@gmail.com>, Paolo Ciarrocchi
 <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Paolo Ciarrocchi wrote:
> > On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> Paolo Ciarrocchi wrote:
> >>> On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >>>> Paolo Ciarrocchi wrote:
> >>>>>
> >>>>> Browsing the repo I reach the following URL
> >>>>>
>
http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;hb=HEAD
> >>>>> that is not accessible.
> >>>>
> >>>> Because HEAD is master, not html, and there us no such file in master branch?
> >>>
> >>> Fair enough but then there should be no link in the web interface.
> >>> That sounds like a bug in the interface.
> >>
> >> Where did you find this link? On what page?
> > 
> > Here:
> >
>
http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;h=b5e39498997930cd14ecddfe120f62c577ce2e28;hb=html
> > 
> > try now to press "HEAD"
> 
> Ah, well. This could be considered a bug... but it can be not.
> The link is clearly marked "HEAD", so you are requesting HEAD
> version of the file... which does not exist.
> 
> We could check if the file has HEAD version, but that is another
> call to git commands.
> 
> What you want is the link to the tip of branch ("head", "top" or "tip")...
> you are welcome to add that (or replace "HEAD" link with that).

I think so too, at lest this is the intention: "head of line", "latest"
whatever you want to call it, in the branch context one is at.

    Luben


> Tip: href(...,hash_base => $hash_base,...)
> 
> -- 
> Jakub Narebski
> Poland
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
