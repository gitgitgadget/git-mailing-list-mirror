From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 14:00:28 -0700
Message-ID: <CAE1pOi0_ETdSYsuT0Udhbr6rDvmEcuTA157d6aKUosgi7w28jw@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:00:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKBW-0003Ss-PT
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591Ab2EAVAa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 17:00:30 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:57830 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab2EAVA3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 17:00:29 -0400
Received: by qabj40 with SMTP id j40so3507791qab.1
        for <git@vger.kernel.org>; Tue, 01 May 2012 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=w9IiPAL4Hy9feqhIFYResRr4X7bwjRNWCL3PLm3ZD6Q=;
        b=UZNigC0gijlvvM8/E/eNZoV5J6dz8wsj5po258nQBs+20QbTFiT/uYF9kkI5vQik6V
         Det/bVBEOKnZsqJZfLU2949GadHKVBLJUFoBNDs02Niajw11snVWlXPJnijrTkFRFgme
         phqdHDTBBLMlF6AwV8u3EzcyLeAH9CVP3Y6PD0jhWjv8I7TK916Q3YklS65FteAhdF20
         02fsrmfStH2buw9BWvsp1WBvuPO7IlaLVyfVdM5IkB71PKgMj4xj9HjzZLjZqVAzBlJq
         vcLYAZv1QZ/6E+CX3iF6bhrlJBKDZQVINjn5foPtsVVfVB86pUyyfU+ykOEs37KHDrQm
         wz9Q==
Received: by 10.224.200.198 with SMTP id ex6mr22623396qab.63.1335906028918;
 Tue, 01 May 2012 14:00:28 -0700 (PDT)
Received: by 10.229.228.20 with HTTP; Tue, 1 May 2012 14:00:28 -0700 (PDT)
In-Reply-To: <7vipgf8wve.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196747>

On 1 May 2012 13:33, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> Is there any way to get (some of) the Git hooks to run for everyone
>> without everyone having to install them separately? If no, is this b=
y
>> design or simply a feature nobody has asked for (yet)?
>
> By design. =C2=A0Do you want me to include "rm -fr ~hilco" in some ho=
ok of
> git.git repository?

Mmm, well, I might get quite famous if you did... ;-)

But if you wanted to be evil then you could easily find another place
(the build scripts, the code itself, et cetera). So I don't think this
is a good argument. Moreover, I do not work with people that would
ever consider such nastiness. You need to realize that this is all
closed source. Your argument would be more valid in an open source
environment (like git.git).

So let's just say that I'm stubborn or I like living on the edge. :-)
Is there any way to have the hooks run for everyone?
