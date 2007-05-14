From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: RFH for [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Mon, 14 May 2007 18:40:05 +1200
Message-ID: <46a038f90705132340o4006d2f1gbad841144a4c8054@mail.gmail.com>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
	 <7vd519m9z7.fsf@assigned-by-dhcp.cox.net>
	 <7vps54qvya.fsf_-_@assigned-by-dhcp.cox.net>
	 <200705132351.24867.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Steffen Prohaska" <prohaska@zib.de>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon May 14 08:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnUEB-0003DX-L0
	for gcvg-git@gmane.org; Mon, 14 May 2007 08:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbXENGkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 02:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbXENGkH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 02:40:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:60481 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbXENGkF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 02:40:05 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1481247wxd
        for <git@vger.kernel.org>; Sun, 13 May 2007 23:40:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BipXVWIZ4ilyRcIUcPf0C3mtAFmP5LvEd6Z5tpbvqoFhvZo7eXIkE8+khHhsAg8s8z6mY3p8Htfa751rCg4klIhcwoiTFvMLzQMC5KfTi4RkuTVucbShelAVBJz2tD+rMWBLV/JsWLu3cWZEQ98isXeMq12Vl4vHFzrdj6L/DQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HYa7rdLJanBA6WccpYo1stoNiJLTeu44n9XPuesANULrw2sXUqBErqqs+fEoiFRT3OMT52NCH3hk59XDZHp102MtdXIIZAAd52EBjtHr1LOVGOaG0I/vQP+s7Q9KYJvdEEIvyoEoPjk+zN2k9khh3w4MWm+8H8aL7oLh+GT+IjE=
Received: by 10.90.90.16 with SMTP id n16mr4365249agb.1179124805379;
        Sun, 13 May 2007 23:40:05 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Sun, 13 May 2007 23:40:05 -0700 (PDT)
In-Reply-To: <200705132351.24867.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47222>

On 5/14/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndag 13 maj 2007 skrev Junio C Hamano:
> > I'd like to have feedbacks on this patch, as I think what it
> > tries to do is sensible and worth to have it in v1.5.2 if it
> > works for people.
> >
> > Ack?  Nack?  YesButNeedsmorework?
>
> Looks good, but I haven't tried it for production work yet.

Same here - got it in my dev system, but haven't had a chance to use
it in real-life.

m
