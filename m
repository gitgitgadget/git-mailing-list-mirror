From: El Draper <el@eldiablo.co.uk>
Subject: Re: First web interface and service API draft
Date: Fri, 22 Apr 2005 13:37:59 +0100
Message-ID: <4268F027.6030304@eldiablo.co.uk>
References: <1114166517.3233.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 14:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOxLz-0005Uu-8z
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 14:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVDVMiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 08:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVDVMiU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 08:38:20 -0400
Received: from p15160959.pureserver.info ([217.160.222.187]:55264 "EHLO
	mail.bytemehosting.net") by vger.kernel.org with ESMTP
	id S261311AbVDVMiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 08:38:15 -0400
Received: (qmail 11098 invoked from network); 22 Apr 2005 12:38:14 -0000
Received: from el@eldiablo.co.uk by jenna.bytemehosting.net by uid 2020 with qmail-scanner-1.22-st-qms 
 (clamscan: 0.80.533. spamassassin: 3.02.   Clear:RC:0(81.174.169.60):SA:0(0.0/7.0):. 
 Processed in 15.330265 secs); 22 Apr 2005 12:38:14 -0000
X-Spam-Status: No, hits=0.0 required=7.0
X-Antivirus-BYTEMEHOSTING.NET-Mail-From: el@eldiablo.co.uk via jenna.bytemehosting.net
X-Antivirus-BYTEMEHOSTING.NET: 1.22-st-qms (Clear:RC:0(81.174.169.60):SA:0(0.0/7.0):. Processed in 15.330265 secs Process 11089)
Received: from drapers.force9.co.uk (HELO [192.168.0.233]) (edraper@[81.174.169.60])
          (envelope-sender <el@eldiablo.co.uk>)
          by jenna.bytemehosting.net (qmail-ldap-1.03) with SMTP
          for <chris@absolutegiganten.org>; 22 Apr 2005 12:37:58 -0000
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Christian Meder <chris@absolutegiganten.org>
In-Reply-To: <1114166517.3233.4.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Christian Meder wrote:

>Comments ? Ideas ? Other feedback ?
>
>  
>

Hi guys,

New around these parts, so be gentle :-)

I would like to suggest the idea of a SOAP interface. If we are talking 
about a true service orientated API, then a way of calling a uri and 
having it return a nice SOAP packet with the return data in it would be 
great. If we ensured compliance with web service standards, then it 
would then mean anyone could write themselves a client desktop based 
program, a web interface, or any utility command line tools (in Java, 
.net, whatever they want, and for whatever platform), that could 
communicate with the web service and retrieve relevant data. You'd then 
have a true service interface into a Git repository. Seeing as how the 
idea of returning XML has already come up, I don't think it would be a 
stretch to extend the web interface to returning web service compliant 
SOAP packets in order to return data.

Regards,
-= El =-
