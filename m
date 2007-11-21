From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: t9106 failure, bisect weirdness
Date: Tue, 20 Nov 2007 20:56:38 -0800
Message-ID: <20071121045638.GA9184@net-ronin.org>
References: <20071119230601.GA15624@net-ronin.org>
 <200711200552.27001.chriscool@tuxfamily.org>
 <20071120061314.GA21819@net-ronin.org>
 <200711210508.27455.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 05:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuhey-00061r-Cg
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 05:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbXKUE5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 23:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbXKUE5E
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 23:57:04 -0500
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:42432 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbXKUE5D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 23:57:03 -0500
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRU008T4B2GAPB0@l-daemon> for git@vger.kernel.org; Tue,
 20 Nov 2007 21:56:40 -0700 (MST)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JRU00JBCB2GX850@pd3mr5so.prod.shaw.ca> for
 git@vger.kernel.org; Tue, 20 Nov 2007 21:56:40 -0700 (MST)
Received: from prophet.net-ronin.org ([70.67.106.153])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRU00CSYB2FPA50@l-daemon> for git@vger.kernel.org; Tue,
 20 Nov 2007 21:56:39 -0700 (MST)
Received: from ramune by prophet.net-ronin.org with local (Exim 4.50)
	id 1Iuhde-0002OM-99; Tue, 20 Nov 2007 20:56:38 -0800
In-reply-to: <200711210508.27455.chriscool@tuxfamily.org>
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65592>

> Ok thanks for doing that too.
> Could you also look at the "file" when the test succeed and when it does not 
> and send us both versions and a diff between them (if it's not too big).

Size-wise, they're tiny -- though there's a lot of lines.

The diff:

ramune/lycaeum:t: diff -u works.t fails.t 
--- works.t     2007-11-20 21:54:29.000000000 -0700
+++ fails.t     2007-11-20 21:54:39.000000000 -0700
@@ -55,9 +55,9 @@
 55
 56
 57
-5588
+58
 59
 60
-6611
+61
 62
 63

And the full (working) file:

1
2
3
4444
5
6
7777
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
5588
59
60
6611
62
63
