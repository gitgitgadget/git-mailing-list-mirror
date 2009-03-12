From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Thu, 12 Mar 2009 14:47:24 +0200
Message-ID: <94a0d4530903120547rfbbaccra8ee68498688fa54@mail.gmail.com>
References: <49773240.7090605@drmicha.warpmail.net>
	 <49773E48.90302@drmicha.warpmail.net>
	 <20090121161940.GA20702@coredump.intra.peff.net>
	 <alpine.LNX.1.00.0901211237530.19665@iabervon.org>
	 <20090121191219.GD21686@coredump.intra.peff.net>
	 <20090121191408.GA22958@coredump.intra.peff.net>
	 <alpine.LNX.1.00.0901211443140.19665@iabervon.org>
	 <20090121195348.GB3589@sigill.intra.peff.net>
	 <94a0d4530903120202w22f1f8ecwc6b4d22652afc427@mail.gmail.com>
	 <20090312113908.GA19572@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhkLN-0008BB-EV
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbZCLMr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 08:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754770AbZCLMr2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:47:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:63354 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZCLMr1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:47:27 -0400
Received: by fk-out-0910.google.com with SMTP id f33so77732fkf.5
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lXJ4Kg0IXCRQAQjzNBZv6USze5btw8+mobtazODEjOE=;
        b=twKdt99TvsQqslP127q4GwRHIYbp5/Zn2f0oambDz1eDsZDQWkgKckM5jPWaJ4tcB0
         OaspbBHJ2NLJiikxfzwM3+5B5tfrJqOh4RrKuamb0Sh5fx7O/OYlSsWxC4psObnFQ0lI
         H2XYENutUBnmMvb+hYuwRsqYn/lSNJRxrI55o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rN/lTflNIRSuFCdWF09l9iN1n7jnJHZ4Nw9EC8fr73PjHc/1Gji8AuqD9Szj8xfZBt
         tHEdZBnaWxI9v0GeMbpsgVE+4Gj5UgjNPvs9LuBjDR22dlvaKE4YvmPGot8PjT0TRQTQ
         nqMGem/oiyS6/A2hAqfm6UyT6aKiYpdGz4cKk=
Received: by 10.86.95.8 with SMTP id s8mr6770170fgb.79.1236862044242; Thu, 12 
	Mar 2009 05:47:24 -0700 (PDT)
In-Reply-To: <20090312113908.GA19572@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113060>

On Thu, Mar 12, 2009 at 1:39 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 12, 2009 at 11:02:08AM +0200, Felipe Contreras wrote:
>
>> >> =C2=A0 git remote set-default $foo <name>
>> [...]
>> > I think that would be reasonable behavior (and probably a special =
mode
>> > for set-default to just update from the remote's idea of HEAD).
>>
>> Nobody is working on this, right?
>
> Jay has a number of improvements to "git remote" in next, including
> this. See 104a914 (Merge branch 'js/remote-improvements' into next,
> 2009-03-05). Especially bc14fac (builtin-remote: add set-head
> subcommand, 2009-02-25).

Yes, I looked at that, but set-head will only change the remote HEAD lo=
cally.

--=20
=46elipe Contreras
