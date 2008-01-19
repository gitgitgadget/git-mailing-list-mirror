From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: Merging using only fast-forward
Date: Sat, 19 Jan 2008 04:30:54 -0800
Message-ID: <402c10cd0801190430y7d3253c9ue36ce4e6647c6f0d@mail.gmail.com>
References: <loom.20080116T151930-575@post.gmane.org>
	 <863asxivlj.fsf@blue.stonehenge.com>
	 <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
	 <402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
	 <7vodbibzch.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
	 <7vzlv2858y.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0801190427o62493073s408959aa5701ca86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 13:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGCr9-0003iY-32
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 13:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYASMa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 07:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbYASMa6
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 07:30:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:27654 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbYASMa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 07:30:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1310245fga.17
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 04:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rAU6F/GaRuq0H6lR+r8lD+wgLTkacy4KM/wajZcJl2U=;
        b=WjhyuLAIs4oNJOm8qShBk4WnulJpaesyMkT72vBhfAjbhQ8PbJYv1lN1vDgMBAH+Vaf6/iP4ayHUbNUQ6Nwr01wI06js+tiDqGl72jddKkBelkL3Hp9R2tRHne27iioqdheCmlpPi0sbOzMsAdmEOnXKnjL6/AHMbR0fylOKUxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=flfZD7CWD7uFjpyb9Bgja1+Xz8ndlzM6w4eJRW0M6TAdKKWRVWHNcweZoPBNNlC6S9qNqIGEbtW1dxBGn1OwBoi/scDRgFSHWjXlZg3vTaZ5y8Db5roAbS/O/6C0ldiyekROhR8QIYinU6mArTlhxVgI9M7J5nqAJd4YJZJ+GL0=
Received: by 10.82.149.8 with SMTP id w8mr8142022bud.24.1200745854979;
        Sat, 19 Jan 2008 04:30:54 -0800 (PST)
Received: by 10.82.172.18 with HTTP; Sat, 19 Jan 2008 04:30:54 -0800 (PST)
In-Reply-To: <402c10cd0801190427o62493073s408959aa5701ca86@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71101>

On Jan 19, 2008 2:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> At one end of the spectrum, we have these crazy people who want
> git to record something that is not a merge at all as a merge
> with --no-ff.  At the other end of the spectrum, we have these
> other crazy people who want git to outsmart them by allowing
> them to throw random set of commits as potential parents,
> remove duplicates and figure out how many real parents the
> resulting merge should have (including the case that it may not
> even have any).

I guess the most common use case would be where you have at least
three developers and they randomly fetch and merge between each other.
 They usually are not aware of where each other are and everyone
avoids octopus.  They end up with more merge commits than needed
simply because they sometime pick the wrong order.  If they instead
had git find the real parents they would get fewer merge commits.

-- 
Sverre Hvammen Johansen
