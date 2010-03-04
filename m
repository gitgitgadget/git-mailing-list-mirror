From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What should "git submodule summary" give before an initial 
	commit?
Date: Thu, 4 Mar 2010 07:48:10 +0100
Message-ID: <fabb9a1e1003032248w4fb290capf1e45ed16a1ea0c4@mail.gmail.com>
References: <4B8E5450.3040702@gmail.com> <20100303204257.GA5501@coredump.intra.peff.net> 
	<7v3a0hktga.fsf@alter.siamese.dyndns.org> <7vzl2phz8e.fsf@alter.siamese.dyndns.org> 
	<7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org> <4B8F00AA.5050007@web.de> 
	<fabb9a1e1003032201l38b052ebk4c0061e9d40f68b6@mail.gmail.com> 
	<7vfx4gfvwv.fsf@alter.siamese.dyndns.org> <fabb9a1e1003032236x59a781b8ne0266877db25d001@mail.gmail.com> 
	<7vvddcd1si.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Ping Yin <pkufranky@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 07:48:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn4rM-00047u-7o
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 07:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab0CDGsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 01:48:31 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33949 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab0CDGsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 01:48:30 -0500
Received: by pwj8 with SMTP id 8so1458278pwj.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 22:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ZqMaIuDyUjMkRDJZWDRi0vc6/JsNTF1ghbryONrTI0w=;
        b=rtLN4XSdopT6I8YE2AQOekTLkAPpaQGzlkn+a27Y/3IT0nFssW9XFjiKR5qdyYGmak
         Aspz8vFn4Mvs26lPTxadfEJX9FUiyO7K8/Vzm8IRLE0VybTJ93oXbk987Go4YC4JqIA8
         /QCcSApn+XgXKCN0Jvs5izTR3+H4Y2oYQSPZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U7UYi43ud+Nbf0SNqtIrAGdmanUMAWudIX24UNGwcYRSzGhfn6X//8Cx4kFry4AeXb
         7Y+6gKeTCUE9aGlgyFAR8jhDSScRGdQb1GI+c6nkrSwc37Z13AHJ6OKfGdXD7+t68ywu
         3QvCiNw5Mv6wapI6esM/PotS0b1pyOzIyhwyw=
Received: by 10.142.151.14 with SMTP id y14mr1731461wfd.34.1267685310106; Wed, 
	03 Mar 2010 22:48:30 -0800 (PST)
In-Reply-To: <7vvddcd1si.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141513>

Heya,

On Thu, Mar 4, 2010 at 07:43, Junio C Hamano <gitster@pobox.com> wrote:
> I doubt it would be very much useful as a general feature, as sometimes we
> default to HEAD because we want a tree-ish (in which case using "empty
> tree" would be appropriate) and other times because we want an actual
> commit (e.g. "git commit --amend" should exit, not "amend an empty tree")
> and we would need to be careful to study each codepath and use the
> appropriate one.

Yes, I think if we add such a "default to HEAD or empty tree" option
to parse_opt we shouldn't just plug it in anywhere we default to HEAD.

> But you are welcome to try and prove me wrong with a working patch ;-).

Ah, I was hoping perhaps one of our still-in-hiding prospective gsoc
students might feel up to the task, I am short on free time lately (I
barely have enough time for Melange), the little git time I do have is
spent on adding write support to git-remote-hg. So! To all you people
that want to be a gsoc student for git, now's your "opportune moment"
to impress us ;).

-- 
Cheers,

Sverre Rabbelier
