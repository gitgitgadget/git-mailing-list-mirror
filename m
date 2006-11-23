X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH/RFC] Implemented glob support in pull refspecs
Date: Thu, 23 Nov 2006 08:46:29 +0000
Message-ID: <200611230846.30602.andyparkins@gmail.com>
References: <200611230833.45904.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 08:46:55 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MdMC2UvPnkiV1SvMYn/GDAV1oIkb4j9AKBSEOv2rbEToIJ7tMABxTyS4pd0yLgh4gQ+xRl1u09Mqj2Ot4vfrVXC9lXXpMozXDlnRt3CjV13yGdS9BrkaA1JUsGEYeN6gbnbh6W6EDtu67gLP0hDDSuenhdHz+CMPQKT7z3Z/8oU=
User-Agent: KMail/1.9.5
In-Reply-To: <200611230833.45904.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32122>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnAE9-0002hN-B5 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 09:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933279AbWKWIqe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 03:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933282AbWKWIqe
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 03:46:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:41409 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933279AbWKWIqe
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 03:46:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so381717uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 00:46:32 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr4657877ugm.1164271592816; Thu, 23
 Nov 2006 00:46:32 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id l40sm11881960ugc.2006.11.23.00.46.32; Thu, 23 Nov 2006 00:46:32
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sorry for the resend; I didn't get a copy of my send from last night from the 
mailing list so thought I hadn't sent it.

Please ignore this dupe.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
