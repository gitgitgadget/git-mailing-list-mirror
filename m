From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Wed, 25 May 2016 02:04:46 +0200
Message-ID: <9afb4e1e-9e60-79eb-c90f-77b2eb55d1aa@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <20160523195504.GA8957@dcvr.yhbt.net>
 <0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org>
 <vpqshx77h9o.fsf@anie.imag.fr> <20160524223005.GB23162@pug>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@grenoble-inp.org>
To: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 02:05:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5MJz-0000ON-I9
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 02:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbcEYAEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 20:04:53 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:42936 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbcEYAEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 20:04:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 923A320FB;
	Wed, 25 May 2016 02:04:48 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTSPiaGKy2Zp; Wed, 25 May 2016 02:04:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 80F1420F4;
	Wed, 25 May 2016 02:04:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7A7942077;
	Wed, 25 May 2016 02:04:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezwBJ_xrTGZ0; Wed, 25 May 2016 02:04:48 +0200 (CEST)
Received: from [192.168.0.19] (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 983C12066;
	Wed, 25 May 2016 02:04:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160524223005.GB23162@pug>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295546>

On 05/25/16 00:30, Aaron Schrab wrote:
> At 14:49 +0200 24 May 2016, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> wrote:
>> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>>
>>> What kind of help text would you want to see?
>>>
>>> Maybe something like this:
>>>
>>>   GIT: Quoted message body below.
>>>   GIT: Feel free to trim down the quoted text
>>>   GIT: to only relevant portions.
>>>
>>> As "GIT:" portions are ignored when parsed by `git send-email`.
>>
>> That's an option, but in the context of email, I think these
>> instructions are not necessary.
> 
> In an ideal world that would be true.  But in the real world I think
> evidence of many messages to this mailing list containing full quotes
> suggests it might be helpful. I'd actually argue that the message be
> more forceful, making it a suggestion/request to trim rather than simply
> telling the user that it's allowed.

Furthermore, it is a good way to avoid very long messages due to
unnecessary parts quoted.

Therefore, we thought about a request like "Please, trim down irrelevant
sections in the quoted message to keep your email concise"
