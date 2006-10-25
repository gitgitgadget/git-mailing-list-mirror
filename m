X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [git failure] failure pulling latest Linus tree
Date: Wed, 25 Oct 2006 10:36:54 -0700
Message-ID: <453FA0B6.4040403@zytor.com>
References: <yq0d58g92u0.fsf@jaguar.mkp.net>	<Pine.LNX.4.64.0610250746000.3962@g5.osdl.org>	<453F8630.2000608@zytor.com> <7v3b9ce1tk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 17:37:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <7v3b9ce1tk.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.5/2098/Wed Oct 25 06:14:20 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30083>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcmgi-0004VQ-VX for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1160995AbWJYRhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161215AbWJYRhJ
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:37:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25815 "EHLO
 terminus.zytor.com") by vger.kernel.org with ESMTP id S1160995AbWJYRhG (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:37:06 -0400
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.7/8.13.7) with ESMTP id
 k9PHavLH017823 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 25 Oct 2006 10:36:57 -0700
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> For some reason which we haven't been able to track down yet, the
>> recent load imposed by FC6 caused zeus1's load to skyrocket, but not
>> zeus2's... it's largely a mystery.
> 
> Would kernel.org prefer RPM cut on a FC6 box now?
> 

No; since we have now (finally) archieved "OS parity" we're going to 
keep hera, zeus1, and zeus2 in sync going forward.

>> HOWEVER, git 1.4.3 seems to have been bad chicken.  When we ran it we
>> got a neverending stream of segfaults in the logs.
> 
> If that is git-daemon dying when talking to older clients, that
> has been fixed in 1.4.3.2 (it's virtual hosting support had an
> off-by-one wrong check to tell older clients from newer one).
> 
> Sorry about that -- we heard about the incompatibility this
> Monday.

This stuff happens... it's dealt with now.

	-hpa
