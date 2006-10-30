X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/n] gitweb: Better quoting and New improved patchset view
Date: Mon, 30 Oct 2006 19:53:01 +0100
Message-ID: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 19:10:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GXYCk4n2DjCouQ9ZuQ6TeXRjUD6LzlF1i+46rwYvYo/fRfFoNwXI3xcI2UPQvzPw5oRukxTszFYJPhiYjG9BAnrYoWiJR44xT8PE4hAiZt4p53uy+IhDw/TfcPZ4Erw342dJHSfK2+QqM51ISAk8qhIc14LW4OH46lXqmiU4QVY=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30506>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GecMD-0003My-Kw for gcvg-git@gmane.org; Mon, 30 Oct
 2006 19:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161381AbWJ3S7N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 13:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWJ3S7M
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 13:59:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:28079 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161381AbWJ3S7K
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 13:59:10 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1226209ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 10:59:08 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr4698837ugj; Mon, 30 Oct 2006
 10:59:08 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 53sm3684599ugn.2006.10.30.10.59.07; Mon, 30 Oct
 2006 10:59:07 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This series of patches is meant to introduce 
"New improved patchset view" in part-by-part
case.

Would change only gitweb/gitweb.perl and gitweb/gitweb/css
-- 
Jakub Narebski
