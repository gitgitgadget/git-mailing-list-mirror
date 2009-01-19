From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: how to track multiple upstreams in one repository
Date: Mon, 19 Jan 2009 09:52:16 +0200
Message-ID: <8e04b5820901182352n29b3885cj850e6ddae6ca237f@mail.gmail.com>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
	 <20090119021426.GA21999@shion.is.fushizen.net>
	 <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12145_12639744.1232351536715"
Cc: "Bryan Donlan" <bdonlan@fushizen.net>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jan 19 08:53:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOox5-0004YW-Th
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 08:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbZASHwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 02:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZASHwT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 02:52:19 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:62173 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZASHwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 02:52:18 -0500
Received: by ey-out-2122.google.com with SMTP id 22so483349eye.37
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=a+5p6OoNXlr54r/COx+c8Gj6c4ElJneR6XGpR7w+cH0=;
        b=cxelpKPrWWWEHvgJNc5cHIRTtObmDw1Tzilkv3iNWeVeqqcd0/eVnE9vAZzYz9WcwX
         fWqCGpzuoXnc7UCBmtusiexhfDkbR8Y+kdXS26Vn5OpKlVABwt1aCxYhgzYExZ+sJ0kG
         73pbyGTVrt0Y3cRnm6sb6NWPZnZnqCeRSn5Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=WJtd09JQINLCYPHyilwU1rijA70nSu0hPq4Y1h6xdjUJDHHBHknN8q+klIw2dLMGvb
         eaBjqguf1Gr2L+e5p9oNPVhVjSBj5iQ0nC6A3mj/RyFTaG5KkyCyUpcfSeG+/V36RK3U
         7ilcYSdLAhSycpBy4jWthqxlFiO94oYjjRMVk=
Received: by 10.210.90.10 with SMTP id n10mr6732039ebb.135.1232351536725;
        Sun, 18 Jan 2009 23:52:16 -0800 (PST)
Received: by 10.210.129.8 with HTTP; Sun, 18 Jan 2009 23:52:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106331>

------=_Part_12145_12639744.1232351536715
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Jan 19, 2009 at 5:58 AM,  <david@lang.hm> wrote:
> On Sun, 18 Jan 2009, Bryan Donlan wrote:
>
>> On Sun, Jan 18, 2009 at 06:58:06PM -0800, david@lang.hm wrote:
>>>
>>> for linux I want to track both the linus tree and the -stable tree.
>>> Ideally I want to be able to do a checkout of tags from either tree from
>>> the same directory (along with diffs between items in both trees, etc)
>>>
>>> I have found documentation on how to clone from each of them, but I
>>> haven't found any simple documentation on how to work with both of them.
>>
>> After cloning from one:
>> git remote add remotename git://...
>> git fetch remotename
>>
>> You will now have the other repository fetched into your local
>> repository; tags from both will be replicated to your local tags.
>
> thanks, given the nature of git I figured it was something really simple,
> but I just wasn't able to find it.
>
> I've forwarded this to the kernel.org webmaster to update the 'how to follow
> linux development' page
>
> David Lang

    I use something even simpler, please see the attached .git/config
file that I use. It also uses remote branches, and rewrites the refs
to something like: stable/v2.6.25/master or torvalds/v2.6/master. Also
in order to fetch them I use git fetch stable/v2.6.25

    Ciprian Craciun.

------=_Part_12145_12639744.1232351536715
Content-Type: application/octet-stream; name=config
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fq4u804u0
Content-Disposition: attachment; filename=config

W2NvcmVdCglyZXBvc2l0b3J5Zm9ybWF0dmVyc2lvbiA9IDAKCWZpbGVtb2RlID0gdHJ1ZQoJYmFy
ZSA9IGZhbHNlCglsb2dhbGxyZWZ1cGRhdGVzID0gdHJ1ZQoKW3VzZXJdCgluYW1lID0gQ2lwcmlh
biBEb3JpbiBDcmFjaXVuCgllbWFpbCA9IGNpcHJpYW4uY3JhY2l1bkBnbWFpbC5jb20KClt1cmwg
ImdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy8i
XQoJaW5zdGVhZE9mID0gdG9ydmFsZHM6CgpbdXJsICJnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlLyJdCglpbnN0ZWFkT2YgPSBzdGFibGU6CgpbcmVt
b3RlICJ0b3J2YWxkcy92Mi42Il0KCXVybCA9IHRvcnZhbGRzOmxpbnV4LTIuNi5naXQKCWZldGNo
ID0gcmVmcy9oZWFkcy9tYXN0ZXI6cmVmcy9oZWFkcy90b3J2YWxkcy92Mi42L21hc3RlcgoKW3Jl
bW90ZSAic3RhYmxlL3YyLjYuMTciXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4xNy55LmdpdAoJ
ZmV0Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjE3L21hc3Rl
cgoKW3JlbW90ZSAic3RhYmxlL3YyLjYuMTgiXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4xOC55
LmdpdAoJZmV0Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjE4
L21hc3RlcgoKW3JlbW90ZSAic3RhYmxlL3YyLjYuMTkiXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIu
Ni4xOS55LmdpdAoJZmV0Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92
Mi42LjE5L21hc3RlcgoKW3JlbW90ZSAic3RhYmxlL3YyLjYuMjAiXQoJdXJsID0gc3RhYmxlOmxp
bnV4LTIuNi4yMC55LmdpdAoJZmV0Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0
YWJsZS92Mi42LjIwL21hc3RlcgoKW3JlbW90ZSAic3RhYmxlL3YyLjYuMjEiXQoJdXJsID0gc3Rh
YmxlOmxpbnV4LTIuNi4yMS55LmdpdAoJZmV0Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hl
YWRzL3N0YWJsZS92Mi42LjIxL21hc3RlcgoKW3JlbW90ZSAic3RhYmxlL3YyLjYuMjIiXQoJdXJs
ID0gc3RhYmxlOmxpbnV4LTIuNi4yMi55LmdpdAoJZmV0Y2ggPSByZWZzL2hlYWRzL21hc3Rlcjpy
ZWZzL2hlYWRzL3N0YWJsZS92Mi42LjIyL21hc3RlcgoKW3JlbW90ZSAic3RhYmxlL3YyLjYuMjMi
XQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4yMy55LmdpdAoJZmV0Y2ggPSByZWZzL2hlYWRzL21h
c3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjIzL21hc3RlcgoKW3JlbW90ZSAic3RhYmxlL3Yy
LjYuMjQiXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4yNC55LmdpdAoJZmV0Y2ggPSByZWZzL2hl
YWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjI0L21hc3RlcgoKW3JlbW90ZSAic3Rh
YmxlL3YyLjYuMjUiXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4yNS55LmdpdAoJZmV0Y2ggPSBy
ZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjI1L21hc3RlcgoKW3JlbW90
ZSAic3RhYmxlL3YyLjYuMjYiXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4yNi55LmdpdAoJZmV0
Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjI2L21hc3RlcgoK
W3JlbW90ZSAic3RhYmxlL3YyLjYuMjciXQoJdXJsID0gc3RhYmxlOmxpbnV4LTIuNi4yNy55Lmdp
dAoJZmV0Y2ggPSByZWZzL2hlYWRzL21hc3RlcjpyZWZzL2hlYWRzL3N0YWJsZS92Mi42LjI3L21h
c3Rlcgo=
------=_Part_12145_12639744.1232351536715--
