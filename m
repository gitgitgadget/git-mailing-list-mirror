From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: Submitting patches from unsubscribed authors?
Date: Wed, 17 Sep 2008 00:44:55 +0100
Message-ID: <57518fd10809161644v348bd347xeed0bc7cb35805a1@mail.gmail.com>
References: <57518fd10809161624u3b2937dmd36e0fc962ea7a7@mail.gmail.com>
	 <20080916233613.GA14251@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfkFB-0005si-1L
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYIPXo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYIPXo5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:44:57 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:48010 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbYIPXo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:44:56 -0400
Received: by py-out-1112.google.com with SMTP id p76so2178316pyb.10
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=DOdx2PbGqNfTyL0/HXQuj/MtunYbRsdO1qSMCeD46w0=;
        b=RjkRTueyriE0R61duEhTkTFvz+WrVX7AXr/NrS521qFurQEioTXb+AZiJhSc2msBDr
         EvpMEKMTYCgkXOF+QNgFRt6yLflSEa/tzMxlnJKhvBJsToXB6UgpTNzO5JpDiT9fjsHq
         xrzvKx8eMdUEvGuhAYGlfW1SNUxOv5HrqPYB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=l4XMal04IXAKUz5JY9HPA9FPt8FlE3c8dvCgX2KXWfRXBqPhyrEsLn05dUtzW07Gq2
         BEEnhdBxaVJDhEEWtqJCiFFWOQJ/X5968Dwg/C/Iqk/8KNU1eA5wwEVqUA8nsANHywSN
         6MJsRz6n3v7IN4M3TFTwjJRTrf4sis4rFP73k=
Received: by 10.142.193.13 with SMTP id q13mr599943wff.118.1221608695264;
        Tue, 16 Sep 2008 16:44:55 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Tue, 16 Sep 2008 16:44:55 -0700 (PDT)
In-Reply-To: <20080916233613.GA14251@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 04ce40e0d0f6ea22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96052>

On Wed, Sep 17, 2008 at 12:36 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 17, 2008 at 12:24:48AM +0100, Jonathan del Strother wrote:
>
>> Is it possible to submit a patch to the mailing list, from an author
>> that isn't subscribed?  Last time I submitted a patch I went via my
>
> Yes. The list accepts mail from non-subscribers.

Ah.  I was getting mail rejected when I was trying to use my real
email address, but now I look more closely, they're rejected because I
was sending via a local postfix server & it didn't recognise the
hostname.  Doh...


>> throwaway email address, and so that was used as the commit author.
>> It looks like "git am" is always going to just use the email address
>> used to post to the mailing list as the email address, but I'm sure in
>> the past that my patches have appeared under my real email.  Was that
>> just manual intervention by the maintainer?

>
> Yes, it pulls it from the From: header. However, you can override that
> by including
>
>  From: Your Real Name <yourrealaddress>
>
> as the first line of the mail. git-send-email will do this for you
> automagically if the commit author and your email sending address are
> not the same.
>
> Look at some of your previous patches to the list; they have this line.
>

I assumed that I was confusing git-send-email with my multiple email
addresses and that was a broken header.  git-am will work fine with
that second From: line being embedded in the commit message, then?
