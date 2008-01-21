From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 12:16:16 +1300
Message-ID: <46a038f90801211516j1f4e10c3q364b446d1293542b@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	 <373E260A-6786-4932-956A-68706AA7C469@sb.org>
	 <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
	 <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
	 <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org>
	 <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
	 <46a038f90801211456h4b16ff2cl4378df88023bbc34@mail.gmail.com>
	 <53C76BEA-2232-4940-8776-9DF1880089A4@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:16:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5sr-0005XX-EB
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYAUXQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbYAUXQW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:16:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:41991 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbYAUXQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 18:16:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975158ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=h0fVEafaeygizGXZEnxnhmurqMhz6ykiDU3inA9AscM=;
        b=qH4uzm/DDb8Rv0usGKO633BsJtK43N3JwJJFhOh7tLHerZuo+l+n48nvJLI+mp6v/hoY4OcG2E/oU6iWgiZyPJv/G2xwAHw331cdZVB9wpiN/5ERWG7KsXDrsgRbo38yIBl7y5kn4rD2M91seEz/vHmvLZzhUXd8x+ChDnT99Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gfE2uRcGPcK59BmsF0jk1sldJu/MMBthug8gwXdYr+LETzmIOQWjzP4rN6PEcFn6hGn4xbjJQPSdQ1Y8WROgZCGyoPxZfThqjhj2org5K4PEVg8g1Flcd9iLksvpwLYnXAKKtLbqmtBOqOOAtkHsRwpSnMtwTR2vC594uwADApQ=
Received: by 10.66.237.14 with SMTP id k14mr4465646ugh.72.1200957377205;
        Mon, 21 Jan 2008 15:16:17 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 15:16:16 -0800 (PST)
In-Reply-To: <53C76BEA-2232-4940-8776-9DF1880089A4@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71372>

On Jan 22, 2008 12:02 PM, Kevin Ballard <kevin@sb.org> wrote:
> I'd imagine writing an OS to be a horrifically complicated task. And yes, I
> can certainly imagine HFS+ might have issues when used to back an NFS server
> with other clients, but that still leads back to the original point, which
> is that all these problems stem from the differences between HFS+ and other
> filesystems, not any inherent problem with HFS+ itself.

Right. If you are defining the requirements for a new FS on a new OS,
would you not include a requirement that says "must not add any funny
rule that prevents clean interoperation with other filesystems or
OSs"? Forgetting that requirement is... a big one! And if someone asks
"how do we do nice user-friendly filename matching with these
technical differences that users mostly don't care about"... wouldn't
you say "do it in the GUI facilities, changing the FS to handle this
is wrong because it will break the OS as a server, as a reliable file
storage"?

FSs have pretty hard requirements these days -- all the modern FS
you've heard about respect the requirement above, and a ton more that
you have to be in the FS business to be aware of. Mostly anyway,
wherever they don't, users have all sorts of trouble.

> IIRC, the biggest problem he talked about was the changing unicode standard,
> but since the technote appears to state that HFS+ will not be changing its
> normalization algorithms to preserve backwards compatibility with existing
> volumes, that doesn't appear to be a nasty issue after all. Is there another
> issue I've failed to address in this thread?

Well, Ted answered that part, noting that then the "normalisation" is
patchy, and everyone else is left to guess what chars are normalised
and what chars aren't so being HFS+ compatible becomes a very weird
game indeed. You didn't reply to his explanation -- you called him
arrogant instead. Did you manage to read to the end if his email?

The HFS+ designers mucked it up -- and then papered over it with the
OSX libraries. But a good chunk of the world does not use them, they
forgot about the little "interop" requirement.

cheers,


m
