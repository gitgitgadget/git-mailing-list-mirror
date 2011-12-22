From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2 1/2] attr: map builtin userdiff drivers to well-known extensions
Date: Thu, 22 Dec 2011 02:47:25 +0100
Message-ID: <CACBZZX4ZC+hkG38mrAwi158CiGQN7BD=U220h1B=ZOH+kNK1Zw@mail.gmail.com>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net> <20111219154938.GA19829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 02:47:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdXlA-0005XG-RU
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 02:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab1LVBrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 20:47:49 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36316 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab1LVBrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2011 20:47:47 -0500
Received: by eaad14 with SMTP id d14so1617814eaa.19
        for <git@vger.kernel.org>; Wed, 21 Dec 2011 17:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IQhOZKt24zs46XwB3EXqMulVXz5CWTZEV2mDiwQO+W0=;
        b=OVp1lHPLkciI/cbotjTZ1I0sDJzio0kyKxBFJozVh9tK52+VsNPofArDqLc8ecU8qA
         1MmH8aEqaFkV665KDFZUBhN+QdlZH5dSHdEH0SWSmDCjvwDPViFP56VfUXVDPDAEWBOx
         pUJCvllmRCfkNUYFVaXi60osybPXvBaDbJovc=
Received: by 10.205.126.18 with SMTP id gu18mr2594838bkc.79.1324518466272;
 Wed, 21 Dec 2011 17:47:46 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Wed, 21 Dec 2011 17:47:25 -0800 (PST)
In-Reply-To: <20111219154938.GA19829@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187597>

On Mon, Dec 19, 2011 at 16:49, Jeff King <peff@peff.net> wrote:

> + =C2=A0 =C2=A0 =C2=A0 "*.perl diff=3Dperl",
> + =C2=A0 =C2=A0 =C2=A0 "*.pl diff=3Dperl",

This should also be:

 *.pm (for Perl module files)
 *.PL (for Makefile.PL)

And it's also very common for Perl code to use, for tests:

 *.t

But that likely runs into the namespace clashing issue all over again.
