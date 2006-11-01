X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "John Rigby" <jcrigby@gmail.com>
Subject: binary patch compatibility
Date: Wed, 1 Nov 2006 14:03:28 -0700
Message-ID: <4b73d43f0611011303m3e58b227x1a0bd60a9719f9f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 21:03:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f5awQzhe1QMpAaz/v2eRZJjWx4I2Zzc+BIAYdwZov1Pvw5U/lEV/w/zhhebgyuufBHSCGYlQ+hd9tS+XYiW2U5gWuzbnYh47TpqRRw+wJW2nIn5fuzoi+TaMellHVJVhdLLdeY/vD1W3aKn8JjDkIYTfH6peknk5P3Kb3/NqReE=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30657>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfNFI-0001JQ-Ah for gcvg-git@gmane.org; Wed, 01 Nov
 2006 22:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751251AbWKAVDc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbWKAVDc
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 16:03:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:1411 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1751251AbWKAVDb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 16:03:31 -0500
Received: by nf-out-0910.google.com with SMTP id c2so982924nfe for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 13:03:30 -0800 (PST)
Received: by 10.49.27.17 with SMTP id e17mr3224744nfj.1162415009677; Wed, 01
 Nov 2006 13:03:29 -0800 (PST)
Received: by 10.49.11.16 with HTTP; Wed, 1 Nov 2006 13:03:28 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

If I commit a new binary file to a repository and then use
git-format-patch --binary to produce a patch the resulting patch file
is not compatible with the patch command.

Am I doing something wrong or is this not possible.

Thanks
