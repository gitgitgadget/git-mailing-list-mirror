From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 19:25:58 +1300
Message-ID: <46a038f90510232325y8fbea09g19bae8c95f5a7aa0@mail.gmail.com>
References: <4358597A.6000306@catalyst.net.nz>
	 <200510231533.j9NFXhOv019272@inti.inf.utfsm.cl>
	 <20051023224022.GX30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:27:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETvnN-0002qw-Ar
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 08:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVJXG0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 02:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVJXG0A
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 02:26:00 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:51978 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751013AbVJXGZ7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 02:25:59 -0400
Received: by qproxy.gmail.com with SMTP id m21so303105qbe
        for <git@vger.kernel.org>; Sun, 23 Oct 2005 23:25:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TvTuJX16/O0WMmqrZujnCK19TgQySlpMl5ZQ1kiZECJHEMvsmpgGW+kPXGLnXt80W3z1zIUUwT0/6QRM4pPLl4TNg+SUwuR978vLtmQA5n89OSTTFjiex9W9l8k35rmH4u0mfw4IdnCBCEZYBCHiZlWNIrgYvUL5kU89L4Wtwzs=
Received: by 10.65.22.20 with SMTP id z20mr2673724qbi;
        Sun, 23 Oct 2005 23:25:58 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Sun, 23 Oct 2005 23:25:58 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051023224022.GX30889@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10530>

On 10/24/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sun, Oct 23, 2005 at 05:33:43PM CEST, I got a letter
> where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> > Martin Langhoff (CatalystIT) <martin@catalyst.net.nz> wrote:
> > [...]
> > >     MERGE ERROR: : Not handling case  ->  ->
> >
> > It happens when a new file with the same name appears in both parents. For
> > example, we both see the need for a README file, and then I pull from you
> > and try to merge into my version.
>
> It certainly shouldn't happen with precisely that error message - there
> should be at least something written between the arrows. And yes, there
> are unhandled cases like that, as I wrote in one of my other mails.

As I painfully discovered later, I had updated my tree at the wrong
time, and got caught with a cg-Xmerge.sh that had lost all its
parameters over the numbered params/named params transition. I got a
fresh checkout, rebased my local patches, and life is good again.

Sorry about the noise!


martin
