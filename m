From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: html page display via cgit
Date: Thu, 02 Sep 2010 09:09:14 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C7F4D9A.1050103@atlas-elektronik.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>	<4C7E29A1.8020304@atlas-elektronik.com> <AANLkTimucGi-7QdxbP5iLs0h5=VWW55GCxug51V584UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shivdas Gujare <shivdas.tech@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 09:09:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or3v8-0003vI-Es
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 09:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab0IBHJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 03:09:08 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:48035 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab0IBHJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 03:09:07 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 80FF4138A9
	for <git@vger.kernel.org>; Thu,  2 Sep 2010 09:09:04 +0200 (CEST)
X-AuditID: 0ac86512-00001794000005d0-16-4c7f4d8f7a9d
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 2 Sep 2010 09:09:03 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id C195B2717A;
	Thu,  2 Sep 2010 09:09:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id A71192716A;
	Thu,  2 Sep 2010 09:09:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTimucGi-7QdxbP5iLs0h5=VWW55GCxug51V584UA@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155107>

On 9/1/2010 2:19 PM, Shivdas Gujare wrote:
> Hi Stefan & All,
> 
> Thanks for your replies.
> 
> On Wed, Sep 1, 2010 at 3:53 PM, Stefan Naewe
> <stefan.naewe@atlas-elektronik.com> wrote:
>> On 9/1/2010 11:32 AM, Shivdas Gujare wrote:
>>> Hi All,
>>>
>>> I hope, this is the right mailing list for cgit as well.
>>> I am trying to add some "html logs" inside cgit, but I can't open
>>> these logs via cgit inside firefox, i.e. cgit open every files in
>>> "plain" format,
>>> would like to know if it is possible to open "html" pages inside cgit
>>> so that if I click on html page added into git, it opens in html and
>>> not in plain format.
>>
>> Set this in /etc/cgitrc
>>
>> mimetype.gif=image/gif
>> mimetype.html=text/html
>> mimetype.jpg=image/jpeg
>> mimetype.jpeg=image/jpeg
>> mimetype.pdf=application/pdf
>> mimetype.png=image/png
>> mimetype.svg=image/svg+xml
>>
> 
> I did tried this, but it didn't made any difference on showing html
> pages. 

I use cgit v0.8.3.3-82-gaec9 and it works for me. You still have to use the
'plain' link in the blob view, i.e. the URL looks like

http://host/cgit/repo/plain/file.html?h=branch


> Does this work like adding a line "
> mimetype.pdf=application/pdf" to /etc/cgitrc allows me
> to open a pdf via cgit interface in browser?

Works for me, too!


Stefan
-- 
----------------------------------------------------------------
/dev/random says: Nobody's ugly after 2 a.m.
