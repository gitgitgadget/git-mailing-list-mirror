From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Merging non-git releases of a project
Date: Fri, 9 Oct 2009 18:43:50 -0400
Message-ID: <32541b130910091543x19b3b46an109f90be5c5bfaa2@mail.gmail.com>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com> 
	<32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com> 
	<26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwOFc-0003it-D5
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 00:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934547AbZJIWor convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934454AbZJIWor
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 18:44:47 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38731 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934439AbZJIWoq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 18:44:46 -0400
Received: by yxe17 with SMTP id 17so998416yxe.33
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wUbniwGgh+vsIY8OiQdY6vPjNRJf5XywXCpFsSCacp4=;
        b=jNjJuacZyc1J6nzGQS5fgYfxg49LeTxNLgyF8LyYt+odwDPst4a5tIa1P7cvJYfaPK
         biKawwcuTa+dk1AWbZstVWvDMnnNd9COb3BiIR+SokcFRX77m4VqutdlYFGPOgPgMSM3
         go0ok7wo42fwRccAl7MvR0wOam/CDRJqhyips=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Kmtu5jtgbjVvbB01BVMFNIRyws3prQy5ISPJJW9apYiNfhP65yu4KBi79jBhD1Rpak
         i7/o4UxOy1hEpMGtKCnfQmfJ6fdf4aiCL6uSn2qqEftr01O0q+kNsstDOglj17Yat8Fs
         85GoU0ieYMSIOQohPd/zTYB3NNyJ0gs/I9MDA=
Received: by 10.151.4.5 with SMTP id g5mr5712754ybi.159.1255128250240; Fri, 09 
	Oct 2009 15:44:10 -0700 (PDT)
In-Reply-To: <26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129854>

On Fri, Oct 9, 2009 at 5:33 PM, Howard Miller
<howard@e-learndesign.co.uk> wrote:
> I'm missing the point here though. Where/when =A0do I actually add th=
e
> new pristine code? If I checkout, as you suggest, my initial commit I
> just have (say) v1.0 of the vendor's code. I can't just copy (say)
> version 1.2 on top as the files probably won't match one-one.
>
> Sorry - I'm probably completely failing to understand.

Try this:

   cd mygitproject
   git rm -rf .
   cp -a /tmp/wherever/vendor-1.2/. .
   git add .
   git commit

Don't worry, git won't double-store files that are identical between
the old 1.0 and new 1.2 versions.

Avery
