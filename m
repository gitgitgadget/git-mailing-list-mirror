Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A691FC96
	for <e@80x24.org>; Wed,  7 Dec 2016 01:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbcLGBYJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 20:24:09 -0500
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:45982 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751786AbcLGBYH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2016 20:24:07 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Dec 2016 20:24:07 EST
Received: from resomta-ch2-17v.sys.comcast.net ([69.252.207.113])
        by resqmta-ch2-04v.sys.comcast.net with SMTP
        id EQsvcqN5UGIgtEQsvc2NC8; Wed, 07 Dec 2016 01:19:01 +0000
Received: from cherryberry.dsgml.com ([IPv6:2601:547:501:184b:22cf:30ff:fe05:22e8])
        by resomta-ch2-17v.sys.comcast.net with SMTP
        id EQsucehbqTcMEEQsucVVn4; Wed, 07 Dec 2016 01:19:01 +0000
Received: from as (helo=localhost)
        by cherryberry.dsgml.com with local-esmtp (Exim 4.84_2)
        (envelope-from <asgit@dsgml.com>)
        id 1cEQst-0000ld-QK
        for git@vger.kernel.org; Tue, 06 Dec 2016 20:18:59 -0500
Date:   Tue, 6 Dec 2016 20:18:59 -0500 (EST)
From:   Ariel <asgit@dsgml.com>
X-X-Sender: as@cherryberry.dsgml.com
To:     git@vger.kernel.org
Subject: git add -p with new file
Message-ID: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-CMAE-Envelope: MS4wfCheXiYhgo+FbN/C1qMxfuece+5DlNZrPc5tW7EtSs9avBgGED241a+nsQSAi/lFZSp+h4BvYhVlMkKVAK02bD1wAGDYDaXqT1iHNm9iBBxCEvt108So
 u7NVgBsIKiYLRBtiBAKmu2mDgnt+jhjgAZyFxijNbTjnwWSuFg/hgXMh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


If you do git add -p new_file it says:

No changes.

Which is a rather confusing message. I would expect it to show me the 
content of the file in patch form, in the normal way that -p works, let me 
edit it, etc.

(Note: I am aware I can do -N first, but when I specifically enter the 
name of a new file I feel it should figure out what I mean.)

 	-Ariel
