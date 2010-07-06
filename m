From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v2 03/13] add the basic data structure for line level 
	history
Date: Tue, 6 Jul 2010 22:21:32 +0800
Message-ID: <AANLkTilYsybKdfHjYv7DdK2zGqdVdzImo-Pn2aDAsjxC@mail.gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
	<1277911526-12105-3-git-send-email-struggleyb.nku@gmail.com>
	<7vbpal72vu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 16:29:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW99o-0005NC-EU
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab0GFO3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 10:29:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37760 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab0GFO3t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 10:29:49 -0400
Received: by qyk38 with SMTP id 38so1962312qyk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6ETzMOO6sTXBUZ6OD11XAxXGqdqf/VB2NNoTG6slxDY=;
        b=PebDgahAnxrrV5NXGhx4TXQWymJui5+XvpmM9AbCUujNEG7K6AqPbNXTl8+xeeEtgL
         sJoL12VAwvUfSH3WcJL+x8w7fn45z1nEIxgmsNlHX20K1YDPA49x4/4CAFG18lVFDSPC
         NAMRLtNRSP2BClbScEZtCIvX756PS/kgUJtFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cSBodDamwLqyfhQDvCnUspps7IWpAuw/1zXSWY2IfZYheJ2Cckd4uwYVlrz43iwzf1
         QByO5GAaQV1beOVp5WKp19cEDJG4XJNmCdgeD7oDovm0GecLtVu56VKPLFdJrstPcr29
         4d+HlitZmnqvLipzdscEnEJYjnis522Ajhxbg=
Received: by 10.224.54.140 with SMTP id q12mr611948qag.319.1278426093220; Tue, 
	06 Jul 2010 07:21:33 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Tue, 6 Jul 2010 07:21:32 -0700 (PDT)
In-Reply-To: <7vbpal72vu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150354>

On Tue, Jul 6, 2010 at 10:36 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> This patch does not apply. =A0 What did you base this version on top =
of?

Hmm, I have just fetch the newest version of current git and make a
rebase, and I found that there is no conflict of any patch. Could you
please take a look that whether you are applying the the newest patch
of this thread. Its subject is: [PATCH v2 03/13] add the basic data
structure for line level.

And my log to see:

d0e8b59b04c19419458fd61a9342efba8f849a82 some document update
70188b228b459fc92b740aadbd5dac72c010cb01 add two test cases
bcb75c23a5d46dad69439d60002624f6071ba3dc add --always-print option
99c4697dcc5414ee3b864a7cc2c07cb25be229d9 map/print ranges along
traversing the history topologically
6ccac2635a4e62c2b8129d9e2306f7e8177d9a16 print the line log
c9b90713a844939c2dd3695b5006f83818c6309f map/take range to parent
cdd2b5bfcf0be9021d50b0657d2692cb2538ae0c add range clone functions
0e3bd1b8c52c5d9ed1d597e9248331ac6b484fea export three functions from di=
ff.c
b06f615af36a6c9e4a06406124d3fae8b2cd9a54 parse the -L options
3a3f8ae45ebe56e3be9b2fb1c0e238dd9c284b02 refactor parse_loc
067314e4ad65d8595ad35a6a4e954e0a3da514f1 add the basic data structure
for line level history
c967805c73daf3fb88d242a5b82768f16a1f904e parse-options: add two helper =
functions
e6247e51dc11cc8a133403c55d9dfe8e3ede8723 parse-options: stop when
encounter a non-option
22cff1daaaf3db08b6fed9c7f4c1a289f1dd5d83 Change to debug mode.
5b5275f6e9ca6284ca123f729d5a78f409e448fb Merge branch 'maint'

The master is at 5b5275f6e9ca6284ca123f729d5a78f409e448fb. :-)

--
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
