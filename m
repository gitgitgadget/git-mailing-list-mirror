X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Easy shell question: how to make a script killing all his childs when killed?
Date: Sat, 9 Dec 2006 16:16:32 +0100
Message-ID: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 15:16:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cXSqaS37DufKCSp9tHIH/tKm0TJrlSlv70FS/VpXVzNIpLfDa1yysn4Dy8WXjcX2+0ti8fMd4p2Qp/ULWdtze0GT19OxLiZKOLkB7R3JxS1H+srwK5T9vIjEkSZTrVp8XNix2ZSDTyyqRx1hF0AGoI+kO4GMKQ+ty3xOYkIcAVc=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33817>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt3wV-00014V-LQ for gcvg-git@gmane.org; Sat, 09 Dec
 2006 16:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936828AbWLIPQe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 10:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936861AbWLIPQe
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 10:16:34 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:44547 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936828AbWLIPQd (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 10:16:33 -0500
Received: by py-out-1112.google.com with SMTP id a29so592158pyi for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 07:16:33 -0800 (PST)
Received: by 10.35.57.5 with SMTP id j5mr8065501pyk.1165677392824; Sat, 09
 Dec 2006 07:16:32 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sat, 9 Dec 2006 07:16:32 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Ok. I am really bad at scripting, so perhaps my question is very silly, but...

I create and run a script with the content:

git rev-list --header --boundary --parents --topo-order 2229ff5c7c  >
/tmp/qgit_135902672.txt

Then I kill the script while it's running, but his child
(git-rev-list) continues to run in background and I would like to stop
it either.

So how can I write the script to be sure that when stopped, it will
kill all his childern?

Thanks
Marco

P.S: I have no way to exec the script in fancy ways, I can just start
