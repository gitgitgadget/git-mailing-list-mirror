X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Making literal "20" symbolic
Date: Mon, 20 Nov 2006 11:49:35 +0100
Message-ID: <200611201049.41024.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 10:50:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iAchpMhwaM1CuMD+gPJh3u66LU+Cve8TSsQxWy2a/rm/NBb+2WNABI0QYwTzTLkklijl13cwS0jZKDQZcmyhWInbdE77t1hOYI/Yvtx85d7z1BGalKHJ/q6dXCpNNGkEdepVnCbW9LQdeFMWjWM4Lz+kbeVP4A2FFe833YzOPgE=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31900>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6io-0003RH-UD for gcvg-git@gmane.org; Mon, 20 Nov
 2006 11:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755036AbWKTKtu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 05:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755748AbWKTKtu
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 05:49:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14489 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755036AbWKTKtt
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 05:49:49 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1138654ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 02:49:48 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr2544761ugg.1164019787457; Mon, 20
 Nov 2006 02:49:47 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id w40sm4120271ugc.2006.11.20.02.49.47; Mon, 20 Nov 2006 02:49:47 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I notice that there are a lot of uses of the literal 20 throughout git; I'd 
like to change them (as appropriate) to HASH_WIDTH, or similar; and maybe 
HASH_WIDTH_ASCII for the 40s.

Is there a particular header file that is appropriate to put 

#define HASH_WIDTH 20
#define HASH_WIDTH_ASCII (HASH_WIDTH*2)

Of course, I plan to review each instance to make sure I'm not changing a 
non-hash width 20.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
