From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 17:45:01 +0100
Message-ID: <8fe92b430902130845r4ebe32eq78f849d66ab899fa@mail.gmail.com>
References: <alpine.DEB.1.00.0902131445390.10279@pacific.mpi-cbg.de>
	 <1234535092-20133-1-git-send-email-trast@student.ethz.ch>
	 <4995928A.5000908@viscovery.net>
	 <m363jeux00.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adeodato Simo <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 17:46:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1BV-0000M1-Vq
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 17:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbZBMQpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 11:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbZBMQpF
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 11:45:05 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42716 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZBMQpE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 11:45:04 -0500
Received: by bwz5 with SMTP id 5so1863753bwz.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 08:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m/8PNBdgOybzhIYlAD1r1aU57117pP+SMSmp9t/3zU4=;
        b=SlvigC1WM3aegu4SQWmPJ4ZjFbMLQ2Fye6XRaSgn9vaGPnFZbOSOcgui2BzGjtlidH
         YmUTbuC1XojyfqdrLtbz+HaZ7WVj0sn4ExIyInmyoXd4Emi2dzGrEanMRkyBBqBiIrpL
         tO26mzqScnbeR27tWqXg+SsKHKHuOsnG4JOmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gfoA3HOSJefJ8X6l2La29TM02I8Gv4QsXcSnd5E/b8DWMfZGYtXqZVEZoQEwj7TS4Q
         Sv7RdUWVv1MKvwc422SlS1sbFRhgV448PV6plpdVvZev3cV+LZ3KCetDO5556YPKSbzU
         CWF3QrjzUK3G92eM92DsKkmdAPUTWgzQvRpjY=
Received: by 10.180.247.12 with SMTP id u12mr57308bkh.154.1234543502015; Fri, 
	13 Feb 2009 08:45:02 -0800 (PST)
In-Reply-To: <m363jeux00.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109759>

Johannes Sixt <j.sixt@viscovery.net> writes:
> Thomas Rast schrieb:

> > So we introduce a new variable format.abbrevEllipsis that defaults to
> > true (previous behaviour).
>
> How about format.hideAbbrevDots that defaults to false? Then you can write
> in the config file:
>
>     [format]
>          hideAbbrevDots
>
> (note: without '= true').
>
> Even though I usually detest double negations (and I would count
> hideAbbrevDots=false as one), the ability to set the non-default value of
> a Boolean variable in this way trumps my taste.

By the way, should it be in [format] section? I thought that format.*
variables are about git-format-patch... Wouldn't it be better to put it
in [log] section?

On the other hand we have already format.pretty (but log.date and
log.showroot).  Nice consistency ;-(


--
Jakub Narebski
Poland
ShadeHawk on #git
