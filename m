From: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
Subject: Re: t9200 cvsexportcommit test fails on Ubuntu server 12.04.4 LTS
Date: Sat, 01 Mar 2014 11:09:57 +0100
Organization: Fabio D'Alfonso
Message-ID: <5311B1F5.7080501@fabiodalfonso.com>
References: <5310D933.1@fabiodalfonso.com> <20140301064642.GD20397@sigill.intra.peff.net>
Reply-To: fabio.dalfonso@fabiodalfonso.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 11:31:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJhCU-0001GF-At
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 11:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbaCAKbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 05:31:17 -0500
Received: from gateway01.websitewelcome.com ([67.18.80.19]:54163 "EHLO
	gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750869AbaCAKbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Mar 2014 05:31:16 -0500
X-Greylist: delayed 1276 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Mar 2014 05:31:16 EST
Received: by gateway01.websitewelcome.com (Postfix, from userid 5007)
	id 923B071BFA4E1; Sat,  1 Mar 2014 04:09:59 -0600 (CST)
Received: from gator4050.hostgator.com (gator4050.hostgator.com [192.185.4.61])
	by gateway01.websitewelcome.com (Postfix) with ESMTP id 858D571BFA4BD
	for <git@vger.kernel.org>; Sat,  1 Mar 2014 04:09:59 -0600 (CST)
Received: from [95.237.41.141] (port=12749 helo=[192.168.1.16])
	by gator4050.hostgator.com with esmtpa (Exim 4.80.1)
	(envelope-from <fabio.dalfonso@fabiodalfonso.com>)
	id 1WJgrn-0004GF-3p; Sat, 01 Mar 2014 04:09:59 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140301064642.GD20397@sigill.intra.peff.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4050.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fabiodalfonso.com
X-BWhitelist: no
X-Source-IP: 95.237.41.141
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.16]) [95.237.41.141]:12749
X-Source-Auth: fabio.dalfonso@fabiodalfonso.com
X-Email-Count: 1
X-Source-Cap: ZGFsZm9uc287ZGFsZm9uc287Z2F0b3I0MDUwLmhvc3RnYXRvci5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243056>

Hi,
thanks for the suggestion.

Tests failed because the cvs is built with denied root commit on 12.04,=
=20
I did not notice as the 11.04 works. I use root for system activities o=
n=20
servers. Will sometime in the future start to sudoku...

Made a check as git user and was fine.

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

On 3/1/2014 7:46 AM, Jeff King wrote:
> On Fri, Feb 28, 2014 at 07:45:07PM +0100, Fabio D'Alfonso wrote:
>
>> I get 12 of 15 tests faling.
>>
>> Any idea? the same build works fine on 11.04 where I have a desktop =
version.
> No clue. It works fine for me here (Debian sid). Perhaps try running =
the
> script like:
>
>      ./t9200-git-cvsexportcommit.sh -v -i
>
> which should give more information about what exactly is failing?
>
> -Peff
