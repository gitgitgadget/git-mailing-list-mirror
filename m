X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Mozilla, git and Windows
Date: Mon, 27 Nov 2006 10:28:59 -0500
Message-ID: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 15:30:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uaIdv0XfVjtz5AXKw6YMqeywhYbQi8dbcTYVRrJbrjjYHH1fkVx3xM5HZ2dgblDoevWJ1gSsiVLzF3zVFAVKAH/1SmOfycxbsr9guykRvaC4pxmxioYnOuGHjhEGrL8BSb+hl0yw6VlyUS/uYHI2HerrztwVGLItIJeKRUId3aw=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32419>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoiQG-0006lb-SW for gcvg-git@gmane.org; Mon, 27 Nov
 2006 16:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758281AbWK0P3B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 10:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758279AbWK0P3B
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 10:29:01 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:5788 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1758274AbWK0P3A
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 10:29:00 -0500
Received: by py-out-1112.google.com with SMTP id a29so1125556pyi for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 07:28:59 -0800 (PST)
Received: by 10.35.21.9 with SMTP id y9mr13403321pyi.1164641339605; Mon, 27
 Nov 2006 07:28:59 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 27 Nov 2006 07:28:59 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

In the other thread we are discussing the conversion of Mozilla CVS to
git format. This is something that has to be done but it is not the
only issue. Without a native Windows port they won't even consider
using git. There is also the risk that the features needed by Mozilla
will be completed after they choose to use a different SCM.

Even if we implement all of the needed features git still needs to win
the competition against the other possible choices. The last I heard
the leading candiate is SVN/SVK.

-- 
Jon Smirl
