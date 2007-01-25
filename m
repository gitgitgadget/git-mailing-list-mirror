From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Thu, 25 Jan 2007 08:12:52 -0800
Message-ID: <45B8D704.9040905@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>    <45B7818F.6020805@zytor.com> <200701242140.07459.jnareb@gmail.com> <2197.69.104.58.50.1169671494.squirrel@www.zytor.com> <Pine.LNX.4.63.0701250900380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 17:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA7Dp-0003wE-Sh
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbXAYQNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbXAYQNF
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:13:05 -0500
Received: from terminus.zytor.com ([192.83.249.54]:56545 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030264AbXAYQNE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:13:04 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0PGCqJw008235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jan 2007 08:12:54 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <Pine.LNX.4.63.0701250900380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.88.7/2489/Thu Jan 25 04:35:24 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37734>

Johannes Schindelin wrote:
>>
>> Either way, I think git-update-server-info should generate all these files.
> 
> Well, no. At least not per default. What you want is _very_ special to 
> gitweb. It is _only_ needed by gitweb. And .git/info/refs is for _dumb 
> transports_, _not_ for gitweb.
> 
> That said, I think it makes sense _in your setup_ to trigger updating 
> _another_ file for use in gitweb.
> 
> Remember, this is all very, very special for gitweb. So let's separate it 
> cleanly from all which is not special for gitweb.
> 
> I hope I have made it clear why (at least IMHO) it would be wrong, wrong, 
> wrong to change the format of .git/info/refs _only_ for gitweb, which it 
> is not meant for to begin with.

No, you keep using circular reasoning.

	-hpa
