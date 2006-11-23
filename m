X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: git crash when cg-fetch:ing dash
Date: Wed, 22 Nov 2006 23:47:37 -0300
Message-ID: <200611230247.kAN2lbLU006457@laptop13.inf.utfsm.cl>
NNTP-Posting-Date: Thu, 23 Nov 2006 02:48:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32114>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gn4d1-0006lv-8M for gcvg-git@gmane.org; Thu, 23 Nov
 2006 03:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757273AbWKWCrv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 21:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbWKWCrv
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 21:47:51 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:61703 "EHLO
 pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1757273AbWKWCru
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 21:47:50 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by pincoya.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id
 kAN2lbcC013851 for <git@vger.kernel.org>; Wed, 22 Nov 2006 23:47:47 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAN2lbLU006457 for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 23:47:37 -0300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I did:

  git clone http://gondor.apana.org.au/~herbert/dash/dash.git

and got:

  error: Unable to start request
  error: Could not interpret heads/master as something to pull

(broken repo? cogito only?). Then I tried:

  cg-clone http://gondor.apana.org.au/~herbert/dash/dash.git

and got:

  defaulting to local storage area
  Fetching head...
  Fetching objects...
  *** glibc detected *** git-http-fetch: double free or corruption (fasttop): 0x0869f858 ***

Known problem?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
