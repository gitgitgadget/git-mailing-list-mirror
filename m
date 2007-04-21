From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Sat, 21 Apr 2007 09:37:49 +0000
Message-ID: <b0943d9e0704210237k1d91a5a9tc3a5aa54d5a8772e@mail.gmail.com>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
	 <4625DDA5.60503@vilain.net>
	 <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk>
	 <200704182219.26410.robin.rosenberg.lists@dewire.com>
	 <20070418203502.GA8524@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070419085924.GA21936@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Sam Vilain" <sam@vilain.net>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 11:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfC2V-00086d-0X
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 11:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXDUJhw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Apr 2007 05:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbXDUJhw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 05:37:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59538 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbXDUJhv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2007 05:37:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1069707uga
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 02:37:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qt+W8skucqoFKHDykEBFmJFh7r3QgOrxwLnJ7jlj/UAp4SzVBpqW3sitO7IxZsVkyNwRRxokqBKljwle2+kiizCKZIUV03rIHl10YwX4Nso9fpQB1uh3w0C1285KQLEt2v2JXzDmp81CqwVOuRRGIygd8CErGVuiWh55ne8DbWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PMRb2+nbYsyVyvSTK1r2xQRd/XeA3XOi1VcmARdiUsa+0xUYFehyZWfHec6rVcQKOqXRhWtmHaqioN5G7y1i0U7MpuhfV3I15rdtS9KGYEfr1vTL4f9tRzqjp1a5J+SQkdY4SusixHGell2dlQJMvhk1eE0Ph273TmBxxg1+f8M=
Received: by 10.67.19.17 with SMTP id w17mr3512367ugi.1177148270013;
        Sat, 21 Apr 2007 02:37:50 -0700 (PDT)
Received: by 10.66.255.4 with HTTP; Sat, 21 Apr 2007 02:37:49 -0700 (PDT)
In-Reply-To: <20070419085924.GA21936@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45158>

On 19/04/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-04-18 22:35:02 +0200, Yann Dirson wrote:
>
> > But if the consensus is that "sink" or something else sounds better=
,
> > I have myself no objection to bury "bury" :)
>
> I think that "sink" is by far the best word for it, especially when
> paired with "float". (The only problem is that "stg series" prints th=
e
> stack with the bottom on top and the top at the bottom, but that's ol=
d
> weirdness. :-)

That's coming from quilt, I didn't spend much time on designing the
user interface (this is something to be done post 1.0). However, on
the CPUs I work the stack grows downwards but the top/bottom naming is
the opposite of StGIT one.

--=20
Catalin
