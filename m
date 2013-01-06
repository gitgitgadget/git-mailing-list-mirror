From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 08:23:33 +0100
Message-ID: <50E92675.4010907@web.de>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird> <BB541ECCD3F04E479F06CA491DDB598D@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jan 06 08:23:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrkaJ-0005Zf-VX
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 08:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3AFHXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 02:23:36 -0500
Received: from mout.web.de ([212.227.15.3]:64421 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974Ab3AFHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 02:23:35 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M4Hqd-1T1QyU2uzj-00riRV; Sun, 06 Jan 2013 08:23:33
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <BB541ECCD3F04E479F06CA491DDB598D@black>
X-Provags-ID: V02:K0:mAlu1El24m+ESn9Mi3n+MS0OO8FSCDOJYSp9Hua+pb9
 EMZq4LWm5MR1wrO1esEZlRG3TFPiIuCJPEXTLmJBj8s0Buv8N8
 5wis/Qja9ZBbrRUcoT4MFJx2udY9es13peHQ6tQuM/WgufoMpm
 pqicbDi2niMP7H6I4pw/8jmCwBXuFnmQn/o58UMidMDqPEBYg3
 rFX3pPo8SqUs6tcMzHWlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212783>

On 06.01.13 07:29, Jason Pyeron wrote:
>> -----Original Message-----
>> From: Stephen & Linda Smith 
>> Sent: Sunday, January 06, 2013 1:21
>>
>>> Was it the commit before
>>> 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiles or was it 
>>> 9fca6cffc05321445b59c91e8f8d308f41588b53 that compiled? I 
>> am doing a 
>>> cygwin update presently to look at it.
>>
>> Since the email earlier today, I had blown away the 
>> directory.   I just now 
>> did the following
>>
>> git clone https://github.com/git/git.git git-src && cd 
>> git-src && make all
>> ...   The make errored out as before
>>
> 
> No error for me.
> 
>> git co 9fca6c && make all
>> ...   The make errored out as before
> 
> No error for me.
> 
>>
>> git co 9fca6c^  && make all
>> ... and this compiles to completion
>>
>> CYGWIN_NT-5.1 WINXPMACHINE 1.7.14(0.260/5/3) 2012-04-24 17:22 
>> i686 Cygwin
> 
> This is old, do you have the luxury of updating it?
> 
>>
>> What else can I do to test this out (I will get a current 
>> cygwin tomorrow to use in a test).
> 
> I would also check to see if your devel packages are up to date too.

You can either upgrade to cygwin 1.17 or higher.
Or, if that is really not possible (because you are sitting on a production machine,
where no changes are allowed),

You can enable this in Makefile: 
CYGWIN_V15_WIN32API = YesPlease

HTH
/Torsten
