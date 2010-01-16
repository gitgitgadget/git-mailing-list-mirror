From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sun, 17 Jan 2010 02:39:16 +0800
Message-ID: <be6fef0d1001161039l7daf32f8v68e5ba4b03c3e2b3@mail.gmail.com>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <20100116203557.95340c00.rctay89@gmail.com>
	 <20100116134656.GA4504@Knoppix>
	 <20100116233043.26a5636d.rctay89@gmail.com>
	 <20100116155612.GA8383@Knoppix>
	 <be6fef0d1001160813o674ed93dn33843813be6f45be@mail.gmail.com>
	 <20100116182829.GA27474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 19:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWDYQ-0006KI-87
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0APSjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 13:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756090Ab0APSjR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:39:17 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:32967 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab0APSjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 13:39:16 -0500
Received: by iwn32 with SMTP id 32so1298078iwn.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=hLqgXs1Oh0PcKTHkTr9EwimO5mWTH8uetvMSZbseUYg=;
        b=jTp3BM+nI4SpHPvtDWEROmPkBvEgEUvzUfDYfeKWGljUO03Sdk6tAMhSIV789XOYwe
         V0gEVOLgx5tNHBgORp4QnzVw6vHY9Z/sPul+QPU8r46XuW7zpWHK4QpG4JReFJS4KHl+
         L3/2mI0oMyPx3Z4ErWUTMs9DMNUvPwicoO4RU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b0fjKBMtUlZ4A8Hxwe6SeRAuxa17bUgKuwMfUxwnKxTL/Tk/coY50mtKGSTYNTC3DU
         BTk1+lyT+81k7X7f9Prah4UL+4Ak75HJEn7epSnSMTYPkaEd8lEvld6AxhDxAPKqZgnx
         QDKaB1bHntXH6kvZSNn5wWgR4SqrBq16J9CQw=
Received: by 10.231.40.216 with SMTP id l24mr391914ibe.40.1263667156202; Sat, 
	16 Jan 2010 10:39:16 -0800 (PST)
In-Reply-To: <20100116182829.GA27474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137247>

Hi,

On Sun, Jan 17, 2010 at 2:28 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Jan 17, 2010 at 12:13:20AM +0800, Tay Ray Chuan wrote:
>
>> On Sat, Jan 16, 2010 at 11:56 PM, Ilari Liusvaara
>> <ilari.liusvaara@elisanet.fi> wrote:
>> > Hmm... In what conditions ref->status is 'none' after push operation
>> > has completed?
>>
>> when a match between a local and remote ref is not found.
>>
>> For example, the local ref 'master' will match the remote ref
>> 'master', but not 'retsam' ('master' spelled in reverse).
>
> How would it make any sense to set up a tracking branch, then? Not only
> is it not desired (if I said "git push -u foo:bar", I don't expect it to
> do _anything_ with some other local branch besides foo), but it wouldn't
> work, since the peer_ref pointer would be NULL.

Noted.

Ilari, please ignore my thought on 'none' then.

-- 
Cheers,
Ray Chuan
