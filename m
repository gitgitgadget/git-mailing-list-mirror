From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git submodules
Date: Sun, 17 Aug 2008 18:54:51 -0400
Message-ID: <32541b130808171554o2b2f33d5q43d3bd517ed85e06@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
	 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
	 <20080728205545.GB10409@artemis.madism.org>
	 <20080728205923.GC10409@artemis.madism.org>
	 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
	 <20080728220308.GF10409@artemis.madism.org>
	 <m3r69dtzm9.fsf@localhost.localdomain>
	 <7vfxptpr76.fsf@gitster.siamese.dyndns.org>
	 <20080817201336.GA17148@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 00:55:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUrAD-0004kP-1s
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 00:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYHQWyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 18:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYHQWyy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 18:54:54 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:49734 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYHQWyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 18:54:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so194498ywe.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eO4lmvmPdCOQ1n5XXFfcj14MIEKCIfqK0dJ1Mrxjns4=;
        b=ol+EsjUHyPOKRGShDYUpgD8NN9x27PuVH787aLqFcAcPLaKrlD23iRgXfU0AMgucf4
         gBGqh18CmFu9Eb0VdrZIHPQtlr9cHiMXe888FYhsckYzPdFPqqdEq8C5YM9afiGvSJOf
         +RUu7B5Cp50ahMp3ApOYsFjCXqs1YoehR5TjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NXxG2twLYSxxeQbMhBLAZQGN2kaIhxx4DtrieleuHRPNBQu3UWUoQelj9tAAipxhlq
         I+lwnXqlw5ymn0eZ2sks8r2w2D6tPun6sChhhqbExqv6wCTdfXB6wIae4ncTD9MK0doJ
         PmTVepnNh1SX+ZffQjM3iPVvLkPGjq420od6k=
Received: by 10.150.202.9 with SMTP id z9mr8481644ybf.205.1219013692075;
        Sun, 17 Aug 2008 15:54:52 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sun, 17 Aug 2008 15:54:51 -0700 (PDT)
In-Reply-To: <20080817201336.GA17148@artemis>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92668>

On Sun, Aug 17, 2008 at 4:13 PM, Pierre Habouzit <madcoder@debian.org> wrote:
>  * It could make things like git-blame better: at work, it's common for
>    us to move files across submodules: we have a stable library shared
>    accross projects, and move there C modules that have staged for
>    quite some time in the applications and are stable enough, and it's
>    pity to loose history then, whereas git could really guess about the
>    move if it sees through GITLINKS in the same object repository.
>    GITLINKS are not very different from trees actually if you can look
>    through them, it's just a matter of dereferencing twice instead of
>    once.

That would be cool.  I expect you could implement it independently of
everything else by simply *trying* to dereference gitlinks in the
local object repository if they exist, and not erroring out if they
don't.

The other reasons for combining the repos seem fine, but they mostly
seem to come down to saving disk space.  I like saving disk space, but
it's not really that important to me.

Have fun,

Avery
