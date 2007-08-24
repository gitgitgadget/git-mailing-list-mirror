From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Fri, 24 Aug 2007 17:17:42 -0400
Message-ID: <9e4733910708241417l44c55306xaa322afda69c6beb@mail.gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com>
	 <20070824062106.GV27913@spearce.org>
	 <9e4733910708241238n1899f332j4fafbd6d7ccc48b9@mail.gmail.com>
	 <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:17:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOgXL-0003aS-7d
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 23:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbXHXVRn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120AbXHXVRn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 17:17:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:7990 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680AbXHXVRm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 17:17:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so740339rvb
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 14:17:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKUhkV43yNUGcUNKZ4w/+qKz7TckUE4n5PTimiWaCJlr1iR1FhAtMUXNF/pGbnCkM0bGTJadhGEiV3fnXz05L+SvIFBNPrVg6SbZq0ooalRF13fZq8BqVT4j8CbI3Ufc4MT7uMi09vQ9cnVAC6453NP3VEz/5vzD4MRmL0QVJGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JPjSY4IP96uSQPtJPoNE3m+WzGgb7EV4+hdLTMEWaMbJT9UBLw3U01/pZE/z9GlvuaXuVw9R1zZSWBiCCAu/vWSW6FtGt4mR6nBaCpsVuREDEbiMDQkhXIEMXOfZ03a6mw6ByibVHMkkpYqsl6iTOOo8+bO1RBQIgiRQ92pYL/0=
Received: by 10.114.177.1 with SMTP id z1mr131307wae.1187990262319;
        Fri, 24 Aug 2007 14:17:42 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Fri, 24 Aug 2007 14:17:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708241618070.16727@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56602>

On 8/24/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 24 Aug 2007, Jon Smirl wrote:
>
> > I'm still trying to debug git-daemon
> >
> > I do find it surprising that git-index-pack can't be happy with in
> > 20MB of RAM and it has to continuously swap it's 30MB of virtual. My
> > disk is chattering itself to death. It stayed that way for 40 minutes.
> >
> > I'm practicing on the kernel tree.
>
> You hope for miracles, do you?  ;-)

We're going something wrong in git-daemon. I can clone the tree in
five minutes using the http protocol. Using the git protocol would
take 24hrs if I let it finish.


> Please stop hammering that poor little NSLU2 with such a workset, or
> hack some additional 224MB of RAM into it.  There is no magical
> solution.
>
>
> Nicolas
>


-- 
Jon Smirl
jonsmirl@gmail.com
