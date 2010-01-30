From: Michael Witten <mfwitten@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 18:38:32 -0600
Message-ID: <b4087cc51001291638y5620eb3epd86efe577ab7adb1@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> 
	<alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> 
	<alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> 
	<7viqakcu56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 01:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1MZ-0000tq-TU
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 01:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab0A3Aiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 19:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890Ab0A3Aiz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 19:38:55 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33438 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab0A3Aiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 19:38:54 -0500
Received: by ewy19 with SMTP id 19so53115ewy.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 16:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FSgm6hWh+Hp5nwwKYbEwie2qxGke2wclNoI314Jg2Fc=;
        b=VZPrlKLITi/65dVWkqnvEcG+D+5yFaMDispfZ1vgIx+/ewzlDETQC/d9NuqhgiPpSI
         RWr778ED/9IH1VM0d+Dz63vDo4+1kWIO8i8jvD+A1HzvC3sjETm5dq3+im3Y8hzSS9mF
         5TLzV4V4/610+IHHTWQZvkzDRcS+NafTJEYMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g+PM04H1yphPeTVVdeubZ6ioW3k17xxrGdDgVTO2RhTDqckfbKkQFWYk0tAXHaKDaM
         ZbLVEzAwBCRKGLs74NHdGvqzWGlxlPZZxwtj6G8TxDyW9uxpTzQzSJal90Os2uTmTfRh
         NaLknRotM9GpNIsEHJlt5QoQGj1qGEiZoGAYw=
Received: by 10.213.1.142 with SMTP id 14mr273331ebf.40.1264811932070; Fri, 29 
	Jan 2010 16:38:52 -0800 (PST)
In-Reply-To: <7viqakcu56.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138411>

On Fri, Jan 29, 2010 at 6:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The "state" was not about the work-tree state, but about the
> "detached HEAD" state, which I didn't make it clear.

Maybe we should just introduce people to a more explicit command like
the hypothetical 'update' command I sketch here:

    http://marc.info/?l=git&m=126481166426896&w=2
