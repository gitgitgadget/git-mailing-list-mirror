From: Stuart Rackham <srackham@methods.co.nz>
Subject: Re: asciidoc 7--8 compatibility
Date: Thu, 05 Oct 2006 12:40:33 +1300
Message-ID: <45244671.4030509@methods.co.nz>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net> <4522E66B.4080103@methods.co.nz> <4523E401.5080709@s5r6.in-berlin.de> <4524226D.5000305@methods.co.nz> <4524343B.8060709@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 01:40:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVGM5-0002M9-M3
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 01:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWJDXkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 19:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWJDXkp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 19:40:45 -0400
Received: from fep04.xtra.co.nz ([210.54.141.242]:64932 "EHLO fep04.xtra.co.nz")
	by vger.kernel.org with ESMTP id S1751234AbWJDXkp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Oct 2006 19:40:45 -0400
Received: from falcon.methods.co.nz ([219.89.35.210]) by fep04.xtra.co.nz
          with ESMTP
          id <20061004234038.QUZM2556.fep04.xtra.co.nz@falcon.methods.co.nz>;
          Thu, 5 Oct 2006 12:40:38 +1300
Received: from [192.168.1.6] (quark.methods.co.nz [192.168.1.6])
	by falcon.methods.co.nz (Postfix) with ESMTP id 5A901278715;
	Thu,  5 Oct 2006 12:40:38 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <4524343B.8060709@s5r6.in-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28333>

Stefan Richter wrote:
> Stuart Rackham wrote:
>> --- asciidoc.conf	(revision 53)
>> +++ asciidoc.conf	(working copy)
>> @@ -62,9 +62,9 @@
>>  __=#emphasis
>>  ++=#monospaced
>>  \##=#unquoted
>> -endif::asciidoc7compatible[]
>>  ^=#superscript
>>  ~=#subscript
>> +endif::asciidoc7compatible[]
> 
> Could git/Documentation/asciidoc.conf just kill all the various meanings
> of +, ~, ^ and make them into regular characters? In a way that works
> with all versions of asciidoc?

[quotes]
^=
~=
+=

 From the AsciiDoc User Guide: "A configuration file [quotes] entry can 
be subsequently undefined by setting it to a blank value."


> 
> (Frankly, using + as a special character may sound like a neat idea if
> all one wants to do is to typeset poems.)

The rationale for the + is discussed in the AsciiDoc changelog 
(http://www.methods.co.nz/asciidoc/CHANGELOG.html). It also brings 
AsciiDoc in line with the Ruby RDoc source code documentation system syntax.


--
Stuart Rackham
