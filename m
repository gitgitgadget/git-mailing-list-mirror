From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide pathspecs
 by ':'
Date: Thu, 03 Mar 2011 09:21:34 +0100
Message-ID: <4D6F4F8E.6090905@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com> <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTim2HmBEQv=buRG7-87+c99FnsxXUTQzKy__azfM@mail.gmail.com> <4D6F1035.1040902@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 09:25:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv3qc-00034y-91
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 09:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab1CCIZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 03:25:04 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41225 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753591Ab1CCIZB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 03:25:01 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0ED5620906;
	Thu,  3 Mar 2011 03:25:01 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 03 Mar 2011 03:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=+FNjBtZf59kxozZ5LZlNUxQpA04=; b=qJwOf41N3kVOpAf5py/mnOGjZk3n150WDSGQW1boY+8MVPy07KzlfdKV1XdhofqQuuxtCQjDEj85S1JgRKEn+Rzd8sfKSGwOvEkTX5012e0cjaYjmoFUtWuobZFUb0Sihz4p2VvhP49FIGHeLtWpzevI/lAOZlHmmk7dJ967dOA=
X-Sasl-enc: aAI+2hko3U1LDldS+z/SoptfGDCA5Kq/svf93v+IZchL 1299140700
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 168C1408125;
	Thu,  3 Mar 2011 03:24:59 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110301 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.8
In-Reply-To: <4D6F1035.1040902@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168381>

Phil Hord venit, vidit, dixit 03.03.2011 04:51:
> On 03/01/2011 07:12 PM, Nguyen Thai Ngoc Duy wrote:
>> On Tue, Mar 1, 2011 at 6:16 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Nguyen Thai Ngoc Duy venit, vidit, dixit 01.03.2011 12:13:
>>>> If you are going to turn pathspecs into something more complex,
>>>> reserve room for future extension. I have negative pathspecs that can
>>>> utilize it.
>>>>
>>>> I take it, from now on people must refer file name ':foo' as './:foo'
>>>> with your patch?
>>> That is up for discussion, of course. When discussing a new approach for
>>> file mode dependent attributes, I was hoping to get through with
>>> symlink:path, and did not. But it was decided that something like
>>> :symlink:path would be good enough, in the sense of avoiding enough
>>> possible conflicts. That made me hope that :path would be, too.
>> Good morning! I'm saner now. How about :/path? That would reserve
>> anything next to ':' except '/'.
> 
> I like this.  The only 'failure' that comes to mind is something like
> 
>      git log -- */*.c
> 
> when there's a subdirectory named ':'. 

msysgit anyone?

Michael
