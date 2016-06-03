From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Fri, 3 Jun 2016 07:07:18 +0200
Message-ID: <57511086.40206@web.de>
References: <xmqqa8j3ryo6.fsf@gitster.mtv.corp.google.com>
 <20160602231315.GA22864@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 07:08:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8hL0-00043D-AI
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 07:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbcFCFHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 01:07:49 -0400
Received: from mout.web.de ([212.227.17.12]:62975 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcFCFHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 01:07:49 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0ML8Kj-1b8QLQ3CG9-000IBE; Fri, 03 Jun 2016 07:07:21
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160602231315.GA22864@glandium.org>
X-Provags-ID: V03:K0:mpVmC69uLkwI/vRKQOzucRdQvVB33pTU0YJCw97VfOw8OMdxPEk
 dWd2ltm5Ygj1pwjcL7FP5EmD/ieWsa/PsHnamWnyaBsQYsUaBQpBZUHAL558lvVQMUszfE0
 7XWb0gE1bsk6l5v0yei0sRtsFLJK6224wOTeYhS5egWjoH2dXkSe8U6V1JbEXQ8VAeMGeQe
 XQeYUDEt+GDw2FjEZkEcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9vZxLirnN+A=:Hs+FraptPxWH4/CyAhMHru
 E1AwFmicJd01uMaF9R53Rnhf/5rJi3Czyucs3mhl6ZOgI3cfaR1EcQL1d7LtlUc/Dl3PuOOtI
 Sf+GXg2GXOCMaAlbJSJ49uqFKGp/EMPtR1j5lmXq+nRVt2R/oCZ6sRtIKIpEJSLtw2EYNXvEL
 +2q0nEV3WhDUCvNlKfm0cuZCF+VNUPdWZYPsT3Nli1NSMq6sAAjzNErSQCSZGpDhbeJjaUzTn
 pF7F0HOt4F7wbagTc02QaX1xeuuQYmnL7KQ2KeWkQsbFt2RfLRL0VIbtUG/BhovScd24Nmojx
 u1QjK+vbQcO73RC8K29sJ5xjZj7svt6lusBPtTRYg7cPUwH+VrrvWey42M30Cx0NzqARBG9rH
 Kb2LV2IegU20t739M9rzJD/1Z9Ja5GoJjwg6Gd40EUynFnnARqvavaDJ0VzBRTXaXD13w90th
 tPNMZ1QxRooms1BkYVg7bFFIMj/sTqXCcCyHeSdd9CVWgPUZVSaX+d0cA5HTsNX4DTAUMYCnV
 ekQsKhmpn9ioCXmuDh8A4Xr8A0T8KmgAtYDhWs38MMwARR8fU2h+QSi4t85VyHSUe8tH02In2
 zWDAUC8vBh4uhmvROzLR2fTC3jpu3eJILF2m99uhE2ZK03CYk863WvX3to7bGcH2RuVAj1ECz
 J6D2d7YgRXGV0g6or/uLNVv0UOvD2icMVir7JPZvM2YlVK9N2cXTwksglADvj/QkJBeLyRulK
 zxN8F+DSDijuDdzpw9zvBIaNp4t5VobBi2YNqLX7bscrnP0UccD/olg8dYSGemmc03u7K0Up 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296265>

On 06/03/2016 01:13 AM, Mike Hommey wrote:
> On Thu, Jun 02, 2016 at 03:52:41PM -0700, Junio C Hamano wrote:
>> * mh/connect (2016-06-01) 9 commits
>>   - connect: move ssh command line preparation to a separate function
>>   - connect: actively reject git:// urls with a user part
>>   - connect: change the --diag-url output to separate user and host
>>   - connect: make parse_connect_url() return the user part of the url as a separate value
>>   - connect: group CONNECT_DIAG_URL handling code
>>   - connect: make parse_connect_url() return separated host and port
>>   - connect: re-derive a host:port string from the separate host and port variables
>>   - connect: call get_host_and_port() earlier
>>   - connect: document why we sometimes call get_port after get_host_and_port
>>
>>   Needs review.
> I /think/ Torsten reviewed it all, and his last comments are in
> $gmane/295800. It's still not clear to me why he wants to remove the
> comment about [].
There where 2 comments in the review.
The most important thing is that now
git://[example.com:123]/path/to/repo is valid, but it shouldn't.
This patch fixes it:

@@ -673,7 +669,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_user,
          * "host:port" and NULL.
          * To support this undocumented legacy we still need to split the port.
          */
-       if (!port)
+       if (!port && protocol == PROTO_SSH)


The other thing is that I asked for a test case for
git://[example.com:123]/path/to/repo
which shouldn't be hard to do.

If nobody else things that this comment in the code is stale:
-       /*
-        * Don't do destructive transforms as protocol code does
-        * '[]' unwrapping in get_host_and_port()
-        */

then just leave it as it is.
Thanks
