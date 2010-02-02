From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 18:48:13 -0500
Message-ID: <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 03 00:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSTk-0006S9-0A
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab0BBXsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:48:15 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:43935 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0BBXsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:48:14 -0500
Received: by iwn39 with SMTP id 39so831628iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Ht25ISpdvCX7b3sc9zUge7SYc2+XlpfPgkD3vK4nOTo=;
        b=NEjbPicq3bmzNYl9fUjSbaAnOfgzwdSimOiuMU8CIlHNUiVsslauFlErjTIxBLjkXM
         cxrPIhv/TNT9G/AN2s5Zfr/OM9NFRA/VO91gguZtwtpp8QBNwiWTT8upDo01XvkVHBrF
         nXmyu53s23Aj0xof3A8NguMw1+4szB54IH1NI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bbrm9QTabS2abcd29kdgAmSrcqB7fSp8nH1SniobUq9aP6w1G/mMKeV4YPlbaEWPLU
         91rO6KYU6J8ULHXyAK1pjmHsEidFPbsnB9JcNEC3buW9HujdnNcuVyxfFWLy67Sh7qFn
         m0e2FID2xuUkHbGwhbt5Lz3S6VmOpIZYUke2o=
Received: by 10.231.162.9 with SMTP id t9mr4026495ibx.5.1265154493530; Tue, 02 
	Feb 2010 15:48:13 -0800 (PST)
In-Reply-To: <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138787>

>
> This is where you're wrong. The reason why commit (without --amend) is
> aborting when you don't save is that the default commit message is
> empty, not that it wasn't saved. In fact, just saving still makes in
> abort. You need to add something to the commit message and then save
> to get it to perform the commit.
>
>> Same should be applied to rebase -i and of course to commit --amend as
>> it is still commit operation.
>>
>
> "rebase -i" and "commit --amend" already has the exact same logic as
> commit without ammend in this regard - they abort if the buffer is
> empty.
>
> --
> Erik "kusma" Faye-Lund
>

Thank you, but I'm not wrong, as i described the exact same thing
somewhere in my second or third message, without even knowing the
implementation details. I understand the reason WHY it is like it is,
i just don't like it as it is inconsistent and IMHO incorrect.

Thanks,
Eugene
