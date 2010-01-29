From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 14:46:54 -0800
Message-ID: <8c9a061001291446y1caa5e7cy25d1f19ecf0745e7@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <7veil8iqnj.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291614550.1681@xanadu.home> <fabb9a1e1001291321v708c7cb4sec8e944f336d04fd@mail.gmail.com> 
	<alpine.LFD.2.00.1001291628510.1681@xanadu.home> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> 
	<alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:47:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nazcv-0006Bw-Rr
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab0A2WrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 17:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967Ab0A2WrS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:47:18 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:48342 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0A2WrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 17:47:15 -0500
Received: by pxi12 with SMTP id 12so2066355pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 14:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8aIGcCABPAJQqFi5ntgN/6/bSPNKOIFtg1bvJcdlsnU=;
        b=XHCLC7shXx1q9yWI8HRukWDRa/L5FPAkJhLFL4tpcABEffdW1j7f3i50xQvPyH1trv
         RlBHdgBH0Gqufe6o8TZ5USvTg9/S3Lx1q4TGWRUbMJV6MMMQYJR6s+eHn+n6hBFZyUCs
         smmV56NOTStQ3Voy8RjBd3k0rlAbOXT3018oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=diQeM3N5zLkup/3KryFaZzCM+6Clei3EZOGmewFuW0hP6cI67NIwnrSELqUGM6Pc+N
         an6qZpVhLFR2uI87oUTs9jA9uCJApM9T6m6Wqdo3zFUpyH47wgYuYdO2O9/AUWoQuVoT
         ikoE+NpRowPozG+q1U1d/hicJepRGSXBL/aoc=
Received: by 10.140.55.5 with SMTP id d5mr952204rva.177.1264805234526; Fri, 29 
	Jan 2010 14:47:14 -0800 (PST)
In-Reply-To: <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138394>

On Fri, Jan 29, 2010 at 14:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> Any comment on my previous rewording patch ($gmane/138369)?
>
> "Note: '%s' isn't a local branch head: creating a detached HEAD\n"
> "If you want to create a new branch from this checkout, you may do so=
\n"
> "(now or later) by using -b with the checkout command again. Example:=
\n"
> " =C2=A0git checkout -b <new_branch_name>\n", new->name);
>
> A major difference I think is that I avoided a jargon (detached HEAD)=
, and
> chose not to say why the input was interpreted as a request to switch=
 to
> that state.
>
> Oh, of course, I also added advice.detachedHEAD to squelch it ;-)
>

=46or what it's worth, I'm +1 for this.  Especially the ability to sque=
lch it.
