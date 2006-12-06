X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Topic descriptions
Date: Wed, 6 Dec 2006 21:53:28 +0000
Message-ID: <200612062153.30639.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 21:56:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qrxPiFCbAd4foOZUb7rObXMTrXevd/uEGxFHNl0mhnzo8CYmhjYwJBUYQ5toZg1n2SvYLAaD0h1K4Abnhj2HNiwaWohUeAQvk4/Qm64Ce8y2QVGlA6CqCr5kw49DQm06EBD1KNSCbnqFeDxDFwY51q0oxb43oS+DI7vSF4xsryc=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33528>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs4kb-0006MQ-69 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 22:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937694AbWLFV4V (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937691AbWLFV4V
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 16:56:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:20220 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937694AbWLFV4U (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 16:56:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so279993uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:56:19 -0800 (PST)
Received: by 10.66.243.4 with SMTP id q4mr1646971ugh.1165442179373; Wed, 06
 Dec 2006 13:56:19 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id a1sm34008173ugf.2006.12.06.13.56.18; Wed, 06 Dec
 2006 13:56:18 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I was just reading Junio's "what's cooking" summary, and it occurred to me 
that it would be excellent if git had support for this sort of thing.

It seems fairly easy - it wouldn't have to be versioned information.  Could we 
simply make .git/refs files be more flexible in their syntax.

-----
<sha1>
<anything at all>
-----

I don't know where the UI would go; but it would let Junio generate his what's 
cooking emails with cat .git/refs/*/*

Just an idea...


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
