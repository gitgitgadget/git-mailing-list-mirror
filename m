From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH 2/2] Use Integer.valueOf instead of new Integer
Date: Fri, 08 Feb 2008 00:52:45 -0200
Message-ID: <47ABC3FD.1000803@intelinet.com.br>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com> <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com> <20080206070631.GM24004@spearce.org> <200802062115.38212.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Dave Watson <dwatson@mimvista.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 03:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNJLf-0000pP-9A
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 03:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359AbYBHCvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 21:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757097AbYBHCvp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 21:51:45 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1394 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756849AbYBHCvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 21:51:44 -0500
Received: (qmail 33275 invoked by uid 0); 8 Feb 2008 00:54:55 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.229409 secs); 08 Feb 2008 02:54:55 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 8 Feb 2008 02:54:55 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200802062115.38212.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73028>


Robin Rosenberg escreveu:
> onsdagen den 6 februari 2008 skrev Shawn O. Pearce:
>   
>> Use Integer.valueOf(int).  Post Java 5 implementations of the J2SE
>> are required to cache values between -128 and 127 (inclusive).
>>
>> Actually, when the Java compiler autoboxes values it does so through
>> these static valueOf methods, which were mostly introduced as part
>> of the Java 5 API updates.  For small common values its cached and
>> will thus avoid garbage generation, for less common values it goes
>> back to allocating the object.
>>     
>
> Thank you for this information.
>
> -- robin
Yep, this is very good to know. Thanks from me too :)
This patches series looks fine to me.

[]s,
Roger.
