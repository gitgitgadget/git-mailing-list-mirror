From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] mergetools: Make tortoisemerge work with
Date: Fri, 25 Jan 2013 23:10:16 -0800
Message-ID: <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
References: <50FBD4AD.2060208@tu-clausthal.de>
	<7v4nibjrg0.fsf@alter.siamese.dyndns.org>
	<50FCFBBB.2080305@tu-clausthal.de>
	<7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
	<5101B0A5.1020308@tu-clausthal.de>
	<51024B02.9020400@tu-clausthal.de>
	<CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
	<5102837C.9000608@tu-clausthal.de>
	<7v622l5d87.fsf@alter.siamese.dyndns.org>
	<51032E96.2040209@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sat Jan 26 08:10:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyzub-0001kt-38
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 08:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab3AZHKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 02:10:20 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:42554 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab3AZHKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 02:10:18 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so684720wgi.27
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 23:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/RXNOZ9HOKtAPITSITqJ/0xLwp0oC3Ex+RDPletAvCI=;
        b=nuDA73gMO3a0Eyvk9AIj/hzSDydKwmpkdyRk1XA9ZNyoUxko3cuqxEvQA3j6NqGtB7
         NtgU5nVM3mb6XHkP3Zl8a5sw0M6+Ry78Erdzlo4g8RhVTHF7bxG6atJff+w+j0LQ7hYj
         LVaoSigYW4reTeOs2PeG6UT9Emd4zycyZUxE45o+N33tPLYgJ09x6gN1ihNWFhCO3oDn
         BGybWc+TtvXvkFlCiLlqRK2gppADg8jaJSkCjkwaxKEkr0oHDFjCqZm3OcMUg/4sUGeb
         dos7JGHbavTXPY45yap1j39FGEOT/8ylh85jCigbrHiyYjnQ9JkxnmbUbr9Y3QCSdg/k
         cdyg==
X-Received: by 10.180.108.236 with SMTP id hn12mr1276106wib.6.1359184216827;
 Fri, 25 Jan 2013 23:10:16 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Fri, 25 Jan 2013 23:10:16 -0800 (PST)
In-Reply-To: <51032E96.2040209@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214613>

On Fri, Jan 25, 2013 at 5:17 PM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> TortoiseGitMerge now separates cli parameter key-values by space instead
> of colons as TortoiseSVN TortoiseMerge does and supports filesnames
> with spaces in it this way now.

These patches look correct (I do not have the tool to test)
but I think we should fixup this commit message.

How about something like...

mergetools: Teach tortoisemerge about TortoiseGitMerge

TortoiseGitMerge improved its syntax to allow for file paths
with spaces.  Detect when it is installed and prefer it over
TortoiseMerge.
-- 
David
