From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git log --no-walk --tags produces strange result for certain
 user
Date: Fri, 17 Jan 2014 09:28:02 +0100
Message-ID: <52D8E992.3010304@alum.mit.edu>
References: <5EE449B7-AB75-4EFF-85F9-292727FA1C53@jetbrains.com> <01D3F259-94E1-4084-9210-34E2DB7B7545@jetbrains.com> <52AEB181.9020006@alum.mit.edu> <AEF2BC21-6EE1-479F-BC63-7A5B95406A7F@jetbrains.com> <52D7B4F8.1010209@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 09:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W44tW-0004Bj-NI
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 09:35:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbaAQIfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 03:35:10 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52172 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064AbaAQIfI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 03:35:08 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jan 2014 03:35:08 EST
X-AuditID: 12074414-b7fb46d000002a4d-0f-52d8e994526e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.BF.10829.499E8D25; Fri, 17 Jan 2014 03:28:04 -0500 (EST)
Received: from [192.168.69.148] (p57A24457.dip0.t-ipconnect.de [87.162.68.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0H8S27p031248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 Jan 2014 03:28:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <52D7B4F8.1010209@alum.mit.edu>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqDvl5Y0gg/YGNYuuK91MFu/ub2Vx
	YPKYO+8Nq8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bl7t+5jLjjNWbGy+RhLA+Nn9i5GTg4JAROJ
	6wdvMkHYYhIX7q1n62Lk4hASuMwocXnyeiYI5xyTxKRrDaxdjBwcvALaEjfO24M0sAioSnQ8
	OgPWzCagK7GopxnMFhUIllh9+QELiM0rIChxcuYTMFtEwFzi8a+lYDazgL7Epz8HwOqFBQIk
	Oq7MZYTY9YpR4uz9Q2DXcQroSMy6u4AJZK+EgLhET2MQRK+OxLu+B8wQtrzE9rdzmCcwCs5C
	sm4WkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdK10MvNLNFLTSndxAgJYJEdjEdO
	yh1iFOBgVOLhlRC/ESTEmlhWXJl7iFGSg0lJlHfDTaAQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed6tIDnelMTKqtSifJiUNAeLkjjvt8XqfkIC6YklqdmpqQWpRTBZGQ4OJQnezhdAjYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgCI4vBsYwSIoHaO/b5yB7iwsSc4GiEK2nGHU5
	Vmz49IdRiCUvPy9VSpw3HWSHAEhRRmke3ApYunrFKA70sTBvC0gVDzDVwU0CRg3Q4yK8bo/A
	lpQkIqSkGhjNvW4ufzh1S2GtLJ98BmvMhNt/P57y0Wbe1+jJe6DGy2XG3A1LzpT/ZXJ59/LO
	LSdm0wYOVrFovWmHdi7R33v9pfjff1/M9L2XxNkFBjUU2+z5ZNEgGLvIkJnbnelb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240577>

On 01/16/2014 11:31 AM, Michael Haggerty wrote:
> On 12/16/2013 12:52 PM, Kirill Likhodedov wrote:
>> I received one more complaint for this issue, and now it appears in a public repository https://github.com/spray/spray 
>>
>> To reproduce:
>>
>> # git clone https://github.com/spray/spray 
>> # cd spray
>> # git log --no-walk --tags --pretty="%H %d" --decorate=full | tail -3
>> 3273edafcd9f9701d62e061c5257c0a09e2e1fb7  (tag: refs/tags/v0.8.0-RC1)
>> ff3a2946bc54da76ddb47e82c81419cc7ae3db6b  (tag: refs/tags/v0.7.0)
>> 8b4043428b90b7f45b7241b3c2c032cf785479ce 
>>
>> So here the last hash doesn't have a decoration.
> 
> The problem is that reference refs/tags/v0.5.0 points at a tag object
> 8f6ca98087 which itself points at another tag object 2eddbcbff4 which
> finally points at commit 8b4043428b.  Probably we should handle
> recursive tag objects like this, but OTOH I can't think of a reason why
> one would want to create them in the first place.

Junio just pointed out to me that this bug has been fixed already, by
Brian Carlson, in 5e1361cc, which is already in master.  Sorry for the
noise.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
