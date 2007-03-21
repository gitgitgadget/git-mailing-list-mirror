From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 15:58:02 +0100
Message-ID: <81b0412b0703210758v32e7a692p426f45de9ee6db42@mail.gmail.com>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
	 <20070321051406.GW96806@codelabs.ru>
	 <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070321115004.GB14837@codelabs.ru>
	 <Pine.LNX.4.63.0703211522320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <4601437D.1010700@gnu.org> <20070321144210.GF14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Eygene Ryabinkin" <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 21 15:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU2Gl-0000DW-3t
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 15:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbXCUO6G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbXCUO6G
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 10:58:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:30246 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbXCUO6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 10:58:04 -0400
Received: by nf-out-0910.google.com with SMTP id b2so888122nfe
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 07:58:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L2k1nQ2+IVcMH3+LuBoq02gkwrWrPRD1ARjDyqv4woCWR7WSOBVJvN4M5/Gjt9f6enrpAn8BJTaUdA4XlZgRFjUHww5nl6xKEEhA3dXj9SE6tNILI+dQ/s+buwZgQpcyihOn0mJrJo35U6p47gPTFP4o3AWNNMBtWvL70A0OHvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R85KtOWEYu4wTh4jEE+3taTEu4RbYPaJAZOOVY8mv+tOT0rAMpHyB3LqGG7RHQ6v/rFBPPSlo4iwQZwMYjct2lYOXES3goVpFW6cbTi1lnBq5prSflXlWdiRhE6YVTshbpJqeK6tAJmK5c3o9RXiJ+Vhqh4+p6pPwgl47CzJk2g=
Received: by 10.78.17.1 with SMTP id 1mr393940huq.1174489082379;
        Wed, 21 Mar 2007 07:58:02 -0700 (PDT)
Received: by 10.78.139.9 with HTTP; Wed, 21 Mar 2007 07:58:02 -0700 (PDT)
In-Reply-To: <20070321144210.GF14837@codelabs.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42794>

On 3/21/07, Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Wed, Mar 21, 2007 at 03:38:53PM +0100, Paolo Bonzini wrote:
> > >> I am happening to develop on some machines on which I have no
> > >> X-Windows or any GUI providers at all, so I prefer not to have the
> > >> Tcl/Tk dependency at all.
> > >
> > > If you don't do something, it is often interesting to state why: if you
> > > don't install something to prevent a dependency you don't want to have, it
> > > is different from saying that you do not want to have a GUI, _even if_ the
> > > dependency is there already.
> >
> > I read his message as "these are useless for me, so why introduce a
> > useless dependency?"  The "effect" is to have no Tcl dependence,
> > but the original reason is to have no GUI.
>
> Yep, you're right. That was I meant originally. How do you feel
> about NO_GUI or NO_TCL names?

That'd be NO_TCL_TK. TCL has nothing to do with graphics.
And you have one more supporter for NO_GUI (my server has no
usable graphics, will never have and runs cron jobs with git in them).
