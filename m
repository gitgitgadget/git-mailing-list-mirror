From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH 0/6 rebase-version] Make git log --graph looks better with 
	-p and other diff options
Date: Tue, 25 May 2010 17:31:23 +0800
Message-ID: <AANLkTim9pDdz-VU8mGsoEaiv81RepaZT29h_5iAOo4bx@mail.gmail.com>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
	 <20100525092336.GB30863@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 11:31:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGqTy-0002fL-Hy
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab0EYJbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 05:31:25 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:43497 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab0EYJbY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 05:31:24 -0400
Received: by qyk13 with SMTP id 13so6951069qyk.1
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B0YAh36WEmPY5gE7spSB87H/h1dZw0j5HOfDqWH8Orc=;
        b=Hekts033RNSVyXUFXE3Kal/2CCkbc7UdQyXG9MRXlD7lMP0JkkGPB9GhLR0jBPhQWf
         3PBfconUs55deKPxPiTB43lxnGsqSEztZ4/38bfreCIzUfXHjHoBIHdQYLUUypXoVXXw
         7EqsaSUHNeEX6ppKBno1EFED1ICuuRZjMms+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hw8FqFa5jfZySBxR/I8dxL/Ui6VXbFb59hqNdd6zOShNhSxWgcSp+ytQ5QjOD7JKsq
         4+lUtaXRPc6s3afi1I6/z/+chYRjeuJ7eX9rkxUwVqJpR+ej2mCn+ITEUBaToXVgfGaq
         q7uQuiCQFfZPq9QHleoas+uKMRb8Xu1UPgWKo=
Received: by 10.224.45.16 with SMTP id c16mr3798851qaf.144.1274779883889; Tue, 
	25 May 2010 02:31:23 -0700 (PDT)
Received: by 10.229.110.18 with HTTP; Tue, 25 May 2010 02:31:23 -0700 (PDT)
In-Reply-To: <20100525092336.GB30863@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147700>

On Tue, May 25, 2010 at 5:23 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 25, 2010 at 05:02:28PM +0800, Bo Yang wrote:
>
>> From: byang <byang@byang-laptop.(none)>
>>
>> Rebase for a new master...
>>
>> Bo Yang (6):
>> =A0 Add a prefix output callback to diff output.
>> =A0 Output the graph columns at the end of the commit message.
>> =A0 diff.c: Output the text graph padding before each diff line.
>
> These patches look fine to me.
>
>> =A0 Emit a whole line once a time.
>
> I have to admit I don't quite understand from the commit message what
> the problem is that this is fixing.

Ah, the previous code just call a emit_line for parts of the line, and
this commit change this behavior. It firstly compose the different
parts into one line and only call a emit_line. This is necessary
because each time we call emit_line, there will be a graph prefix
output. :)

>> =A0 Register a callback for graph output.
>
> This one looks fine.
>
>> =A0 Make --color-words work well with --graph.
>
> Your explanation of the rules for when to output sounds sensible to m=
e,
> but I'm not familiar enough with the color-words code to evaluate it
> (and I lack the time and sleep to look at it more carefully tonight).

=46eel free to give me advice any time when you have some. :)

Regards!
Bo
--=20
My blog: http://blog.morebits.org
