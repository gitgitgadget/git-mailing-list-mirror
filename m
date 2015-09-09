From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git's inconsistent command line options
Date: Wed, 9 Sep 2015 11:42:54 +0200
Message-ID: <55EFFF1E.1050409@drmicha.warpmail.net>
References: <mrh7ck$r0g$1@ger.gmane.org>
 <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
 <CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
 <20150831102558.1514e5f7@anarchist.wooz.org>
 <20150901092834.GA10706@gmail.com>
 <20150901101924.6c350012@anarchist.wooz.org>
 <xmqq37yyt7k8.fsf@gitster.mtv.corp.google.com>
 <20150901135018.70240193@limelight.wooz.org>
 <CAGZ79ka4+a_eyha=xCrQFBdLzgbT3ws1Jq7Q=WJw45Ob6bFFug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>
To: Stefan Beller <sbeller@google.com>,
	Barry Warsaw <barry@python.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 11:43:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZbu9-0000pw-SS
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 11:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbIIJm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 05:42:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48213 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbbIIJm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 05:42:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0D39120828
	for <git@vger.kernel.org>; Wed,  9 Sep 2015 05:42:57 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 09 Sep 2015 05:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=nqifKbiGALoCTDoyBvEpDauezyc=; b=i06A1C
	mbs786HweAPbJd9I1gIVyZmJ+XUXlN2VL2uiKLJGZzyss+Sy40Mec7NtaDm7Ej2Q
	peilPdqYT2NobjpSjIXYoPJm2H3DGzyDmlJxp2LTlYv74l9m/agjijEzKeoHzxGQ
	LKIJDHwVzfIkkZkbMMp8i1JauaC7luIvc2ElU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nqifKbiGALoCTDo
	yBvEpDauezyc=; b=c/qg54rSyWWi8TW9+s9O652k+W3ecKpk53pCnYdCCnrlOTT
	wcA/pMAc0+klmBRwwDBEDySzT96tByQSz/Bk0ePh8QU7j/nWlKp2gVQBEcc/ashb
	zLfcRZanCBLCH0V6VIlY2QKetRVR8W6tbEYq2CjAKAGvaiFi99Cr744eSKYY=
X-Sasl-enc: Np5+fFjleURAfSQuxNEaunKPAXe2FNAGfdAlOXIhJHnP 1441791776
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 97C5068013A;
	Wed,  9 Sep 2015 05:42:55 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAGZ79ka4+a_eyha=xCrQFBdLzgbT3ws1Jq7Q=WJw45Ob6bFFug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277545>

Stefan Beller venit, vidit, dixit 01.09.2015 19:56:
> On Tue, Sep 1, 2015 at 10:50 AM, Barry Warsaw <barry@python.org> wrote:
>> On Sep 01, 2015, at 09:42 AM, Junio C Hamano wrote:
>>
>>> That way, you are forcing all the existing scripts to be updated to
>>> say "git -c ..." for _all_ invocations of Git they have, aren't you?
>>
>> No, why?  If the default value enables the current ui, then no scripts need
>> changing.  Users can enable the new ui for their own benefit at their own
>> pace.  If you eventually want to make the new ui the default, provide a
>> sufficient transition period.
>>
>> Cheers,
>> -Barry
> 
> So say I am a user who wants to take the new command set. And as I am lazy to
> type it all the time I just do:
> 
>   $ git config --global command-version 2
> 
> Now I have all the new fancy stuff when I type it directly into the terminal.
> But when I run one of the old scripts my coworker gave me (which is used to
> the old notion), it must adhere to the old command world. How do you now figure
> out if this is interactive or script?

You can't. We have that exact same problem already with the recent
option-overriding config bloat. It needs to be solved sooner or later
anyways, by introducing some sort of "mode" (interactive vs. scripting),
since while in principle we have a separation between porcelain and
plumbing commands, we don't have, say, a plumbing version of "git tag"
and take that as an excuse^Wreason for any change to the porcelain
command "git tag". (You can freely interchange the roles here.)

Really, that porcelain-plumbing separation that's often mentioned is
more wishful thinking than actual reality, at least no complete reality,
or else we wouldn't even have any backward compatibility problem to
solve here.

So, UI rework or not, we should think about making that promise real: a
clear separation between a stable scripting interface and an evolving
user interface. Two possible ways are:

- separate commands, such as git-log vs. git-rev-list
- separate modes for the same commands

We use both of them ("interactive" detection for some default settings),
but partially only.

Michael
