X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 12:09:03 -0700 (PDT)
Message-ID: <524029.7339.qm@web31812.mail.mud.yahoo.com>
References: <20061024113057.GA20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 24 Oct 2006 19:09:32 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=V79aExxE4W5XDnyRiHM8GZloYTnsRPJjznL+/4htMu/tLyF1AXc+2ZQlPKXRIzRkW1BSA384RvIwDECAu1FDy73thnBXDl4OL/FP+Jb0QlkRBBDKcZpWxJXkZuuSF2XQ5tTgiZMTI7Is68RVcAuRM41IvzhTKJmd9T1xt8tVFcI=  ;
X-YMail-OSG: hDA8A_8VM1laqYiV_7R5irgz4PvBW_6sRZOef8Pj
In-Reply-To: <20061024113057.GA20017@pasky.or.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30001>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcReE-0007j9-LK for gcvg-git@gmane.org; Tue, 24 Oct
 2006 21:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161188AbWJXTJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 15:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJXTJJ
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 15:09:09 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:26495 "HELO
 web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1161188AbWJXTJI (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006
 15:09:08 -0400
Received: (qmail 7449 invoked by uid 60001); 24 Oct 2006 19:09:03 -0000
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Tue,
 24 Oct 2006 12:09:03 PDT
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

--- Petr Baudis <pasky@suse.cz> wrote:
> > Why not instead re-submit a patch implementing what was discussed
> > in this thread bearing the same name:
> > 
> > http://marc.theaimsgroup.com/?t=116044914900001&r=1&w=2
> 
> This implements
> 
> 	http://marc.theaimsgroup.com/?l=git&m=116047939517299&w=2
> 
> I see no other ideas I could take there except various naming proposals
> and perhaps using File::Copy but I'll wait until someone does a
> gitweb-wide change for the latter.
> 
> I don't really care _what_ name it bears, but I'd like to have it
> included. :-)

People have suggested that this functionality be folded into the
"Description" column, where the description printed is the
first line of the description file "description" and if clicked
on, it shows the whole "descrption" file.

    Luben
