From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 18:16:29 +0100
Message-ID: <bd6139dc0901150916v41959d78r41483617b952ed5f@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
	 <496EE74F.6000205@viscovery.net>
	 <200901151101.53441.johan@herland.net>
	 <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
	 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
	 <bd6139dc0901150445l51f3b861n5bbd85bb6d1382b6@mail.gmail.com>
	 <7vmydsv72u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVqu-000854-Lm
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 18:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbZAORQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 12:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZAORQb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 12:16:31 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:51031 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494AbZAORQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 12:16:30 -0500
Received: by gxk14 with SMTP id 14so1086973gxk.13
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=eIUenR2g7cOe8U/BOPj1jtGBrJiIUoKXFhcDvqGE6PM=;
        b=US4307o8BV3ZJQcY85RhwYcJs/Z2W7DMqTIUH1qWfiUR7u/0AP7NTDsjTwwH1OLb58
         XypuDVFUmsVC/1YAlhiDOQ2wXkE2IPt5UmAjxO9/fkCsnyezuyMc59mQjEwm3yAGid9p
         G1mA4sBPGmp8HsW0JoyfZy9qk3/ZOWla6TQqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=taMh6EQwN9m/h5esJKccPdj6H65Y2eOudDql9a61UxGCv0eLMG21jfHj+Igl2ajRF+
         Tt4+vsN2LCt1sw4p1k/6wHOjBRxn/bSokioWMeRIurM25VAppNgAlrko14Evsn2DdDlX
         aMJIPHHmw+d3XvqI9Bw44CsNc6Ulunziq2vxc=
Received: by 10.150.57.5 with SMTP id f5mr1795263yba.220.1232039789108;
        Thu, 15 Jan 2009 09:16:29 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 09:16:29 -0800 (PST)
In-Reply-To: <7vmydsv72u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 135f23eb6d3abdb1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105858>

On Thu, Jan 15, 2009 at 17:59, Junio C Hamano <gitster@pobox.com> wrote:
> 'stop' would be closest to what it currently does.  It stops and it is up
> to you how to screw up the result ;-).

Hmmm, yes, I think that would be a better alias; but I think I like
the idea to wait for changes like this till sequencer goes in, mhh?

-- 
Cheers,

Sverre Rabbelier
