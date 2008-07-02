From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/4] Add git-sequencer prototype documentation
Date: Wed, 2 Jul 2008 02:39:40 +0200
Message-ID: <200807020239.41613.jnareb@gmail.com>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <200807012004.11563.jnareb@gmail.com> <20080701195033.GD5301@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 02:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDqLE-00024J-6G
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 02:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYGBAf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 20:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756179AbYGBAf4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 20:35:56 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:22297 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYGBAfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 20:35:54 -0400
Received: by ik-out-1112.google.com with SMTP id c28so62548ika.5
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=T7eYRNPaGE40ZsUCtQWkX4Xbjc1LO946tDC3v7H4fN0=;
        b=ZFHw4pxNbE//quxSRgapmCfxFcB+Wh8LeNertN/v+T4p/LUVxSxhyfiWLGTHlSVPYf
         wO8RLswRJWHg9EuKZcLmZyJhkqabZxfQ/98By8CnqTsa5rb1kJH2he5oRK0s8vuVOM2f
         xuZcLzbsNVBG0j3tldA33UlBTmNYPgkmrZ1nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OekHAa24TlZY3OwkAZC4bYBM5/3GRbmKD9CLAIp0rXbcnVbWZuNcMJzqe5aBT8Ds4y
         QsXg/2QkwxJ0aL5P6VcZ6ZKtVpX8+92r2L04GRzmDtbQt/9I9btNgoQ0bKjwheEkOUV3
         ER8Pg8MrW4MwwaOewIl0kiNOfH8HWx0nWqiUc=
Received: by 10.210.137.14 with SMTP id k14mr5936493ebd.162.1214958953041;
        Tue, 01 Jul 2008 17:35:53 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.156])
        by mx.google.com with ESMTPS id k5sm1820614nfd.22.2008.07.01.17.35.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jul 2008 17:35:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080701195033.GD5301@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87074>

Hi!

On Tue, 1 July 2008, Stephan Beyer wrote:
> On Tue, Jul 01, 2008 at 08:04:10PM +0200, Jakub Narebski wrote:
>> On Tue, 1 Jul 2008, Stephan Beyer wrote:
>>> On Tue, Jul 01, 2008 at 06:02:54AM -0700,
>>> Jakub Narebski <jnareb@gmail.com> wrote:
>>>> Stephan Beyer wrote:
[...]
>>>>> +ref <ref>::
>>>>> +	Set ref `<ref>` to the current HEAD, see also
>>>>> +	linkgit:git-update-ref[1].
>>>> 
>>>> So this functions like "git reset --soft <ref>", isn't it?
>>> 
>>> No. Why do you think that? `ref` is set, and not HEAD.
>>> I think the description makes that clear.
>> 
>> Ah.  I'm sorry.  So it is like "git branch <ref>", isn't it?

Actually I meant "git branch -f <ref>" here.  But I forgot that it
can be used to create lightweight tags, too.

> No. It is "git-update-ref <ref> HEAD".

So what do you envision would this be used for?

>> What is important is: does it update reflog (correctly)?
> 
> Good question. The reflog is another mistery to me that I haven't really
> cared about, because I haven't used it yet myself.
> At least the reflog test cases for git rebase -i in the test suite pass.
> (Of course, this is only a weak indication that it works as it should.)

You have 'branch' (<onto>) reflog, HEAD reflog, and reflog for '<ref>'.
While 'branch' reflog should I think record only start and end of
sequencer, or rather git-am or git-rebase, I'm not sure what to do about
HEAD reflog...  We should fill reflog for <ref>, to be able to revert
easily.

>>>>> +squash [options] --from <mark>::
> [...]
>>> Here an example why it is useful for user-editing:
>>> 
>>> (on commit f00babe)
>>> 	mark :1
>>> 	pick badcebab
>>> 	patch foo
>>> 	pick dadadada
>>> 	squash -m "Foo the cebab" --signoff --from :1
>>> 
>>> This squashes all between the mark and the squash into one commit,
>>> on top of f00babe.
>>  
>> Ah, so squash --from <mark> picks up everything since "mark <mark>",
>> but does not include marked commit!  Clever!  In this case allowing
>> only <mark> is a good idea, IMVHO.
> 
> Good, thanks :)

Although I guess having example would make it clear from the go...

Good work!
-- 
Jakub Narebski
Poland
