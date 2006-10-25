X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Bugreport: core-tutorial example outdated?
Date: Wed, 25 Oct 2006 21:08:22 +0200
Message-ID: <453FB626.7020702@anagramm.de>
References: <453F9BA5.3020104@anagramm.de> <Pine.LNX.4.63.0610251923020.3286@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 19:08:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.63.0610251923020.3286@wbgn013.biozentrum.uni-wuerzburg.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:224ad0fd4f2efe95e6ec4f0a3ca8a73c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30093>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gco71-0003FL-34 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161371AbWJYTIX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 15:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWJYTIX
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 15:08:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:41715 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S1161371AbWJYTIW
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 15:08:22 -0400
Received: from [84.154.119.220] (helo=[192.168.1.10]) by
 mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis), id
 0ML21M-1Gco6u3iA3-0006wJ; Wed, 25 Oct 2006 21:08:21 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hello, Dscho!

>>I just studied
>>http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html
> 
> Did you actually add a file with the content "Hello World\n"? If not, you 
> should not be surprised.

Argh... yes, I even adopted my numbers to my case, but I just didn't
include the /55/... 2 letter folder name in the /55/7db03de997 object names... :-(

$ ls .git/objects/??/*
.git/objects/55/7db03de997c86a4a028e1ebd3a1ceb225be238
.git/objects/f2/4c74a2e500f5ee1332c86b94199f52b1d1d962
$ git-cat-file -t 7db03de997           <- wrong!
fatal: Not a valid object name 7db03de997
$ git-cat-file -t 557db03de            <- correct!
blob

Jup, those little details... once you don't stick to any tags.
Fine! Thanks! The tutorial, too!

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
