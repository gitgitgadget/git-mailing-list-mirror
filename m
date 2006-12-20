X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: warning merge message
Date: Wed, 20 Dec 2006 13:22:59 -0800 (PST)
Message-ID: <867728.44872.qm@web31814.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 21:29:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 16:29:40 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Tp4p0tkaVDa27a1kafZEuyPM9b8AWziAXlgdkJvim+pwcvyQ03qXt6zutLIQOcmjeoMNQrrGH/2j8jKQE43UmykG46cijRDLeT/f+8mluas7nBSOBbW5+DBRt5CoM6lbtdIM90NwnNixc4yhLKqO5XUkbMJIyaF2gj+j0i4+zrQ=;
X-YMail-OSG: sIwN5KkVM1nnBTqC2vOa14MU_oQ_eh4FcdYM53zjQfgDC.XBVLE2Y6i_bg5t97A3d6viTRN9_9Ce3n8uEhIrwKegZCtC9BdWKL8lhLrX5Egw98CALGbDivXJRSl0JoE8CO1UFGm7r0bPVySm6BN7aBnfs2dkIOZry51tEKG79BtH91hTG0ubPacKQ06p
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34963>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx90S-0008Hx-5n for gcvg-git@gmane.org; Wed, 20 Dec
 2006 22:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030364AbWLTV3l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 16:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWLTV3l
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 16:29:41 -0500
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:26188 "HELO
 web31814.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1030364AbWLTV3l (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 16:29:41 -0500
Received: (qmail 45379 invoked by uid 60001); 20 Dec 2006 21:22:59 -0000
Received: from [64.215.88.90] by web31814.mail.mud.yahoo.com via HTTP; Wed,
 20 Dec 2006 13:22:59 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Can we please eliminate this f@#$ing message:
Warning: No merge candidate found because value of config option
         "branch.master.merge" does not match any remote branch fetched.

This message simply means:
Warning: you're not conforming to some merge policy that I've
     set forth in such and such of my patches committed to git.

If the default behavior is the old, current, well established
behavior, then I see no reason for this "scary" f@#$ing message
to be printed, "warning" me of some "problem".

Thanks!
    Luben
