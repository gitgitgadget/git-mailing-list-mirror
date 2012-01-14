From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Sending patches with KMail
Date: Sat, 14 Jan 2012 12:34:46 -0600
Message-ID: <20120114183446.GD27850@burratino>
References: <2608010.fNV39qBMLu@descartes>
 <20120112162617.GA2479@burratino>
 <2304907.sEfEeC6Eon@descartes>
 <20120113233158.GD7343@burratino>
 <7vlipbxfne.fsf@alter.siamese.dyndns.org>
 <20120114183111.GC27850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>,
	git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 19:35:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm8RR-0003Xf-6G
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 19:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab2ANSey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 13:34:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48382 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756501Ab2ANSey (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 13:34:54 -0500
Received: by iagf6 with SMTP id f6so126417iag.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EDAkhBl5bITok2ITUkAq53u/5s82UwZiyZovXoMcyh4=;
        b=fHbQ5pqbyvOzhQVdsABTA4v5LDU5bQG9M/dkefaw2/3B1U0W6vad7vq/8JVtbQFqL6
         ucXJG25D5PP0KUL7ejlMOwD06TdKR3NiahVdroEAJWFo3SiPqHUEt1HXO2YFsmFx+PRX
         fMm9nvAu+aNjt5TTr+wvuoi2t1cAn855StfkA=
Received: by 10.50.222.193 with SMTP id qo1mr5988572igc.22.1326566093704;
        Sat, 14 Jan 2012 10:34:53 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id pb6sm22079054igc.5.2012.01.14.10.34.52
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Jan 2012 10:34:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120114183111.GC27850@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188575>

Jonathan Nieder wrote:

> My favorite approach would be to introduce a new option
> --format=plain|mbox, with the default being mbox, allowing
> format-patch --format=plain to produce a nice patch that does _not_
> include a "From " line or q-encode its header lines, ready for use
> without much tweaking in an email body as an attachment.

This should have said "ready for use in an email body or as an
attachment" (missing "or").  Sorry for the confusion.
