From: James Nylen <jnylen@gmail.com>
Subject: Re: feature request
Date: Mon, 18 Feb 2013 14:54:30 -0500
Message-ID: <CABVa4NgsbeNGS2F2jQJ5d9bDcFb4=oEVrBg_-n2eYjwnfQzMqA@mail.gmail.com>
References: <BLU0-SMTP2753D5BFC50D7334EDDE278E1F40@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, peff@peff.net
To: Jay Townsend <townsend891@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Wnh-00071R-DY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab3BRTyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:54:32 -0500
Received: from mail-vc0-f179.google.com ([209.85.220.179]:41448 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757108Ab3BRTyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 14:54:31 -0500
Received: by mail-vc0-f179.google.com with SMTP id gb23so3862127vcb.10
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DlFof3GUr+lyIXVkaj/iBqyhQdAKSFrNzHEItVw81dk=;
        b=elvpLIRZw2FMRUXgFGPySpdHgXVW0nD6pTOk/RgLJjDhvCqcA9zRa0+vjaZQJWQUxa
         ZvG7YE3p2eWGiAzDBWrn3kB0gNZlIuSAIZvZSiskU08npFUmF68pEj/j2ZvQ0qZujA66
         Nbyl92Wl4D9fFcpkXoDdSYYAs4vIh9DacbjGcRIqXjv5OSVzzZPue138NNH0sZpPLnaM
         daAL69v+VkBCQJyJGRfkfHwpwzMsFt6Lptmt7E4/wf0UevsInrpwGGaGs9fW1mGgtKnk
         MqpE/KaDB58k/ulcK5iuj6VzNUfkpFs/2w7huOU0C43Z3yvMyvMkGbh/NTDRNDHe6opO
         vDSQ==
X-Received: by 10.52.175.130 with SMTP id ca2mr437843vdc.109.1361217270714;
 Mon, 18 Feb 2013 11:54:30 -0800 (PST)
Received: by 10.220.125.65 with HTTP; Mon, 18 Feb 2013 11:54:30 -0800 (PST)
In-Reply-To: <BLU0-SMTP2753D5BFC50D7334EDDE278E1F40@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216507>

On Mon, Feb 18, 2013 at 1:52 PM, Jay Townsend <townsend891@hotmail.com> wrote:
> Hi everyone,
>
> Just would like to request a security feature to help secure peoples github
> accounts more by supporting 2 factor authentication like the yubikey more
> information can be found from this link www.yubico.com/develop/ and googles
> 2 factor authentication. Hope it gets implemented as I think it would make a
> great feature

This would most likely be something that users would set up with their
SSH client, and GitHub would have to provide support for it on their
servers as well.  It shouldn't require any changes to git.  Here is an
example of how this could be done:

http://www.howtogeek.com/121650/how-to-secure-ssh-with-google-authenticators-two-factor-authentication/

I like the idea, and I would probably use it if it were available.
Jeff, what do you think?
