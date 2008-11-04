From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: Intensive rename detection
Date: Mon, 3 Nov 2008 22:36:42 -0800
Message-ID: <216e54900811032236l5ae4bde5v16ab6519962e428f@mail.gmail.com>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com>
	 <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
	 <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
	 <216e54900811032107p159e98ecn8958f0a78efde8f2@mail.gmail.com>
	 <216e54900811032119h4cb51327v2d85712acc444185@mail.gmail.com>
	 <216e54900811032202h5c82e3a9j30100e5b82f6a16a@mail.gmail.com>
	 <20081104061647.GA18297@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 07:38:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxFYE-0000OU-Su
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 07:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbYKDGgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 01:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYKDGgq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 01:36:46 -0500
Received: from el-out-1112.google.com ([209.85.162.177]:4887 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYKDGgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 01:36:45 -0500
Received: by el-out-1112.google.com with SMTP id z25so1384975ele.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 22:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2ER21tNFgCYD8X0uhRZ8Ahl1884dXNU2EjY4fWE8tco=;
        b=TqJHmk/nHIwLSpJjlQxdJx3yMXXXuojpe4VoAG6G56owFyMrITodb0zCjdFXNxX/Ce
         8cO3KMBcBhsqyly/q4f78lZavc0ZYK58cYIb4jIEGpiLkoAM9AXMaloeCjhgHakfJGPQ
         JXL7dPsRmC0eMNFPil17nUoBIrcpmicosn+Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hrL002mPhORv3/85ej8G/X6StkJfqPlHeZf/89bCZMW591Ly8TcN6b3jPJSRwpD2jd
         Yz4Q7FeAf2xeIARsg3b6QMIV/emH18n+V3qw4eyjCWf2WGofFd92SmnWO6QK0BRDMPo5
         jK94s3g0B0qooOAzXQgqT/EgbDwcFrNwQNGUQ=
Received: by 10.151.155.21 with SMTP id h21mr1826996ybo.110.1225780603005;
        Mon, 03 Nov 2008 22:36:43 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Mon, 3 Nov 2008 22:36:42 -0800 (PST)
In-Reply-To: <20081104061647.GA18297@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100045>

Yes, on git status.  I'm afraid I don't know how to look up the
reference you gave.

On Mon, Nov 3, 2008 at 10:16 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 03, 2008 at 10:02:37PM -0800, Andrew Arnott wrote:
>
>> Hmmm.... actually on second run I am still getting the too many files
>> warning.  I put the [diff] section in a ~/.gitconfig file, a
>> .gitconfig file in the root of my repo, and in the .git/config file,
>> but none of them seem to get rid of the message.
>
> Where are you getting the warning? On "git status"?
>
> If so, then this is an instance of the problem I mentioned here:
>
>  [PATCH v3 7/8] wt-status: load diff ui config
>  20081026044935.GG21047@coredump.intra.peff.net
>
> (sorry, I would link to gmane, but it seems to be down at the moment).
> Junio, maybe it is worth applying after all (we could also do just the
> diff "basic" config instead).
>
> -Peff
>
