From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 22:18:55 -0700
Message-ID: <7f9d599f0804292218x7d94d7del20d4d48bbad80fb5@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
	 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
	 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
	 <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
	 <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
	 <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
	 <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
	 <46a038f90804291958u14eddc49sb54c7fd4a3a10381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Nicolas Pitre" <nico@cam.org>, "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 07:20:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr4ja-0007GO-20
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 07:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbYD3FS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 01:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbYD3FS6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 01:18:58 -0400
Received: from rv-out-0708.google.com ([209.85.198.247]:34161 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752686AbYD3FS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 01:18:57 -0400
Received: by rv-out-0506.google.com with SMTP id k29so187787rvb.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=tTgBbmvyLwnXtbTi3sSX20UwbCQeDPqM5fTLZIxJQ6A=;
        b=RUF5/vqUJzJSJxov7qmZDPM82lnPweij0APSOAPyqncMPScTSUppFCXmS6y9qk0bujOX6AdVHXmTnv+RBB7OahxGhQNYwPEPMjD/Lt9cOWR4WWdbiNFFZXzfF948Vn5v+FaizWzE1TD2gIBqPyuEcQ79Wh5djGthe0CXIvkYUrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ht7o4OX8zz/CM6dFrVelzVoUA74rvEYV2epS3AQh5+aCh/oRRPkPvzCKaWty9tdorlKgeVoUkza7ADskWJlvde/Q49BKPIoChAbNELN6pzRL6i63E2km34ezwImaO/DdIF324laTmIL35WrC75FYaZdEsmlHUrWrhgC0Jvg86vc=
Received: by 10.140.169.4 with SMTP id r4mr125127rve.131.1209532735395;
        Tue, 29 Apr 2008 22:18:55 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Tue, 29 Apr 2008 22:18:55 -0700 (PDT)
In-Reply-To: <46a038f90804291958u14eddc49sb54c7fd4a3a10381@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: fbf4f978281e26a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80791>

On Tue, Apr 29, 2008 at 7:58 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Wed, Apr 30, 2008 at 8:31 AM, Geoffrey Irving <irving@naml.us> wrote:
>  >  I sincerely hope that pdf/postscript don't allow the internal
>  >  rendering code to branch based on the current date.  That would be an
>  >  absurd security hole, and would indeed make you entirely correct.  If
>
>  PS is Turing complete, and does know about dates. So yes, you can make
>  such conditionals.

I knew postscript was Turing complete, but had (naively) assumed it
executed sandboxed and deterministically and would therefore display
uniformly barring interpreter bugs.  Looking over the spec, I can't
find where it's possible to read the current date, but the
usertime/realtime variables are sufficient as long as the attacker
knows how fast the relevant machines are.

>  That original md5 paper with the 2 PDF files is mainly a good example
>  that you should trust binary blobs, that's all. The md5 trick is a
>  nice demo, but misses the point entirely.
>
>  I can't find it now, but someone had written a PDF file that printed
>  Pi computing in inside the PS VM. The tiny file would keep the printer
>  churning out paper until it ran out of memory. :-)

According to wikipedia, PDF doesn't have conditionals or loops of any
kind, so you probably mean a postscript file.

Geoffrey
