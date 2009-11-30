From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 09:04:25 +0100
Message-ID: <fabb9a1e0911300004w36c5da45q354aa4ff3153b6f4@mail.gmail.com>
References: <20091130075221.GA5421@coredump.intra.peff.net> 
	<fabb9a1e0911292355v260b9f0ck79d993e25f0c5c61@mail.gmail.com> 
	<20091130075927.GA5767@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1Fc-0003Cq-NZ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZK3IEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZK3IEj
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:04:39 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:55181 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbZK3IEj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:04:39 -0500
Received: by vws35 with SMTP id 35so985388vws.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 00:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=TMoAJHomVsepgu/TGhkJlnurr/tWXRE59QTVJK3b7kA=;
        b=USQ5nvVZjRGF3Ea3C8D809vGylQQlF9hRWdC0CGExmjto9Ha+RVBZ9N9FLqdIYHrqF
         eN3622A0B0D2tokCoM6x1CzW1avPWyL3Jf4eAUB+Zb+99of6MAZVWx3NVghWYEbUgXDT
         OZdWRnKahIe4VpmNQCZFq/XYbVVjElfWYRFtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tzONcfmB/2CjRxHgBUAQPEoP6ce4bvB2ZcDkOs8E9o5mfSYI4g1vk3sduQReRG0Lei
         ZedsklQ3AaFBfF+IBX7koniPR4wCIGfDS4jHnmXYSALYXN/LgqyCAnGQR5Ft0e8WThLe
         7DUGYIaabDyIA5WjevF7yH70fY6AZS7hmhVfA=
Received: by 10.220.123.105 with SMTP id o41mr4739928vcr.88.1259568285048; 
	Mon, 30 Nov 2009 00:04:45 -0800 (PST)
In-Reply-To: <20091130075927.GA5767@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134076>

Heya,

On Mon, Nov 30, 2009 at 08:59, Jeff King <peff@peff.net> wrote:
> I mean, I would think that the "git_remote_helpers" directory contained
> remote helpers of all sorts, not just the python ones.

I don't think that's true, git.git currently does not have such a
structure (everything is just dumped in the root directory). The only
reason git_remote_helpers exists is to make it easier to create a
python egg out of it and install that. At least, that's what I think
is going on, Johan and Daniel might have comments to the contrary.

-- 
Cheers,

Sverre Rabbelier
