From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Tue, 08 Sep 2009 11:51:21 -0700
Message-ID: <4AA6A7A9.3080908@gmail.com>
References: <20090906064454.GA1643@coredump.intra.peff.net> <20090906064816.GC28941@coredump.intra.peff.net> <7v8wgsk0rw.fsf@alter.siamese.dyndns.org> <20090906072322.GA29949@coredump.intra.peff.net> <7vzl98fr22.fsf@alter.siamese.dyndns.org> <20090907094457.6117@nanako3.lavabit.com> <20090907082430.GA17997@coredump.intra.peff.net> <vpqeiqjf90u.fsf@bauges.imag.fr> <20090907085405.GA17968@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml5my-0006xu-CY
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 20:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbZIHSv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 14:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbZIHSv1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 14:51:27 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:50314 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZIHSv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 14:51:26 -0400
Received: by qyk11 with SMTP id 11so3018945qyk.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=e2BjxruDWRUBwJ6JMDKXdLE3PhUZb1Zo7dr6ai/zltU=;
        b=quaNbmzSGwtwqbJ0sRKAhy9irUfYO5POD0IFHt5BeWM3F3PK7NOh8ivwlBmecwFfMu
         ceVwQVSXktQDHXE8XwM5soWnP/uFblKzhfX+7JhcZeVOYMWlu4d7hfLnIk51ov8JJVSu
         MILw21rpXoJIxqcziQfjXu3fYuVx9ljuhp/3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gN589o6MYYNsRcCzgsP1TOrT7bfhfopcEyqKc+EL2Ysf0YEqpj3cu/8DMJ8PCYlOmt
         A371yZTSaBYzKfz9U3uOkziIg7Z5uWaXxme5d5Y4k2YczGoMbeiM8/Tzy+fNX4lvCx/t
         ozLwlMeYYny1apeTXXO/2KCHqa5+pkdXdDTPY=
Received: by 10.224.101.79 with SMTP id b15mr10225068qao.66.1252435885922;
        Tue, 08 Sep 2009 11:51:25 -0700 (PDT)
Received: from ?172.30.161.18? (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id 7sm50696qwf.46.2009.09.08.11.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Sep 2009 11:51:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <20090907085405.GA17968@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128023>

On 09/07/2009 01:54 AM, Jeff King wrote:
> At that point, why not just get rid of "message.all" and simply say
> "manually turn off the messages you don't like". Then the user can
> either go through the config manually as above, or they can wait until
> they become annoyed with a particular message and turn it off (and
> hopefully our naming is good enough that they can easily figure out
> which one it was :) ).
>
> So I think "be verbose, but let the user quiet us" is probably
> better than "be quiet, but let the user make us louder", because it is
> easier to discover verbose things. Which implies to me that
> "message.all", if it exists at all, should be limited in scope to just
> advice.

That seems like the most sane solution, given that it may not be obvious 
to the user what messages he/she may be missing if "expert" mode is on, 
and also from a coding perspective.

I know that by default I'd like to see new messages, and in case I'm 
doing something adventurous I'd like to see a message I may not have 
seen before. If I had turned off all messages because I got sick of 
seeing one or two in particular, then I'd never know.

Also, this thread started due to people's dislike of one particular 
message, so I think it's likely that in general someone would really 
only want to turn off at most a handful of messages, which again points 
to turning them off individually as being the best and simplest solution.

P.S. I never really introduced myself to the list... Uri Okrent here 
from L.A. Keep up the great work everyone!
-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
