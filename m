From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local changes
Date: Wed, 7 Apr 2010 12:48:29 -0400
Message-ID: <r2l32541b131004070948o92575f5j4728764482e8a262@mail.gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com> 
	<20100406233601.GA27533@progeny.tock> <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com> 
	<20100407004353.GA11346@progeny.tock> <4BBBEC43.5000100@gmail.com> 
	<7vfx37g6f6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitzilla@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 18:49:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzYR1-0006hU-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 18:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062Ab0DGQsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 12:48:54 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:36673 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399Ab0DGQsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 12:48:53 -0400
Received: by ywh2 with SMTP id 2so658554ywh.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=3iELcRrgbMUiiTQjqn+gIztqGz3xBsbZF7mtndH4LuY=;
        b=tdPhXbBiXEACXxwDG6Dv8+36b1YMu98wziFXF04gWPlQPmLyu1P/aWngh2QmsCSbiE
         7rEXN1o8sdcdIsE5NIvOLrFdkuXQFZGYubP2TwYimAoAkS9qHHDl/M5+3pBxYgmNGa3f
         zeL45/LU3sftapJecOmvnf8U9zNspnH5lwvLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Vu185NcA1Hfqn/lg+WtSe1/NG+m2ZOdRe8znndF3+3vgMRY9H0IiHVySRt81/Z1fIh
         unbzBugV9aYjsuBn/hdqokMCccngTUlpvizX5jE76et8dpQY64SKuumpZ5RtZGJE8QPL
         +UV5PWEtYtNoxGEOkLG/sQ1T+xotdGKlUfbrA=
Received: by 10.150.150.20 with HTTP; Wed, 7 Apr 2010 09:48:29 -0700 (PDT)
In-Reply-To: <7vfx37g6f6.fsf@alter.siamese.dyndns.org>
Received: by 10.150.254.13 with SMTP id b13mr4998042ybi.152.1270658930698; 
	Wed, 07 Apr 2010 09:48:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144248>

On Wed, Apr 7, 2010 at 1:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
>> NAK - gitk should not modify a repository and/or working dir unless
>> _explicitly_ prompted to by the user.
>
> I used to think that way, until I realized that gitk has operations like
> "Tag this commit" that does write into the repository.

Also 'git status' does the same "modify a repository" operation as
we're currently discussing, so calling it modification is a bit of an
exaggeration.

Avery
