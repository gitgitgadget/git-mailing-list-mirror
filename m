From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 17:00:39 -0400
Message-ID: <n2l32541b131005071400uf90ab0e8se882fce6b3abf522@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071529050.14468@xanadu.home> <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com> 
	<alpine.LFD.2.00.1005071626040.14468@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri May 07 23:01:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUfT-0003QM-If
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758234Ab0EGVBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:01:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42237 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab0EGVBA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 17:01:00 -0400
Received: by gyg13 with SMTP id 13so893524gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=o+16j8V6dMDDFy5FP4dpmyx8e7ADP1CfiztvoWiVCF0=;
        b=JU0rZiy1hfy07bExZB7FiBINv/vcXiRqz/v9G4GmQmnFaxxA6aIMntxKMKoq1MWsjM
         A72APrFU/DAUlyGcnok78sbrql5TSXGJ4VKnCh4gpsf1o5faa4FzrHztTqFDPiEtFPCv
         0hbd8I734K4h5XhhXPR0QbUuaK7sGwG/9HPQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MB1ow+CufTVAru4L8rK72HH/E/VqT2Zf9V69L1gjT3d4hLjg2np65hXO53L7QYegf/
         JrjJo0y0Obv6iYnYLMP3HKMjwFARuhVagkiex1Q7ONzSgDkYwqXszOOiAg9ISz+gma0R
         jQYh143fOprt5NqGNZdGqRAEZunJZTERnduy4=
Received: by 10.150.239.1 with SMTP id m1mr3639118ybh.311.1273266059446; Fri, 
	07 May 2010 14:00:59 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 14:00:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071626040.14468@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146598>

On Fri, May 7, 2010 at 4:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 7 May 2010, Avery Pennarun wrote:
>> Since the options it *does* have are exactly the same as .git/config,
>> however, naming it .gitconfig makes sense.
>
> Well, I disagree.
>
>> I'd say just print a
>> warning when reading options that are going to be ignored for security
>> reasons (or because they're not known at all, or whatever).
>
> Or just make it .gitparams (or anything you wish) which is not the same
> as gitconfig. This way it is less likely to get bogus bug reports for
> options that aren't supported.

It has exactly the same syntax as ~/.gitconfig, and the options it
does support can all be carried over literally to ~/.gitconfig.
Calling it something else would imply that it deserves its own man
page, which would need to repeat all the options that are already
documented for ~/.gitconfig.

I'd say something that's syntactically identical, and in some cases
actually interchangeable, should have the same name.  Using a
different name could actually be *misleading*.

Have fun,

Avery
