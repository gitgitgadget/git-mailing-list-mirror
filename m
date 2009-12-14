From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 21:41:26 +0100
Message-ID: <fabb9a1e0912141241y4b5c189bk816f2da3bbdd6308@mail.gmail.com>
References: <1260822484.9379.53.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKHjs-0007Ac-IB
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 21:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbZLNUls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 15:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZLNUls
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 15:41:48 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:61000 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbZLNUlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 15:41:47 -0500
Received: by vws30 with SMTP id 30so754714vws.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=aWAIjuq0Vspv56E8KATp6CwnWZV25sgGbke01Rp/nVA=;
        b=sTY+1/EXagGSyMKNWiphfM5WsLqsRx5RKnD9GMwgfkzDz4vQVlgcibcjzQiy8xi6zX
         RNH6sU3JJv4z+mgny7q7SPGdeysDk7ctnMCLwewVJl3zo9viTMYIt/ofXWzsmXFaC00d
         U6ex24tQVYlaD//LOhYkU+ykRHtntsesiMmDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=O6FwMvhonMmETJz7sL0Y20ZEb11r+k+C5l/gwGn1xUBnOtEdqVi7bTursEopohoX83
         OhsJzDRhXTjoO702PC44cg8r40SeQVjD7AcWTLGds4ehkDrqo08uM0M7kltbShPuxigQ
         38tzpGmxuQMprEOT91zLPuFdwUbbKmy6XGq3w=
Received: by 10.220.126.165 with SMTP id c37mr968635vcs.76.1260823306507; Mon, 
	14 Dec 2009 12:41:46 -0800 (PST)
In-Reply-To: <1260822484.9379.53.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135236>

Heya,

On Mon, Dec 14, 2009 at 21:28, Eric Paris <eparis@redhat.com> wrote:
> What can I collect, do, whatever?

If this really is a case that we end up wanting to optimize somehow,
it would probably be very helpful to make a copy of the repository
state _before_ the gc is done.

Also, 1.5.5 is really really old in git terms, consider compiling your
own. Something post 1.6.4 might be a good idea :).

-- 
Cheers,

Sverre Rabbelier
