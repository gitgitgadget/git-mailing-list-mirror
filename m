From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 18:19:35 -0600
Message-ID: <i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<384AA932-227B-43B0-9D38-560A3567918A@gmail.com> <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org> 
	<m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com> 
	<alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071504280.901@i5.linux-foundation.org> 
	<h2q32541b131005071534r22cc2092t2a21bfad6d4bfd81@mail.gmail.com> 
	<alpine.LFD.2.00.1005071601470.901@i5.linux-foundation.org> 
	<q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com> 
	<alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 02:20:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAXmQ-0007b2-Gs
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 02:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0EHAT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 20:19:56 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:44157 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0EHAT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 20:19:56 -0400
Received: by yxe1 with SMTP id 1so1158498yxe.33
        for <git@vger.kernel.org>; Fri, 07 May 2010 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=gTJ0sEWF8OOkfOnzz/a5XW2Wc/X9vAkaWXrIIjCkJHI=;
        b=P1fwIh55f8WleJgxb7uX69bxLfuTjaR2+cn1p2i6CVnz+k8Cw7hEznxu2dfL8Qo643
         NeHheYAMv1Zn0stE82hRqsZVqzaSffnqEQ3VMGGOhEtRd67iOR2iUjddZVC+1El0a3uN
         t8Dwj6nGmXf5+oQuE6BEq2zOMt32Om26iSLDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QR/SFCc5dNRFXGqHJf+L4w64pG097jq5xZ7LaLwaqpQ59qN/GYMZ2LImruS3qfDgZW
         hYcOuD9SBEXZMmGE34u2MiexIO1pex43+/uDTkmg/xtLIOrQKQgZflwvOq4Capp0Taai
         KMF3/n++vG0PnvhM1WzDjU4OqKbBLx5o63/Gw=
Received: by 10.91.50.40 with SMTP id c40mr840761agk.23.1273277995125; Fri, 07 
	May 2010 17:19:55 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Fri, 7 May 2010 17:19:35 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146622>

On 7 May 2010 17:50, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 7 May 2010, hasen j wrote:
>
>> >
>> > The only reason to ever support 'lf' is
>> > if you're a total moron of a SCM, and you save files you know are text in
>> > CRLF format internally. That's just f*cking stupid.
>> >
>>
>> What if:
>>
>> - The entire history of the file is stored in CRLF
>> - It's a windows-only file where the official "tool" that reads it
>> barfs on LF line endings.
>> - Third party tools also expect (or at least, handle) CRLF line endings.
>
> Umm. Then it's not text, is it? What you are describing is a binary file
> that happens to look like text with CRLF.

That depends on your definition of text.

Storing it with LF internally is ok, as long as we can have it
*always* be checked out as crlf.

> If it's _text_, then you import it as such, and set crlf=true so that it
> gets checked out with crlf.

It should be the repository maintainer's responsibility to tell git to
always checkout that file with crlf.

Why?

Because it's part of the project. I never set crlf=true on windows,
but if some files just *have* to have crlf, then I wouldn't mind
having them that way.
This doesn't mean I should have to pollute all my files with crlf just
to please visual studio, or whatever tool requires the crlf endings.

Other developers (specially those new to git) shouldn't have to worry
about crlf issues: when they clone, git would automatically convert
some files to crlf on checkout, regardless of whether or not they set
crlf=true.

git currently has it backward: putting the onus on each individual
contributer to set autocrlf=true

This doesn't make any sense.

If someone did want everything to be crlf, sure, they can set crlf=true.

But there's another potential problem: what if some files just *can't*
have crlf? Say some build (or whatever) tool barfs on crlf files, and
the user sets crlf=true because that's his preferred eol style, but
the project has one of those lf-only files? In this case, we'd want
that file to be always checked out with LF, even if crlf=true is set.
