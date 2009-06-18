From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] rebase -i --autosquash: auto-squash commits
Date: Fri, 19 Jun 2009 00:35:23 +0200
Message-ID: <81b0412b0906181535w6f02d00bw3678b901a477e8e6@mail.gmail.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	 <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	 <7vvdmurfao.fsf@alter.siamese.dyndns.org>
	 <20090618063348.6117@nanako3.lavabit.com>
	 <7vvdmu15j0.fsf@alter.siamese.dyndns.org>
	 <20090619065534.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHQCl-0003Ou-OW
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 00:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbZFRWfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbZFRWfX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 18:35:23 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:62360 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758702AbZFRWfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 18:35:21 -0400
Received: by fxm8 with SMTP id 8so1411188fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vzyQ1HaY0YAB8+g11RFim0U955NQbBjKql6N7IcgIog=;
        b=omDcaL/RVe+TQ7wqdoee0Nx+nuSBosbmhLTwsZUSIX0a746rtH1KoGOs12V338e5nE
         wtqbfK1yNbbnjm7NL0ARm6fBFaZFF/9bjIJevMwHh+P7C/W8gq0IsDV+0Ko7dI8R+cgf
         GcnMGttYisjGDqNKDFh80bS/co1S0vM9st5Ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aR/3OOeDLgq3Sxz+a92Ez2CfzreT6ubJ9+bpmXR2kueNeykUhjbAuKspRVzH0H2qmp
         1vyDuW80+g9lp6l94Xu8MGasnKu2GDTft+7v5eBcOYXxh8xiZZ1XIEUB/eVS5bqKBoAU
         IqjOz72yF4BtVmELobiyXcHO39s6PnnSWhQHk=
Received: by 10.204.72.129 with SMTP id m1mr1851052bkj.61.1245364523529; Thu, 
	18 Jun 2009 15:35:23 -0700 (PDT)
In-Reply-To: <20090619065534.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121876>

2009/6/18 Nanako Shiraishi <nanako3@lavabit.com>:
> Teach a new option, --autosquash, to the interactive rebase.
> When the commit log message begins with "!fixup ...", and there

Can I suggest to rename it into "--autofixup"? Or even "--auto=!fixup"?
Just so that people have one thing less to remember.
