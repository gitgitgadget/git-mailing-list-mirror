X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: pushglobs
Date: Wed, 6 Dec 2006 21:40:56 +0000
Message-ID: <200612062141.05265.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 21:44:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dzGSKD/F0jM8fECVBa5rN8Y4OuzGB5Zsm4NGYmdMIs4clLAkugBopZBfieMHj58m65NXgOzoWL/8k0/ggIpSxw75VmJySwvSRR8UFVuPvNb8zjE41CCQ+iAs2w4cOWNh/9RF4au3ZoqdjRSEheqtpbb3Nru0+LHgdTYgf+23X50=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33524>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4Yb-0004LR-Po for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937665AbWLFVn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937678AbWLFVn5
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:43:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:2206 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937665AbWLFVn4 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 16:43:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so276752uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:43:54 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr1615029ugl.1165441434283; Wed, 06
 Dec 2006 13:43:54 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id u6sm34056223uge.2006.12.06.13.43.53; Wed, 06 Dec
 2006 13:43:53 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

The glob support in the fetches has gone down so well that I'm looking into 
doing the same for pushrefs.

The push work is done in C; so there is obviously no globbing support from the 
shell.  I know that git does globbing in other places, so wanted to ask if 
it's appropriate to use that rather than me write my own hacked up version?

The context is this:  I'm extending builtin-push.c:add_ref() to catch globbed 
refs and then recursively expand them.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
