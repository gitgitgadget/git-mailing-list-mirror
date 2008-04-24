From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-gc doesn't clean up leftover objects after git-filter-branch unless you clone first
Date: Thu, 24 Apr 2008 11:43:55 -0400
Message-ID: <32541b130804240843k471ecfeteb1008c44a56808b@mail.gmail.com>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
	 <7vve28sdys.fsf@gitster.siamese.dyndns.org>
	 <20080423221316.GE30057@sigill.intra.peff.net>
	 <20080424012836.GA30812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 24 17:45:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp3d3-0001uG-PO
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 17:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764012AbYDXPoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 11:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764000AbYDXPn7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 11:43:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27110 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763961AbYDXPn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 11:43:57 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3124328fgb.17
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ceXEUI6EHSvD+zJxUXhM1/S/Yv146lp7lsvrSO2tX88=;
        b=N+L1B/Oxd0VccKDY8a1qhxKrTcki9eoL4Ozql4TcPDX8p2fNJ1ak5Nk1VU6/PO8cJpdBu9nmha/K2u8XUr20z5fW/kszTz9wQInoS7UJz+O3jwlYGxbYNYPrnNww4/qVtWi33EU8LtEcAB139o/bqP5jRau1I4kMfK627o7s8KI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I+S0rGfi+gF6cSHStmPTZLRtx5+/MmrbXWSxHPIO8hDWsl7CHpyU7R3N/OeJMeKGYd3Vtu2hzRlTXAwSaJWLteYSMbd5LqrfFL2lWRoAbhNBK76JcNyjYxBw8sGDfnr49/fByU66YEYbTRsiHZ+odzPeJ2tiOAji/g3h8dMI3Kc=
Received: by 10.82.150.20 with SMTP id x20mr2567511bud.18.1209051835158;
        Thu, 24 Apr 2008 08:43:55 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Thu, 24 Apr 2008 08:43:55 -0700 (PDT)
In-Reply-To: <20080424012836.GA30812@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80306>

On 4/23/08, Jeff King <peff@peff.net> wrote:
>  +
>  +Notes
>  +-----
>  +
>  +git-gc tries very hard to be safe about the garbage it collects. In
>  +particular, it will keep not only objects referenced by your current set
>  +of branches and tags, but also objects referenced by the index, remote
>  +tracking branches, refs saved by linkgit:git-filter-branch[1] in
>  +refs/original/, or reflogs (which may references commits in branches
>  +that were later amended or rewound).
>  +
>  +If you are expecting some objects to be collected and it isn't, check
>  +all of those locations and decide whether it makes sense in your case to
>  +remove those references.
>  +

This information would have helped me quite a bit when I first
encountered this problem.  It would be nice if it also showed up under
git-prune (since git-gc doesn't delete anything itself, if I
understand correctly).  Also a link to some information about reflogs
(even just to "see also" git-reflog) would help, since I didn't hear
about reflogs at all until after I joined the mailing list.

Avery
