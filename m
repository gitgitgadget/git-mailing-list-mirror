From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Thu, 5 Dec 2013 07:18:41 +0700
Message-ID: <CACsJy8Aj_RLUteevuHDzFRTHZgkWjSTb669ZiZV5fLPP6dYf1Q@mail.gmail.com>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
 <CAJo=hJuzP=zYsEZvC5ugKaAWPLAcTzmFJxT5PNFKbBEv0ctnDw@mail.gmail.com>
 <20131204184842.GA11024@sigill.intra.peff.net> <20131204232800.GG29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 01:19:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoMey-00054y-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 01:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3LEATN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 19:19:13 -0500
Received: from mail-qe0-f44.google.com ([209.85.128.44]:44690 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3LEATM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 19:19:12 -0500
Received: by mail-qe0-f44.google.com with SMTP id nd7so16246758qeb.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QRWYMBruqlTAzz/72Ag2pcJPEYlUleVbP2nEXMVogNk=;
        b=Tvd4nhyj7IizA/Vs4S0BNPTN+x7Y2CueNw6dWzYCbvsKlosPonUZj4PohBcvmSHxa2
         DoTjQbZHoANAM9ihJgHQy25J6XZlf0ZfOMBgtYHnPRNl2+9Ch9TcfNcQkW1Ir4ei6L+n
         JLJva+82a4ntlt0EBtwrKyl3JrY5zZzgZpGWIedDjgT8yqFryHMHI686de66Ztmr4GoR
         p1WyGYO2d3dPNyrKA9t3ESl/6JDW1eLm8WaQKAeXq2YmhCLxnj7lwps8uSpYZi5LZwW8
         JLqtHLRQP2LjMn9w8aPhRe0fhqiom2SRepIGT2KWgAlDkgAStR8ANNK9bTBHL88hZxCd
         tXcw==
X-Received: by 10.49.12.102 with SMTP id x6mr141543331qeb.5.1386202751478;
 Wed, 04 Dec 2013 16:19:11 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 4 Dec 2013 16:18:41 -0800 (PST)
In-Reply-To: <20131204232800.GG29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238830>

On Thu, Dec 5, 2013 at 6:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
>
>> I don't know if it is worth all that much effort, though. I suppose it
>> could get us more exposure to the httpd tests, but I do not know if it
>> would be a good idea to turn them on by default anyway. They touch
>> global machine resources (like ports) that can cause conflicts or test
>> failures. I assume that is the reason we do not turn on git-daemon tests
>> by default
>
> Yup, that's why I don't run them.
>
> For what it's worth, when I build git and run tests I tend to be in an
> environment with apache available, but I'm too lazy to configure git's
> tests to pick the right port and make sure it is reserved and so on.
> Perhaps there's some way to help lazy people in the same boat?  (E.g.,
> picking a port randomly and skipping instead of failing a test when
> it's taken or something)

Sounds like good first steps.
-- 
Duy
