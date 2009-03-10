From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 12:20:38 -0400
Message-ID: <76718490903100920v3d3a3d68xc7a258d92be56454@mail.gmail.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
	 <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
	 <20090310100400.GC11448@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 17:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh4jO-0007FS-NT
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 17:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbZCJQUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 12:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbZCJQUm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 12:20:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:12197 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbZCJQUl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 12:20:41 -0400
Received: by rv-out-0506.google.com with SMTP id g9so2456876rvb.5
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zhu/hdqwu3yIvOUnn4xI8Boao3bUdDuTmwHassGcJqY=;
        b=ceLAMdMMc1SXvp6GupWHYV7/6SE4rPZAg36NnnYStMeD3tNxcbp+J3G9tRlk6IWGSO
         lw4t/EUq/KCd7EHpSNXsp/aq87i/Yiv4wTZuG7y4UePdTMlc0WolnLtSekA2NEUprGLh
         O+G43spuCDEflQLwba6QXgQJnFaOW9e9kldMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aKd5XWAtKfKwu+Su2DGbEqn84G9OS5zkkKXwZasxurRNADfr/sTPOypglE6qWjDB4m
         qg2a5i7NR9Kjr1nPb1Oie+oqFVRss9SxaUzzg9BgvV7mVdCMpGN2HTXYpHe5VuwwY+3c
         +W1IyTsCP5cuPdjKP1gU5ZTyLrUC0ZWszvDJU=
Received: by 10.141.89.13 with SMTP id r13mr3798427rvl.269.1236702038967; Tue, 
	10 Mar 2009 09:20:38 -0700 (PDT)
In-Reply-To: <20090310100400.GC11448@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112829>

On Tue, Mar 10, 2009 at 6:04 AM, Finn Arne Gangstad <finnag@pvv.org> wr=
ote:
> You are thinking of something like this in .gitconfig?
> [remote "*"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0push =3D __something__
>
> Previously you indicated that there is no way to specify the current
> matching rule in a remote push line I think?

No, you can. "push =3D :" works fine.

However, there's no way to specify "push =3D nothing" currently.

=46WIW, I don't care for using remote.*.push for this use case. I think
push.default is clearer here.

j.
