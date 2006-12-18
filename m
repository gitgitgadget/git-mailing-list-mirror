X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Can't fetch 2.6.20-rc1 tag...
Date: Mon, 18 Dec 2006 12:56:09 +0100
Message-ID: <38b2ab8a0612180356t5c04f5bn29d7be3d0aa40764@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 11:56:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NFgO9p4P7mGIxkxrwV5LVvm/nMQ5ppW2ly7e/WX9htYDYAB0ZgTa+vtBaxOMfYbegpMglBteLHm4insJ71nxabu0Tz/6IdRi/Rty0vHVCJahKmn+FJvh4GtWCeMZx49Wx4lkQUJTuhO+e0OU8qADOidxfGuJqWxj9by4XMQ+NH0=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34739>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwH6S-0005za-CE for gcvg-git@gmane.org; Mon, 18 Dec
 2006 12:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753892AbWLRL4M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 06:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbWLRL4M
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 06:56:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:45073 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753892AbWLRL4K (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 06:56:10 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1360576wxd for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 03:56:10 -0800 (PST)
Received: by 10.90.105.19 with SMTP id d19mr1949734agc.1166442969868; Mon, 18
 Dec 2006 03:56:09 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Mon, 18 Dec 2006 03:56:09 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi

I've got this problem when issuing the following command in a kernel repo:

    $ git branch
    * master
    origin
    $ git pull -tags
    fatal: unexpected EOF
    Fetch failure:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

My git version is '1.4.4.2'

Can anybody tell me what I'm doing wrong ?

thanks
-- 
