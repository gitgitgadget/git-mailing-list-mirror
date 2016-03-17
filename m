From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Thu, 17 Mar 2016 15:43:34 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603171536420.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-19-git-send-email-dturner@twopensource.com> <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com> <alpine.DEB.2.20.1603151517590.4690@virtualbox>
 <1458151880.9385.1.camel@twopensource.com> <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:43:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agZ9O-0006xq-6d
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 15:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966315AbcCQOnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 10:43:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:63684 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932781AbcCQOnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 10:43:39 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MKu9E-1agZ9D2Wps-0001D5; Thu, 17 Mar 2016 15:43:35
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UkVl8FN7PT2l+0uGZ6/WnFaan/gdysq2DO1T0yGhgLGVLC1IAWr
 qXkIQiMP1Ev1VVqZ/f8zeV2LYfQoxpDwyGM7xh/qyuzPfmUzZwzpLNBnx/gRBk48J8VQ9qB
 DgC4Km6GjjwPgKBvBxJT5/Fz+itsOPVALHt/W97eLCTH5h4epVwVW1/kmhFtCBWUfU5eOd+
 RfgNzF2xQocAe0tX+U+ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N9617JHnPZo=:GFKCKkcjtNzn/+SFLtucUG
 aul1eOAf9Bz/2dVbWlAXFTjgxgi3HBff5IMqoq6MOlbz/AUDOTkprwrtVofwIC3xZ/q0uNGNO
 39dwlG/c1Fod721xUh9SSQXYUXQcCXW7+YKw1fEUJcIAFS2Gzhg+hKOIMPFLAAHYKLkCuGCP5
 OpzOlKtw9M683gmf/Te2AmqrEdgW8WeAXjuxbWn2D9ICMRmUhz76uIWwRElHS9mp3a6Mzh9gk
 9hNUBhoaZPG37ekZOdD2/h8ZBtiKYM//02V4cExX7Fygdy5SZiq8zlULycqGJmbY3qGg/0YAH
 mu3GwPjCr0u5mzNGI/FPV6FllDhK7zHF734KYjEs7cqGkTW2SalHfAHzg9SgzQRUP7TEciNLv
 qofDSgy+9UU1D/4ZzampYptJSx7MefQwqC+BsdvGGxynotwbxrecdAsX5EBkDSoBrwYydYrja
 LajehVQWsYwa1xbUGa6TkH7Kpxy1gaPo8JZlpNwvlCLaCHYUvf3Uvb3ovJBzymbfx5OLvsfhS
 G3IufKRTb93/ZSVmlleW2LxaaF1jK5R7X97aCzhzifYRjvbdFqwhYC6oV6rcMQSsDR0fle4Mp
 3e+YzuIlkUDUOMdr7MsHEOfsrg3bTDM2JiMzWP5jZ7pMipM2jnMn7SyqzqQKur+ndjQ7DoGfF
 M06qDijhNJDgNdh/aCTBaRa5BbnZFTh05nVsWg9npD1jFXKhSFgt2gNyiu90fhguaTUV2yGvV
 VBxwikdrgswPxwu5LZ0LxJjou1HXLI3YujrETRNc5W12WvVbwIkSsnBVIMx7fxVu1T1eo7Zv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289117>

Hi Duy,

On Thu, 17 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 17, 2016 at 1:27 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I am much more concerned about concurrent accesses and the communication
> > between the Git processes and the index-helper. Writing to the .pid file
> > sounds very fragile to me, in particular when multiple processes can poke
> > the index-helper in succession and some readers are unaware that the index
> > is being refreshed.
> 
> It's not that bad.

Well, the way I read the code it is possible that:

1. Git process 1 starts, reading the index
2. Git process 2 starts, poking the index-helper
3. The index-helper updates the .pid file (why not set a bit in the shared
   memory?) with a prefix "W"
4. Git process 2 reads the .pid file and waits for the "W" to go away
   (what if index-helper is not fast enough to write the "W"?)
5. Git process 1 access the index, happily oblivious that it is being
   updated and the data is in an inconsistent state

> We should have protection in place to deal with this and fall back to
> reading directly from file when things get suspicious.

I really want to prevent that. I know of use cases where the index weighs
300MB, and falling back to reading it directly *really* hurts.

> But I agree that sending UNIX signals (or PostMessage) is not really
> good communication.

Yeah, I really would like two-way communication instead. Named pipes?
They'd have the advantage that you could use the full path to the index as
identifier.

The way I read the current code, we would actually create a different
shared memory every time the index changes because its checksum is part of
the shared memory's "path"...

Ciao,
Dscho
