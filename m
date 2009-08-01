From: Jim Meyering <jim@meyering.net>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 01 Aug 2009 16:58:44 +0200
Message-ID: <87tz0rinrv.fsf@meyering.net>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	<4A714F5C.70000@eaglescrag.net>
	<81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 17:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXG4T-0001SA-FM
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 17:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbZHAPAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2009 11:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbZHAPAE
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 11:00:04 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:54401 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZHAPAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2009 11:00:02 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 794FBD1AFA4
	for <git@vger.kernel.org>; Sat,  1 Aug 2009 16:59:58 +0200 (CEST)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A46D58180F7
	for <git@vger.kernel.org>; Sat,  1 Aug 2009 16:58:47 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C6F78818085
	for <git@vger.kernel.org>; Sat,  1 Aug 2009 16:58:44 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 42B8555475; Sat,  1 Aug 2009 16:58:44 +0200 (CEST)
In-Reply-To: <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
	(Alex Riesen's message of "Sat, 1 Aug 2009 09:43:39 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124627>

Alex Riesen wrote:
> On Thu, Jul 30, 2009 at 09:44, J.H.<warthog19@eaglescrag.net> wrote:
>> Don't use 'lzma' the command, use 'xz' ( http://tukaani.org/xz/ ) as=
 it uses
>
> The host seems to be down.
>
>> the lzma2 format which is, by far, preferable to what 'lzma' outputs=
=2E =C2=A0Same
>> compression (lzma) just different file format.
>
> And the whole project seems to be very young (listen on ohloh since 2=
007).
> And it is not in current stable distributions. Exotic thing.

XZ is young, but worthy, imho.
It was added to Fedora 11 in the last few days.
