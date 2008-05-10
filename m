From: "Brandon Casey" <drafnel@gmail.com>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 23:15:11 -0500
Message-ID: <ee63ef30805092115i7f433f65p4b8ed3f2721fb456@mail.gmail.com>
References: <48235D99.2040407@nrlssc.navy.mil>
	 <48237344.6070405@nrlssc.navy.mil>
	 <20080508214454.GA1939@sigill.intra.peff.net>
	 <48237650.5060008@nrlssc.navy.mil>
	 <20080508224827.GA2938@sigill.intra.peff.net>
	 <loom.20080509T011318-478@post.gmane.org>
	 <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
	 <ee63ef30805082105w7f04a2d1y65a4618aeb787cac@mail.gmail.com>
	 <7v1w4bb291.fsf@gitster.siamese.dyndns.org>
	 <ee63ef30805092032h18fe7ff7mda4233b08ae431ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 06:16:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JugVd-0003np-Rb
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 06:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbYEJEPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 00:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbYEJEPO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 00:15:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:28443 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbYEJEPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 00:15:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1042358fgg.17
        for <git@vger.kernel.org>; Fri, 09 May 2008 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xaJ9PBt2HTfG0Jr1W5SA1VG+S7+ITfq9pw993YvvVpc=;
        b=BtRt0cLAkmRPDVktZKYQexf5BNpL7PljIo1DQnOM588zaYGLnxk1U2/KdwCjnbh8836t85wa7sHEIqHRy12i/uRPvqHZ0InSyKMdb0HcdtTIBjBwzCi3kQdqx0r4AUt9xwW3pUJyo98dTm2Ta6puds2sAAEd4oQ36lx3bhFFz6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XWlss/Tz1vWNXtpVO0SM6wELEQ72/XeVl1NrM/LWdJJTYcMSmJ3o8KXMucB+gXerLk7G3bx/vBSNMSCSDiUOcq3YlIP1lWFTtkC2fBqnm5dNxlbnZCawUeExEnXP/pqtuz6EBs8D4mNMN4eyFs3XafU1qxxi1i3wpzOIBBr/pso=
Received: by 10.86.98.18 with SMTP id v18mr9758044fgb.31.1210392911038;
        Fri, 09 May 2008 21:15:11 -0700 (PDT)
Received: by 10.86.89.8 with HTTP; Fri, 9 May 2008 21:15:11 -0700 (PDT)
In-Reply-To: <ee63ef30805092032h18fe7ff7mda4233b08ae431ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81649>

On Fri, May 9, 2008 at 10:32 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Fri, May 9, 2008 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The remainder of your email is below since the list has never seen it.
>
>
>> Perhaps we would want a new option --eject that causes pack-object write
>> out unreachable packed objects in the loose format?

Two comments on this.

1) If you decide to go in this direction, I think the option should be
    named --unpack-unreachable rather than --eject.
2) There is some part of me that is against a program named
    pack-objects doing unpacking. But it is probably more efficient
    this way.

-brandon
