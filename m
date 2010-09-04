From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 12:58:31 +0100
Message-ID: <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
	<4C81A67B.2060400@gmail.com>
	<alpine.LFD.2.00.1009032304560.19366@xanadu.home>
	<4C81DC34.2090800@gmail.com>
	<alpine.LFD.2.00.1009040153280.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 13:58:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrrOJ-0007EM-VW
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 13:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab0IDL6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 07:58:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37909 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0IDL6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 07:58:34 -0400
Received: by vws3 with SMTP id 3so2061021vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LKazgY8LGpiyG9whwyymm93OVRHO/K7iWG8X+3S9ytQ=;
        b=Q6SJh9Kmf+Zcy3jQgVsQrVR6vUCPXbhHrLfEveJ/+tWUScrfxdTMhbHS3kcT3E+CvL
         XLvygukMuPRWalNSmjQA6ewrrpTyD1G2YKT6x6LnIPzfSV/IIHDepkFmjLSyMho0LRfl
         c1bzwtEsq1kpi1c+oO+QQA6+/MKJ3F5N5r6fg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=njQwW4KlJvJ+7ETO7c0NN8SQrS2BXcT4BPKWUBWpTDHdDcxys3XqNoZW/60c8PM6PO
         RO3g4wzBpKe1Tn1de+pAKzmfeWTC4rNrAOXYxn8gL8wjSyY1GfCpf3467iXxEY2pckRS
         nDxhdYMonT2AZT6tmJSOsnfDoejr+Ai990mGw=
Received: by 10.220.158.9 with SMTP id d9mr1293040vcx.105.1283601511532; Sat,
 04 Sep 2010 04:58:31 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 04:58:31 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009040153280.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155318>

ok, there's one other question i need some info on (thank you to
nguyen for answering about git cat-file): is there a way to make
git-pack-objects _just_ give the index file, rather than go to all the
trouble of creating the pack file as well?

the reason i ask is because i would like to get the index file, parse
it for objects (as nicolas recommends) then present the contents of
"git cat-file" as files within subdirectories, via this
pseudo-VFS-layer over bittorrent.

tia,

l.
