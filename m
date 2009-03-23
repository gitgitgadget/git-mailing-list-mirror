From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Mon, 23 Mar 2009 12:31:04 +0200
Message-ID: <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhSU-0004Qh-CQ
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbZCWKbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 06:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbZCWKbJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:31:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:27874 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbZCWKbH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 06:31:07 -0400
Received: by fg-out-1718.google.com with SMTP id 16so346515fgg.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=am7xGU9vDwN+2wd9+12bDcmSvIONRrvrU+chMq33Atg=;
        b=lxCF2D2WCL1QwSnK7AFtrNgFCkLx4yfsNo3asu1umXebCHwwYKIeqrJXZ7KGXECh91
         ggNVpgzBQJxFRi8ilmG8ht2/gr2IpyoApOcOAQWFFpmIjtvnkx7XWTx2YyrjeG63e0qm
         CydSTTNzhA9UBpD6JiP5QawhdJXVpj/MfzBl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ByBTh+O2z3IodZhNdi8FBrBb1Znvqy4KTs0qW4beJVXHF7GvIfz6uG09YBM455JpzA
         T3sd0zSY5IzC1fTszPJJhZo6LfBtPttlGXnC3ifO5YV2nmdYjNqLou0otohNoI8vasTV
         2ZHb1AuVEtlQc773rVszu4SifLo0bXkV3FjQY=
Received: by 10.86.76.16 with SMTP id y16mr3517372fga.18.1237804264787; Mon, 
	23 Mar 2009 03:31:04 -0700 (PDT)
In-Reply-To: <20090323064242.GB1119@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114276>

On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:
>
>> =C2=A0tt.literal, code.literal {
>> =C2=A0 =C2=A0color: navy;
>> + =C2=A0font-size: 1em;
>> +}
>
> Isn't 1em already the default size? Or are you trying to override som=
e
> other size specification elsewhere? It's hard to tell what the goal i=
s
> because your commit message merely says "improve".

That's correct.

The problem is that when the user has a different size for the
sans-serif and monospace fonts it looks horrible when they are on the
same paragraph. I thought 1em did the trick, but you are right, it
doesn't.

It looks like the only way to fix this is to set absolute sizes.

--=20
=46elipe Contreras
