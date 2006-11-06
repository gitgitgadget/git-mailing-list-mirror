X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git reset --soft a merged commit
Date: Mon, 6 Nov 2006 11:48:49 +0700
Message-ID: <fcaeb9bf0611052048r11816e76p88d568e3478c354b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 04:49:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c+Z6s7gOgCfGmRbyHZOndr7tri8ZCmZot+WT5+fI/ruPK/YlmA+N29/Km0GgqToaBFeTuDIxWy97KTdGt48y6G0uS0C3woS2g5tC5ZKqI04f6TwjDnJwKnCRy2UzyMeFcdknd1WQYZ9LQjpmQoxiIUuD5tCRxk+xhVjeQPoKRqo=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30991>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgwQ3-00036L-3X for gcvg-git@gmane.org; Mon, 06 Nov
 2006 05:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423498AbWKFEsx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 23:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423499AbWKFEsx
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 23:48:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55593 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1423498AbWKFEsw
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 23:48:52 -0500
Received: by nf-out-0910.google.com with SMTP id c2so605509nfe for
 <git@vger.kernel.org>; Sun, 05 Nov 2006 20:48:50 -0800 (PST)
Received: by 10.78.128.11 with SMTP id a11mr6238234hud.1162788529828; Sun, 05
 Nov 2006 20:48:49 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Sun, 5 Nov 2006 20:48:49 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,
I did "git reset --soft HEAD~1" where HEAD is a merged commit and
committed again (nothing changed).  The new commit was not recorded as
a merged commit. Is it intentional?

-- 
