From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Sat, 19 Jul 2008 01:02:35 +0800
Message-ID: <46dff0320807181002i33320669ica5e407adc30d8b6@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
	 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
	 <7vabghr5br.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
	 <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtMo-00083S-2S
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbYGRRCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756208AbYGRRCj
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:02:39 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:8797 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776AbYGRRCi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:02:38 -0400
Received: by qw-out-2122.google.com with SMTP id 3so175877qwe.37
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Nf6hcH5ip0B0HSx9azsMeDq8T/Wpq+UnCcfQvdeG92k=;
        b=UEQPl0aG8hTduvcE4CjcAaZP1Ioo6iuGPpsHPKqHjlE4rGAXIq4QfN0iWcJztJjdan
         fB+eA/QdYozLyoNid2bMtKrj38FEDPuHBw3NGB45w1MO6/Y4y0RYzsDcoaJuSgkWhzGe
         W+G/NSrU3lXe2cY8732zRiwoh6irdys5PusJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fFInEfMxXtdW13hBj8R86rrICUfKxDMN2hl8Ip0HmPC6YiYM6yzMrJqK35/Ge3VfQG
         l/3036U1SuvrFg5ID2BmDRm9r9za6/eNRpKOdDbCNKwAL4tPPZ5tbv0YORWvjfyFQ4o2
         0TSIatBJkIYcHO/GIyXW+M7K7sZ9NCONV2qfQ=
Received: by 10.150.49.1 with SMTP id w1mr455708ybw.24.1216400555791;
        Fri, 18 Jul 2008 10:02:35 -0700 (PDT)
Received: by 10.151.114.1 with HTTP; Fri, 18 Jul 2008 10:02:35 -0700 (PDT)
In-Reply-To: <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89055>

On Thu, Jul 17, 2008 at 4:12 AM, Junio C Hamano <gitster@pobox.com> wrote:

> Suppose you are about to finish something you have been cooking (say a
> series of five logical commits), you've made three of these commits
> already, and what you have in your work tree and the index is to be split
> into the last two commits.  Somehow you learn that $x above has a updated
> version.
>
> Yes, running "git stash && git pull --rebase && git stash pop" would be
> better than running "git pull --rebase" alone from that state.  But that
> would mean your history would have your first 3 commits (of 5 commit
> series), somebody else's totally unrelated commits, and then you will work
> on finishing the remaining 2 commits on top of it.

Hmm, the first 3 commits are not pushed out, right? So by "rebase",
the history should be first the somebody else's commits
(origin/master), then the first 3 commits, then the remaining 2
commits?:


-- 
Ping Yin
