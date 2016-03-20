From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 20 Mar 2016 17:08:46 +0100
Message-ID: <A0465058-2171-4C00-8D45-C610046C496D@gmail.com>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <56EAC49B.6020909@gmail.com> <33EDD26C-ED5A-42EE-B523-240AEF5C51B7@gmail.com> <56EEC6EE.10602@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Kevin Daudt <me@ikke.info>, philipoakley@iee.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:08:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahfuS-0003LN-8t
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 17:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbcCTQIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 12:08:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35583 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbcCTQIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 12:08:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id r129so4733676wmr.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wxwWu45QlCMdhKBvQJ72qIXeae0dggH9iLcsPQEOJI4=;
        b=wxAAggbvEt78UeGFQHpCXH9nPtVvVcRIBY5IkD+/ywAj0T95R2HhnmKQ757eabxAsE
         XJyEYjEgnYY57jp3NR1G681+QXmO8Fmszp1iRmLlR3pFjx6BGkLVQBbyhDI9LVIQdDBW
         jx1I+hpRxP+sYGZo5te+abQJWlcgde+ztxB7ClMfEMkWLyW+1GAJf6HsUvc51lIfQvyI
         y0XAFYWx49aoZqIit1/eHdLbCtVIJdYuQwHmGryh/I1ofk+6T1K/PVXm6KpvT9gNQTzF
         gl2L83tPoXYBNvXBw8Bjs8gB30gwTnQf5p0BRlkcH19GTULNo4ygKZRJqxx9wefu2FaT
         g12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wxwWu45QlCMdhKBvQJ72qIXeae0dggH9iLcsPQEOJI4=;
        b=S6x2yVOjoyDBquxQ0DEkQ5oL0chfi40ShHFHt+ydxef4gN/8UF5Dx2HzGShttGgTcZ
         V5KEi6KJ4HPQo7+ENS+MV/+5JnDoBuPQtQXkPPHNaIVSBchSyjLTc2qYkCVUaDinR6LP
         vmUto7v34UJ5AQVENH7uvhjKVMihvt9944Xw8cNdvVhWJOtYFvrqphWsyBWIJrS9U47d
         cxc02OKcHobMZmHRVWePFUwHVKEHG1g7eCxP78I+URaR47jD7Pm6xR7wzpX+C121mO5o
         3KfRkGvflyh2FghfoV9wGAVvvnCZL6GPUR4CdIG2FcB0V2yRZxY4IKDMUvS2yz38QVQ1
         kbaw==
X-Gm-Message-State: AD7BkJK0FIdu1vxzX1zHAQGdHsU/ImU9PdgTFdBuEcG6vQswm4IBih0gicbx/xLcOrJVMA==
X-Received: by 10.28.156.146 with SMTP id f140mr8676241wme.99.1458490129601;
        Sun, 20 Mar 2016 09:08:49 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id c144sm8340592wmd.12.2016.03.20.09.08.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 09:08:48 -0700 (PDT)
In-Reply-To: <56EEC6EE.10602@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289362>


On 20 Mar 2016, at 16:51, Sidhant Sharma <tigerkid001@gmail.com> wrote:

> On Sunday 20 March 2016 09:09 PM, Lars Schneider wrote:
>> Hi Sidhant,
>> 
>> that sounds about right to me. In what language do you plan to implement the 
>> wrapper?
> I'm comfortable in programming with C, so I think I can use that. Otherwise,
> I'm also comfortable with python and familiar with bash, if they are required.
> Would C be the right choice though?
> Also, I've made a draft proposal for the project and uploaded to the GSoC
> application site. Should I send it to the list as well for RFC?

Although I like Python a lot, I don't think it would be a good choice. AFAIK Git
core does not depend on Python and therefore you can't really expect a Python
interpreter in every Git environment (e.g. it is not part of Git for Windows).

The wrapper could certainly be implemented in C, although I don't know if this 
would make things harder then they need to be. My initial thought was to use a
scripting language that is known to be shipped with Git (Bash or Perl). I
think Perl might even have an advantage as it offers very good regex/string
processing functions (disclaimer: I am no Perl expert at all...).

Please post your draft proposal as plain text RFC to the list.

Thanks,
Lars


> 
> Thanks,
> Sidhant Sharma
>> Best,
>> Lars
>> 
>> On 17 Mar 2016, at 15:52, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>> 
>>> Hi,
>>> 
>>> So to sum up, the list of tasks for the project would be:
>>> 1. A wrapper is to be implemented around (called 'ggit') that will scan the
>>> arguments for potentially destructive commands. When none are found, all the
>>> arguments will simply be passed through to git.
>>> 2. If such a command is found, 'ggit' will:
>>>   a. Show what the command is actually going to do.
>>>   b. Ask the user if they are sure they want to execute it.
>>> Eg. "You are about to do X which  will permanently destroy Y. Do you want to
>>> continue?"
>>> 3. For all commands that are entered, 'ggit' will also show a brief summary of
>>> the command what it will do when executed, explaining it's intended usage.
>>> 
>>> Is the list correct, or did I miss something?
>>> 
>>> 
>>> Thanks and regards,
>>> Sidhant Sharma
> 
