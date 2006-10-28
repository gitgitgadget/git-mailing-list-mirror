X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Sat, 28 Oct 2006 23:23:57 +0200
Message-ID: <200610282323.57797.jnareb@gmail.com>
References: <200610281930.05889.jnareb@gmail.com> <7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 21:24:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bQeQYQ+4pP+AVKNGvAwDkEIAN20CHFVU6+s74uhyk7KgyY+BIiYXd/LDBVn9CrfVuBL5pcU5gio14SwMhR0ZqK1anZWkpiYbWFZBaPjDtgCbpzvMOSC1VGN9luozfpU4dqRMfpDzoHQYCEa7Jgd1/7eKxEZP3xsWpp8iyGhO/ws=
User-Agent: KMail/1.9.3
In-Reply-To: <7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30399>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdvf5-00067M-Uw for gcvg-git@gmane.org; Sat, 28 Oct
 2006 23:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964869AbWJ1VYL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 17:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWJ1VYL
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 17:24:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:28939 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S964852AbWJ1VYJ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 17:24:09 -0400
Received: by ug-out-1314.google.com with SMTP id 32so915517ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 14:24:08 -0700 (PDT)
Received: by 10.67.93.6 with SMTP id v6mr1739805ugl; Sat, 28 Oct 2006
 14:24:08 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id l33sm1029057ugc.2006.10.28.14.24.07; Sat, 28 Oct
 2006 14:24:07 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> [PATCH] for-each-ref: epoch and epochdate
> 
> This adds "epoch" (which is parallel to "tagger" or "committer")
> and "epochdate" (corresponds to "taggerdate" and
> "committerdate").
> 
> As other "date" fields, "epochdate" sorts numerically
> and displays human readably

I was thinking about having only "epochdate" (corresponding to either 
"taggerdate" or "committerdate"), only named "epoch". There is I think 
no need for field which would be "tagger" or "committer", and 
especially not named "epoch" ;-).

Otherwise looks fine, thanks a lot.


BTW. I had to translate
+       if (strcmp(who, "tagger") && strcmp(who, "committer"))
to
+       if (strcmp(who, "tagger") == 0 || strcmp(who, "committer") == 0)
to understand it. But this is probably my lack of contact with such
C idioms.
-- 
Jakub Narebski
