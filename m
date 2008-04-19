From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: Re: [PATCH] Docs gitk: Explicitly mention -d, --date-order option
Date: Sat, 19 Apr 2008 16:35:49 +0900
Message-ID: <1f748ec60804190035x194a9bc2qfd2287daaa4e1860@mail.gmail.com>
References: <1f748ec60804180616i311571eftbabcd3133ff83302@mail.gmail.com>
	 <7v1w52ib5d.fsf@gitster.siamese.dyndns.org>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 17:51:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn7cm-0003XW-3y
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 09:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbYDSHfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 03:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbYDSHfv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 03:35:51 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:21079 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYDSHfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 03:35:50 -0400
Received: by an-out-0708.google.com with SMTP id d31so238568and.103
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Oo06/0ATWX/57TMeQZAI5IBMu1BtGxPoB9HojNrwol8=;
        b=gVDKRYcU8TX23peQCy7UVBwKnPn/OKyFAFOLwJU2WAZm+qOMH+zTZOLUqbPSqssQ23oiPjBrYk18nj2IIPXif1hB0eebgw8ZccErpiRZZAocb/7s7IgOYUPG+0pXCREIDL9YBkSN/pHogm+x6Y/CQWX4oMdU7NetygUmuGzIn2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=GbwTgNQh8cga+ipKp8wuxjScxkgS77BBSn7a18aktEJuNUCTI0/nIZVYEez3BQSCGptim5HRonsoP352JnJQK2xa6Eua/Zv4L4fK+oWkELaWmYbq2RPRUJ9tLezhrHl5A/uP90nfUymjkFQ1KUujY7BhZ62FPxWgUQBYm1ElIlA=
Received: by 10.100.225.19 with SMTP id x19mr7043101ang.16.1208590549881;
        Sat, 19 Apr 2008 00:35:49 -0700 (PDT)
Received: by 10.101.1.16 with HTTP; Sat, 19 Apr 2008 00:35:49 -0700 (PDT)
In-Reply-To: <7v1w52ib5d.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 91e7bf21031315b8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79894>

Junio C Hamano:

On Sat, Apr 19, 2008 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Clifford Caoile" <piyo@users.sourceforge.net> writes:
>  > Git Mailing List, Git Maintainer:
>  Heh, my name is not "Git Maintainer" ;-)

Sorry about that. Just adding another layer of indirection. >:-]

>  > Regarding the documentation patch "[PATCH] Docs gitk: Explicitly
>  > mention -d, --date-order option" [1] (2008-04-12), it has not been
>  > accepted. Is there problem with this patch?
>  >
>  > References:
>  > [1] http://marc.info/?l=git&m=120799377618677&w=2
>
>  There isn't anything _wrong_ with the patch per se, but the current
>  documentation refers you to rev-list page and limits itself to the most
>  often used options.
>
>  I was waiting to see that many people jumping up and down saying that the
>  omission of --date-order from the "most often used" set was a grave bug
>  before applying it.  It hasn't happened.

The whole motivation for adding this documentation is to show that
gitk has the same sorting function as git-browser. I only learned of
this capability through the irc channel.

As a git newbie, it wasn't obvious to me that "--date-order" was an
available option. It has become my usual parameter when launching gitk
on branch/merge heavy repos. Besides, and more importantly, the
equivalent "-d" is a gitk only parameter that should probably be
documented as well. I had to read the gitk tcl source for that one.
;-)

Best regards,
Clifford Caoile
