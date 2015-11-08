From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Bug: t5813 failing on Cygwin
Date: Sun, 8 Nov 2015 08:11:53 +0100
Message-ID: <563EF5B9.9020002@web.de>
References: <563DEA71.1080808@dinwoodie.org>
 <20151107184527.GA4483@sigill.intra.peff.net>
 <20151107192029.GW14466@dinwoodie.org>
 <1446930165.16957.9.camel@kaarsemaker.net>
 <563E6B47.5000807@ramsayjones.plus.com>
 <563E83C2.5050300@ramsayjones.plus.com>
 <1446939168.16957.11.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 08 08:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvK9E-00020s-4J
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 08:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbbKHHMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 02:12:16 -0500
Received: from mout.web.de ([212.227.15.4]:49542 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916AbbKHHMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 02:12:15 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MP2Sl-1ZpWqR2sLv-006Qhs; Sun, 08 Nov 2015 08:11:56
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <1446939168.16957.11.camel@kaarsemaker.net>
X-Provags-ID: V03:K0:ZILxAT0JHlVzhfSt2IqVUcsO/rkr98r51O8QXUzoteF/aeVf6Aj
 zLV09ZoSKeGB4MyOtVMMett6EyB0+nf9EEYFoQySSOTfsd0Lq0s1vTnUTeUR0Kvm/bVwb39
 NJA0zC5kUcWIDpR21XrqrTXHm2GuxQzH7EZQg4D+F+c+ZEJSuYDmMfafROH6d9RMMSZdiMZ
 uVNj+bv59VLCYANf5EW5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9k7SUSC36ZI=:FS3SN9U2zd7xtDO10kB3rS
 PwJKcryjZ70i9SGXu6aMnhJeRqbKkmmVZBk5dsQqj+wM/aAaGgE6bQxhem4d2S62u+wqwwvqs
 4Mf534/pbomoHh4rpZIg4+cWWPfFXd/dTA8GKa570vICjwaqf/81ETWkDl/1iaYQnyACb1eQH
 MMe1GJlVnSKciUTp9kyuLhfb3G2odDvryBKIK/Wti+dR334/fPAutOLiBWcKUyzk74066Tc0c
 6FtB06/ze+cSPjEujyFLg6ikOrmLt6ifryJcBXlukhdCeBktbcDnUm5ho7WEub4+dS+wqZPRo
 3oJPTwEV/5Znt71tL6EhocRv8R7iJ/K7Gm6pfUxDZ0OTPqiU19n4BnUigiKbSgo/RoPXKPj3g
 ANPXCzsaAnYe/do03TTYkob6W+zx68r8igomZAnsQKFUbGT+1fJLjZQxCbY948gl7kCWAhS8W
 i+h9GMrvqhQkttFkE4uCBBADqJISOF8BiGL0dQGYp8kFNCwzaAAZG8f3Nu0LE866ySzqBc/u9
 A9sWcoJBFJDHO6LBERnQf9qN+dNpgF8OCvs6qXWrnYZ9RTkH0sDba5NSg1uqotlijkRlnRTsf
 CY1TPJ0OT0exCZ2yud1LZAhOfWCZHuj+/VBapmOcbIG6ZYIsjLLIwWjGRZ0aII5ZisrE1PGKZ
 4nYzg41nUG8GHHkqixeeOClROlPXUaI/YoJvL6kpQtL+iVmSO2Hw/b3Zs5momPzvH4E8OYaKI
 kkAWknzIE6bKbg9ylfWZozYqOWWsXRndtGeFoueg2tmPjetCIeGeUxeuCWtGYmGMRoxjROVL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281034>

>>
>> diff --git a/connect.c b/connect.c
>> index 108f5ab..fc73cf9 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -636,6 +636,8 @@ static enum protocol parse_connect_url(const char
>> *url_orig, char **ret_host,
>>  	end = path; /* Need to \0 terminate host here */
>>  	if (separator == ':')
>>  		path++; /* path starts after ':' */
>> +	if (starts_with(path, "//"))
>> +		path++;
>>  	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
>>  		if (path[1] == '~')
>>  			path++;
>>
>> It seems to work, but I haven't thought about it too deeply ...
>> so I don't know if there are any problems lurking. :)
>>
>> I have to go now, so if somebody wants to take this up ...
> 
> Won't that break file:////server/share urls on cygwin?
> 
The official way to specify UNC names looks like this:
file://<host>/<path>
(Or file://server/share/morepath to follow your example)
#http://www.faqs.org/rfcs/rfc1738.html

But unfortunately Git doesn't support it.
I can put it on the to-do list...

But using "file:////" this is not an official syntax,
and should (in theory) not be used by any user.
Does anybody use it?

Or do people use simply "git clone //server/share/" ?
 
