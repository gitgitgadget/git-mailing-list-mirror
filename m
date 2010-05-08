From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 23:45:39 -0400
Message-ID: <k2q32541b131005072045jc1192392ke234b7b543aaca33@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org> 
	<q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com> 
	<alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org> 
	<i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com> 
	<alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org> 
	<i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com> 
	<alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org> 
	<g2h600158c31005071949ve3397f18j3c38017be32dd591@mail.gmail.com> 
	<AANLkTikbIHfX5pUOn2Yk44IWzqTFDpyapC1V-C-br9jF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, kusmabite@googlemail.com,
	prohaska@zib.de
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 05:54:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAb7e-0004Jl-Ef
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 05:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab0EHDqE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 23:46:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45381 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab0EHDqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 23:46:03 -0400
Received: by gwj19 with SMTP id 19so1049929gwj.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bV4gmbiMmown2IuG66MUWBI6VU3xQwaK3CUrCHHqDHo=;
        b=gPdFavohSRpqZtsl2daNaiBCl1qE0dcVESiD4DW6zCJ8JKVzLtXmrkEBYjy4QHuZ41
         YhmC6xZGpgIrU44xc9IRup98DBryrRsZw6S9tnFy+BAl5Qqm1wKN3zSk1Kz+GnxB7+JN
         5oUANCQDg5AbBRHyNPb7h7+WpOuRtXnzxGpIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mqKJLkuJ4sdkEBuZwKyczTLy19IWyfmm69WId4o1UO+HtaGx6PLT7qCmTvK6sf4atk
         ignIfNYKDXWKb8pAx0cCl0sFy9Nash4hMsp2qBGbR4AqX5cZwIi0rQwMQQG2z/Qw67oU
         1O8m07p4gcQnAGaZPz8sjPUDQIg+SsTeN/uEk=
Received: by 10.150.160.17 with SMTP id i17mr2764876ybe.399.1273290360503; 
	Fri, 07 May 2010 20:46:00 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 20:45:39 -0700 (PDT)
In-Reply-To: <AANLkTikbIHfX5pUOn2Yk44IWzqTFDpyapC1V-C-br9jF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146631>

On Fri, May 7, 2010 at 11:31 PM, Robert Buck <buck.robert.j@gmail.com> =
wrote:
> Actually, Linus, that depends. And while you will recognize this, let
> me state the obvious, that there are cases where for certain text
> files the platform does not matter, that for all platforms they MUST
> normalize to one setting. For instance there are cases where text
> files MUST be LF ended on ALL platforms. Have you considered XML to b=
e
> one such example? The W3 XML spec states:
>
> =A0 ... [XML processors] MUST behave as if it normalized all line
> breaks in external parsed entities (including the document entity) on
> input, before parsing, by translating both the two-character sequence
> #xD #xA and any #xD that is not followed by #xA to a single #xA
> character.

Erm, this seems to be a counterexample to your point.  It says very
clearly that the files can use either LF or CRLF line endings, and
will be parsed correctly either way, or your parser is broken.  So
pretty much any CRLF conversion rule (or none at all) will work with
such files.

Hasen wrote:
>> The way git handles crlf is just confusing; in fact it's so confusin=
g
>> that it's often better to just turn it off.

True.  This discussion is about fixing that, though, so it seems
unnecessary to make that point.

> Hasen makes a good point here. It is simply this, the LF issue does
> not boil down to a single boolean switch. People who think of the
> LF/CRLF issue as a boolean switch are not dealing with all the facts.
> There's a lot of grey, not simply black and white.

How on earth is anyone suggesting that it's a simple boolean switch?
Linus posted an 8-cell truth table earlier, and he hadn't even
included all the cases.

> I'd generally say,
>
> * perform conversions, or no conversions as the case may be, on the
> obvious file types
> * when conversions occur, normalize internally to only one convention
> * otherwise perform no conversions

Unfortunately those steps aren't clear enough to be helpful.  "as the
case may be" and "obvious file types" are definitely not obvious, or
we wouldn't be here.

> Confusion, yes. The Git documentation is very confusing on this
> point... Linus and Junio may want to lift a page from the Perforce
> book ;)

I've learned that git people never learn from anyone's book.  svn has
also had this problem solved pretty much forever, and would be easy to
copy.  For better or for worse, it all has to be hashed out from
scratch or it won't happen.

> It would seem to me there are some text files that by convention MUST
> have LF regardless of the platform, and there are examples of text
> files that MAY have CRLF depending upon the platform.

Well... obviously.  The former case is crlf=3Dfalse; the latter is
crlf=3Dtrue.  To bring up my point again about the confusing
configuration options, you might think that "crlf=3Dtrue" means "always
CRLF", but in fact that's not the case.  In fact it works the way you
want.

Have fun,

Avery
