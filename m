From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 21:47:19 +0100
Message-ID: <AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com>
References: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
	<5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
	<AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
	<20100904181405.GB4887@thunk.org>
	<m3tym5mfce.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ted Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 22:47:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orze2-00054F-J4
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 22:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0IDUrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 16:47:21 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58040 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab0IDUrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 16:47:20 -0400
Received: by vws3 with SMTP id 3so2298066vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t7uyc3jN6uB53+XrI2mu9S91r71/xkm8ooc1rioesIc=;
        b=QctMRuqEaPeBrIrTohwYhehPHWKKBa8pvT1HpKszmqRNQkPS9e+3r+V1dwDdbE+sIB
         qVSWVkTX3jthI91Ddx0lqiwuLnqppggwdFqj/sPpu7RRkrZVZkpL5rJD/XlZZHK/fkcu
         iIbXyphaX/jS1Jagi5bEGR2T0Z4BY+t5GUS4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HKqgAoq2/kzO0Sl789hgeGGEZADAIJ61xvHl4hTFjN0P8aStgSgLCchPaDRkbFGqAu
         Cgfig9AKlxWETvjCvUwYud2NqcorjAM1i06RKw7vdbF5gSUGac5MQ8wDMlaojRzUZctO
         tZ0XlEIsJP6OcLEu0E88YlOuWOPnuP/KBa3os=
Received: by 10.220.88.138 with SMTP id a10mr1554433vcm.236.1283633240091;
 Sat, 04 Sep 2010 13:47:20 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 13:47:19 -0700 (PDT)
In-Reply-To: <m3tym5mfce.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155358>

On Sat, Sep 4, 2010 at 9:20 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:

> Luke, you don't have to be peer-to-peer to be decentralized and
> distributed. =C2=A0People from what I understand bitch most about
> centralized (and closed) services.

i've covered this in the FAQ i wrote:

=46AQ:

Q: is git a "distributed source control system"?
A: yeees, but the "distribution" part has to be done the hard way,
   by setting up servers, forcing developers and users to configure
   git to use those [single-point-of-failure] servers.  so it's
   "more correct" to say that git is a "distributable" source control
   system.


so if you believe that git is "distributed" just because people can
set up a server.... mmm :)  i'd say that your administrative and
technical skills are way above the average persons' capabilities.
proper peer-to-peer networking infrastructure takes care of things
like firewall-busting, by using UPnP automatically, as part of the
infrastructure.

come on, people - _think_.  we're so used to being able to run our own
infrastructure and workaround problems or server down-time, but most
people still use "winzip", if they have any kind of revision control
_at all_.

l.
