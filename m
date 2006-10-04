From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: pull-fetch-param.txt
Date: Wed, 04 Oct 2006 18:28:16 +0200
Message-ID: <4523E120.6050007@s5r6.in-berlin.de>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, srackham@methods.co.nz
X-From: git-owner@vger.kernel.org Wed Oct 04 18:31:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV9bx-0006MZ-H4
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 18:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030671AbWJDQ2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 12:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030681AbWJDQ2l
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 12:28:41 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:62618 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030671AbWJDQ2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 12:28:40 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k94GSGpg027614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Oct 2006 18:28:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64f1np8i.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28327>

Junio C Hamano wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> writes:
...
>> I.e. the first and second + were swallowed, but not the third one.
...
> Without looking at asciidoc 8.0 source, my guess is that it
> treats _anything_ that has two pluses on the same input line as
> quoted by some magical '+'-pair quote.   Can you try
> reformatting the original
> 
>> <refspec>::
>> 	The canonical format of a <refspec> parameter is
>> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
>> 	by the source ref, followed by a colon `:`, followed by
>> 	the destination ref.
> 
> to something like
> 
>> <refspec>::
>> 	The canonical format of a <refspec> parameter is
>> 	`+?<src>:<dst>`; that is, an optional plus
>> 	`+`, followed
>> 	by the source ref, followed by a colon `:`, followed by
>> 	the destination ref.
> 
> and verify that conjecture?

This hack does not help. The two `+` are still absent from the manpage
(but as before, the `+` in the next paragraph is printed as desired).
-- 
Stefan Richter
-=====-=-==- =-=- --=--
http://arcgraph.de/sr/
