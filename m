From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Fri, 16 Feb 2007 21:30:25 +0100
Message-ID: <8aa486160702161230r6f5825a2v861315c1aa52520e@mail.gmail.com>
References: <874ppmplw7.fsf@gmail.com>
	 <7vwt2i7bq7.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160702160040t3f42b5a0xbd12f333805ad4d7@mail.gmail.com>
	 <7vd54950ed.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 21:30:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI9iw-0007CM-De
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 21:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946131AbXBPUa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 15:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946132AbXBPUa1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 15:30:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:61376 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946131AbXBPUa0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Feb 2007 15:30:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so265268uga
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 12:30:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=juw7Pmf2DdYauEGAuiRPrk6mfvpBb1CsFZQJjgQgxrdnpb8O+qDzzT+/zipJeNErXBXGuLRZbHqT5YpyZZmjdWb2WZSEXN01Fvt9M+Apvt7/Y84ctJ3h2AvFec8vpVOrMKFLWyhlcYQd7wRY9XT70ZijT4ECsoVZx8kWhZQXces=
Received: by 10.78.204.7 with SMTP id b7mr672494hug.1171657825167;
        Fri, 16 Feb 2007 12:30:25 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Fri, 16 Feb 2007 12:30:25 -0800 (PST)
In-Reply-To: <7vd54950ed.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39948>

On 2/16/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> > In the past we've had problems when we have changed the merge logic
> > (as shows 4363dfbe3). This patch makes the two process completely
> > independent, and concentrate the merge logic in one place (leaving
> > git-parse-remote.sh independent of the merge logic).
>
> But that is a solved problem, isn't it?  What else does it
> solve?  The justification for moving around the logic could be
> something like "these three patches do not do that themselves,
> but it opens a door for further work such as ...", but without
> something concrete in "..." part, your response makes the patch
> look mostly needless code churn.
>
> I was hoping to hear something like "now git-fetch has to do
> much less than before, eventual C-rewrite of the command, which
> can borrow some code already written for 'pu' branch, will
> become much easier" ;-).

This sounds like a good justification, also :-)

Santi
