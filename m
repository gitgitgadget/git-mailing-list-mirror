From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] git config: clarify bool types
Date: Mon, 12 Oct 2009 20:14:49 +0300
Message-ID: <94a0d4530910121014k666207b9ub38fcecd47641ace@mail.gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
	 <7v7hv1kxyg.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910120303y205e6cfeg80ba0dfd6ed5a045@mail.gmail.com>
	 <4AD3216B.7030507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:25:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxOeZ-0007fq-VB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 19:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZJLRQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 13:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbZJLRQi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 13:16:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:50271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZJLRQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 13:16:37 -0400
Received: by fg-out-1718.google.com with SMTP id 16so519058fgg.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 10:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=hziLNW2G5U9wA+PRDXrkOvLcfZ2NmCxCAsx+6wDxXRo=;
        b=BiVkQxw+TQjff5TRZIALLKqJcPLDJiBC1AqiYpdoUj8ToQPYxDJ4pEfuOOmw9vKGxb
         gGOpHfI3ORLT5ON6dE0OMipPqj/vKJlPlRKE61HLLhnxgcMR1JQjtLczluOpZxmQi50+
         g2Qx997rdI9VUkwkwHP+2yalAeJ5DeKkWoBv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Z4uMqvQg2g7m45Mkyh5lmzbqkX55DGi0dK4rL8CpPt292m1UDLs2ei4MJ3/Z064eHl
         HxPJlQej40QQPQKrdDJ7GRdCNVxSIpMnBSVfASF9XiSk3U8xt8uDrTMOJ1RSOwdySY/N
         k4ZeualAQ8XW4PKuas2c6iZWcu3ev5fKKMNaI=
Received: by 10.86.249.22 with SMTP id w22mr231062fgh.1.1255367689807; Mon, 12 
	Oct 2009 10:14:49 -0700 (PDT)
In-Reply-To: <4AD3216B.7030507@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130036>

On Mon, Oct 12, 2009 at 3:30 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 12.10.2009 12:03:
>> On Mon, Oct 12, 2009 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> The value is what it is, the --bool and --bool-or-int options don't
>>>> specify the value type, just how it is interpreted. For example: a value
>>>> of '1' can be interpreted as 'true'.
>>>
>>> It is not really about "interpreting", but about showing, isn't it?
>>
>> Unless you are setting it, instead of reading it.
>>
>
> I'd still suggest fixing the typo ("interpreted") and spelling out
> "boolean".

Oops! You mean s/intepreted/interpreted/?

If we spell 'boolean' we might as well spell 'integer'; I think bool
and int are fine.

-- 
Felipe Contreras
