From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 13:08:04 -0800
Message-ID: <20130131210804.GL27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
 <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
 <20130131200434.GI27340@google.com>
 <7v622dgl2o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 22:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U11N3-0007st-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 22:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab3AaVIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 16:08:11 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41334 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab3AaVIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 16:08:10 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so1047542pbc.39
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 13:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S7Lcvhiw7X+JIiQdmdG7YElxp6hlfMfzLM/L1to6iUU=;
        b=n0KlDR2pBub1l4SK2Wo7c/61fMhs9tvI8PN0vVKFK2lFWf5RHbABTrqiPN7lfBdkDU
         xH0UoQMQY6oc8T12Bg7eE5uDp5LMvOcJtghLMNiK5pEdbcnrqLLPVRQ/BXP9e2uutOGA
         S0WqqxIV86E2zrZ2Y96yisrC30t1lT3G+3q9Soc6AwDbPykaYN8txfyi/UTHZ24qKFQ2
         +eR+7rB3on7iSkSxhPvAwidzT3trXdAHRiYu6GakrR68ZL+1fHY9fF9c28zRfwEPgxCD
         U/IgQfRhJzNce2zJLHm68XDyKHsEFHUY0HFeK64NrgPc04U41D7KjYFXjnyE35KeT+vT
         OhAw==
X-Received: by 10.68.231.137 with SMTP id tg9mr25919008pbc.45.1359666489922;
        Thu, 31 Jan 2013 13:08:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id d1sm6650022pav.6.2013.01.31.13.08.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 13:08:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v622dgl2o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215172>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Junio C Hamano wrote:

>>>                                                      For those who
>>> want to _learn_ what possibilities are available to them (i.e. they
>>> are not going from `tracking` to what it means, but going in the
>>> opposite direction), it should be unmistakingly clear that
>>> `tracking` is not a part of the choices they should make.
>>
>> Until pre-1.7.4 versions of git fall out of use, I don't agree that
>> the above is true. :(
>
> The documentation ships with the version that the above is true.  We
> are not making an update to documentation that comes with ancient
> versions.

Part of the context that I should have mentioned but didn't is that it
is common to put $HOME on a shared filesystem.

[...]
>> How about the following?
>>
>>     * `nothing` - ...
>>     * `matching` - ...
>>     * `upstream` - ...
>>     * `simple` - ...
>>     * `current` - ...
>>
>>   For compatibility with ancient config files, the following synonym
>>   is also supported.  Don't use it.
>>
>>     * `tracking` - old name for `upstream`
>
> Didn't I say I am fine to mention it "as a side note" in the
> original message you started responding to?

Yes, I understood what you were proposing and I directly disagreed
with it and explained why.

The above is something like a compromise --- more precisely, it is an
attempt to do something better than a straight revert and to
understand whether it would address your objection.  Clearly it
doesn't.  I don't understand why.

Perhaps the "Don't use it" is over the top and that is your complaint?
It's true that if I were writing it without your objection in mind, I
wouldn't have included that sentence.  It was written on the
assumption that you want to discourage people from using the
"tracking" synonym --- I am not personally convinced that that is
worth discouraging at all, but it's fine with me if the consensus is
to do so.

Jonathan
