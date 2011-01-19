From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Wed, 19 Jan 2011 14:15:13 +0100
Message-ID: <AANLkTintdDZ_WZYcM77eMbhBOaEShkELuZ5wuMCQ_3M=@mail.gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
	<AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
	<54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
	<AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
	<7vd3nukqn8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Aaron S. Meurer" <asmeurer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 14:15:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfXsg-00052f-4R
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 14:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab1ASNPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 08:15:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52619 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab1ASNPO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 08:15:14 -0500
Received: by wwa36 with SMTP id 36so863395wwa.1
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 05:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=36PSvbmBdsqqRvJ/oTdL3igvKKobkPKN3bVXzE+smJ8=;
        b=iq4Bm4PxcpbzTgHqHX1htvGXLN1qi8cWASh8dwPQhH1dmRsc61rTaNAxx1iasq17w/
         aonETfydigdJCLDcugPvb3wnRRcZBowErnLZoRC44a/61fqYz3JtSIOH4a0sAeVkayQX
         bwIQav4kESQ0j2FNDJy5X4hDULtSqUPTykVBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OdQlbQxXDsczUtiaCl77crqjaZMX5XThdkGbEyVD2QH8L+FxUfsKViL81f4lMm9OVR
         bbSA3x1ePUXrhuOQoYRl09t0ploqfrafY1+Y6j7PfJNFLhN6q/LRdjAQ/ptU5g0Ez7A2
         sFUgIq8W79sGCZYgZNVOw47k2wBwNA11FwWqA=
Received: by 10.216.179.81 with SMTP id g59mr2501391wem.35.1295442913105; Wed,
 19 Jan 2011 05:15:13 -0800 (PST)
Received: by 10.216.30.65 with HTTP; Wed, 19 Jan 2011 05:15:13 -0800 (PST)
In-Reply-To: <7vd3nukqn8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165267>

On Tue, Jan 18, 2011 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Well, bugs are usually fixed within days after they have been
>> reported. Otherwise they are usually documented in the code or in the
>> documentation or in the test suite (with test_expect_failure).
>>
>> For the rest we rely on people remembering what happened and on
>> people's mailing list searching skills ;-)
>
> Not really.
>
> What we do is to take advantage of the fact that issues people do care
> about are important ones, and others that nobody cares about are not worth
> pursuing.
>
> In a sense, "people forgetting" is a lot more important than "people
> remembering" to filter unimportant issues (issues that are so unimportant
> that even the original complainer does not bother to come back and
> re-raise it).

Thanks for the clarification, now I feel much better about how well I
am doing regarding the mailing list :-)
Christian.
