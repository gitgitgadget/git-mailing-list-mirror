From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Documentation/config.txt: Order variables alphabetically
Date: Wed, 1 Dec 2010 16:19:16 +0100
Message-ID: <AANLkTindMBh4dzo-VG2vPrKfgNZVUhs0-5AEU2fWChaC@mail.gmail.com>
References: <1291209174-9239-1-git-send-email-jari.aalto@cante.net>
 <m3eia14mu7.fsf@localhost.localdomain> <20101201142920.GB6537@picasso.cante.net>
 <201012011557.30849.jnareb@gmail.com> <20101201150917.GD6537@picasso.cante.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: jari <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:19:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoTB-0007ac-VH
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab0LAPTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 10:19:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45526 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab0LAPTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 10:19:37 -0500
Received: by fxm20 with SMTP id 20so155780fxm.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=i+AbF8N6vs8BjC6SfuBqkTMtU73QGU3ewHoVQt7jyj4=;
        b=RKXIz4uYdkFzKsPTnjNGKbUcMrDEbRUc6Nbp5pLzV8CB2CwDo9yFWMl73AHaWIXuOz
         msv/ey3h4pgboOIjGKE1r+I/WQPp41iaBeOd6k+QamJi9cw9yJIp+LxFRBPaaznFnYg1
         dMKMrhcjM68jPsuo1I9J3jiFsyNhLFcPMiHHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=OJmMylQX2GuVPspOn+uAUduaC6ZgQAYmBxXXjQrGL1ZFf24VBNqGZMIDmJ2d5oBwMN
         dQa3Dgi8n9NRNVrDuZgg3SssHB8PODERefWn6p6tVZTtRtf7pT8G4AaxsTZucXJzz/M0
         WFDvOE+3dgCT68T8fES21xx5eYilDRmE9/XZI=
Received: by 10.223.107.16 with SMTP id z16mr8466149fao.7.1291216776683; Wed,
 01 Dec 2010 07:19:36 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 1 Dec 2010 07:19:16 -0800 (PST)
In-Reply-To: <20101201150917.GD6537@picasso.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162530>

On Wed, Dec 1, 2010 at 4:09 PM, jari <jari.aalto@cante.net> wrote:
> On 2010-12-01 15:57, Jakub Narebski wrote:
> | On Wed, 1 Dec 2010, Jari Aalto wrote:
> | > The phone books have an index where to up information.
> | >
> | > =A0 =A0 - When you see script and it use VARIABLE, you look it fr=
om
> | > =A0 =A0 =A0 manual page
> |
> | Manpages (and 'git <cmd> --help') are displayed in pager, so you ca=
n
> | always search for option in a pager (e.g. '/' in 'less', the defaul=
t
> | pager).
>
> Yuck, it's real fun start backward/forward ping-pong when you dont'
> know the directions and can't rely on standard A-Z index.
>

=2E..but for config options, I tend to ping-pong between items that are
related to each other, which are already located close by. Your
argument weighs more for keeping the current layout, IMO.

> | > It is same as putting option in alphabetical order. See GNU cp(1)=
,
> | > ssh(1) etc.
> |
> | In git documentation command line options are not in alphabetical o=
rder,
> | but grouped by functionality, therefore your argument is invalid.
>
> I see that only in pages that have tens and tens and tens of options.=
=2E
>
> The problem is more the asciidoc's. Various bits and pices are
> "included" in place and make orderign the options impossile in some
> pages.
>
> Let's get all pages in shape with A-Z in this regard. That's a god
> quality goal.
>

I still haven't heard a compelling argument why alphabetical ordering
is better than logical ordering...
