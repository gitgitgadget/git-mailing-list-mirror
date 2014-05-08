From: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Thu, 08 May 2014 16:13:58 +0200
Organization: Fabio D'Alfonso
Message-ID: <536B9126.1020702@fabiodalfonso.com>
References: <536A8FF8.7080909@fabiodalfonso.com> <xmqqeh056z6q.fsf@gitster.dls.corp.google.com> <20140508041423.GC26630@sigill.intra.peff.net> <536B1DF4.5080109@fabiodalfonso.com>
Reply-To: fabio.dalfonso@fabiodalfonso.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 16:37:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiPRk-00078z-Dw
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 16:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbaEHOhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2014 10:37:09 -0400
Received: from gateway02.websitewelcome.com ([69.41.248.84]:39004 "EHLO
	gateway02.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754348AbaEHOhI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 May 2014 10:37:08 -0400
X-Greylist: delayed 1333 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2014 10:37:07 EDT
Received: by gateway02.websitewelcome.com (Postfix, from userid 5007)
	id 4FE9E6EA63B33; Thu,  8 May 2014 09:14:09 -0500 (CDT)
Received: from gator4050.hostgator.com (gator4050.hostgator.com [192.185.4.61])
	by gateway02.websitewelcome.com (Postfix) with ESMTP id 399136EA60E69
	for <git@vger.kernel.org>; Thu,  8 May 2014 09:14:07 -0500 (CDT)
Received: from [95.237.40.27] (port=7788 helo=[192.168.1.16])
	by gator4050.hostgator.com with esmtpa (Exim 4.82)
	(envelope-from <fabio.dalfonso@fabiodalfonso.com>)
	id 1WiP5G-000106-Uk; Thu, 08 May 2014 09:14:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <536B1DF4.5080109@fabiodalfonso.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4050.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fabiodalfonso.com
X-BWhitelist: no
X-Source-IP: 95.237.40.27
X-Exim-ID: 1WiP5G-000106-Uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.16]) [95.237.40.27]:7788
X-Source-Auth: fabio.dalfonso@fabiodalfonso.com
X-Email-Count: 1
X-Source-Cap: ZGFsZm9uc287ZGFsZm9uc287Z2F0b3I0MDUwLmhvc3RnYXRvci5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248420>

The message seems common around  the apache issues but the previous tes=
t=20
t5538 that uses start and stop routines works.

=46abio D'Alfonso
'Enabling Business Through IT'
cell.  +39.348.059.40.22 ***
web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
email: fabio.dalfonso@fabiodalfonso.com
<mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
www.linkedin.com/in/fabiodalfonso <http://it.linkedin.com/in/fabiodalfo=
nso>
twitter: www.twitter.com/#!/fabio_dalfonso=20
<http://www.twitter.com/#%21/fabio_dalfonso>

fax: +39.06.874.599.581
BlackBerry=C2=AE Wireless Enabled Address.


          ** Hidden  numbers are automatically rejected by the phone*

On 5/8/2014 8:02 AM, Fabio D'Alfonso wrote:
> Hi,
> this is the error in httpd error.log
>
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user=
=20
> name from  uid 4294967295, you probably need to modify the User direc=
tive
>  [Wed May 07 20:44:10 2014] [notice] Apache/2.2.17 (Ubuntu) configure=
d=20
> --        resuming normal operations
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user=
=20
> name from  uid 4294967295, you probably need to modify the User direc=
tive
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user=
=20
> name from  uid 4294967295, you probably need to modify the User direc=
tive
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user=
=20
> name from  uid 4294967295, you probably need to modify the User direc=
tive
>  [Wed May 07 20:44:10 2014] [alert] getpwuid: couldn't determine user=
=20
> name from  uid 4294967295, you probably need to modify the User direc=
tive
>  [Wed May 07 20:44:11 2014] [alert] Child 12037 returned a Fatal=20
> error...        Apache is exiting!
>
> The 1.9.x versions compiled and tested here, before. It is a natty=20
> dektop 11.04.
>
> Thanks
>
> Fabio D'Alfonso
> 'Enabling Business Through IT'
> cell.  +39.348.059.40.22 ***
> web: www.fabiodalfonso.com <http://www.fabiodalfonso.com/>
> email: fabio.dalfonso@fabiodalfonso.com
> <mailto:fabio.dalfonso@fabiodalfonso.com>linkedin:=20
> www.linkedin.com/in/fabiodalfonso=20
> <http://it.linkedin.com/in/fabiodalfonso>
> twitter: www.twitter.com/#!/fabio_dalfonso=20
> <http://www.twitter.com/#%21/fabio_dalfonso>
>
> fax: +39.06.874.599.581
> BlackBerry=C2=AE Wireless Enabled Address.
>
>
>          ** Hidden  numbers are automatically rejected by the phone*
>
> On 5/8/2014 6:14 AM, Jeff King wrote:
>> On Wed, May 07, 2014 at 02:45:01PM -0700, Junio C Hamano wrote:
>>
>>> Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com> writes:
>>>
>>>> root@HDUBVM01:~/builds/git/t# ./t5539-fetch-http-shallow.sh
>>>> ok 1 - setup shallow clone
>>>> not ok 2 - clone http repository
>>> [...]
>>> Does not reproduce for me but I am on Ubuntu 12.04.2 LTS, so...
>> Nor me on Debian unstable.
>>
>>> Running it with the -v option might give you more hints, and
>>> running it as
>>>
>>>      $ sh -x ./t5539-fe* -v
>>>
>>> might give you more to chew.
>> Yes, definitely that, but also, from:
>>
>>>> httpd (pid 10653?) not running
>>>> # failed 2 among 3 test(s)
>> ...it looks like the httpd server did not start. Look in httpd/error=
=2Elog
>> of "trash directory.t5539-fetch-http-shallow" to see the apache log.=
 It
>> may give some reason for failing to start.
>>
>> -Peff
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
