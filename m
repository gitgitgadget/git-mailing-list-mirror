X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: git-format-patch little gripe
Date: Fri, 3 Nov 2006 01:07:20 -0800 (PST)
Message-ID: <376237.14965.qm@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 3 Nov 2006 09:07:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=pXiMNfq/s3pjkE4L1SEvWqhwStGdlqsxu2CQJpr/HcaNiJAOu+GlenU9Xoba5fu5lvvWIxvrn8HaI2kAtrUHed1jjkirGwnwZKyaSdYO7qiNZAK68ngn8CRqlYwBSBCRkVsgykPObjxWAlnMRssweyeXpfarPMET7e7aaA/7geU=  ;
X-YMail-OSG: sjK_mfsVM1nIiPFwveVLbri2UGRl3Ige2MO1exWfsjr46X5wglmfr1dS1Mu_WXB06jSFzc2uXuGMBEmiIwhb_sK9j1flUz.Gzy0cbR3cNsIku92_6grn.6Zf3I_sOf86Sy3eoNm8GyKU5Do-
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30801>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfv1P-0008E0-3J for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752713AbWKCJHX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbWKCJHW
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:07:22 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:6553 "HELO
 web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1752713AbWKCJHV (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006
 04:07:21 -0500
Received: (qmail 16433 invoked by uid 60001); 3 Nov 2006 09:07:20 -0000
Received: from [71.80.233.118] by web31805.mail.mud.yahoo.com via HTTP; Fri,
 03 Nov 2006 01:07:20 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Yep, after more than a year, I simply cannot get used to it...
http://marc.theaimsgroup.com/?l=git&m=113259043217761&w=2
And as I've seen, other people brought that up too.

My brain simply says:
`` "git-format-patch" is singular and so the SHA-1 specified
   on the command line should generate a _single_ patch.''

Yeah, but no.

So I still make the mistake of:
# git-rev-list --no-merges --pretty=one-line HEAD -- <somepath>
    I select a commit
# git-format-patch -o /tmp/ <commit>
...
    Oh, f@#$!  <CTRL-C>
# git-format-patch -o /tmp/ <commit>^..<commit>

Is there a chance to make "git-format-patch" output a single
patch? of that commit only?

    Luben
P.S. And let "git-format-patches" go wild with the ideologies...
Sorry, needed to vent as I made this mistake twice already
today...





