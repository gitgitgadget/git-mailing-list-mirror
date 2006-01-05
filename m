From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Thu, 05 Jan 2006 09:07:59 -0800
Message-ID: <43BD526F.2040300@zytor.com>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>	 <43BD4B73.7010000@zytor.com> <81b0412b0601050847h1dcd5e81sd5eef3f03df6d1de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 18:09:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYb5-0001Od-IQ
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 18:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWAERIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 12:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWAERIO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 12:08:14 -0500
Received: from terminus.zytor.com ([192.83.249.54]:32641 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751058AbWAERIO
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 12:08:14 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k05H7xDr010109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Jan 2006 09:08:00 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601050847h1dcd5e81sd5eef3f03df6d1de@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14207>

Alex Riesen wrote:
> On 1/5/06, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>>Not every system (will not one microsoft windows system) have /var/tmp,
>>>whereas using GIT_DIR for random temporary files is more or less established.
>>
>>Depends on what you're doing.  Only if you're writing to the repository.
>>
>>Windows will usually have $TMP and/or $TEMP, a lot of Unix apps honour
>>$TMP_DIR.
> 
> 
> Well, it never had TMP/TEMP by default for me (though I'd expect from people
> installing git to set the thing properly), and it is usually undefined
> everywhere else.

Well, for me it's set to

TEMP=C:\Documents and Settings\user\Local Settings\Temp

(except it's all in 8.3-mangled form)... and I sure as Hades didn't set 
it.  This in on XP SP2.  "Local Settings" is a hidden directory which 
seems to have stuff like the Internet Exploder cache in it.

	-hpa
