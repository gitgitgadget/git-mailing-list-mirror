From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Sat, 26 Jun 2010 21:40:24 +0800
Message-ID: <AANLkTikq4z5Qs6UUnSh8T9GjVTJBdH8Wy3djIIOlrs2Y@mail.gmail.com>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
	<1277418881-11286-1-git-send-email-avarab@gmail.com>
	<7v1vbvkorf.fsf@alter.siamese.dyndns.org>
	<AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
	<7v1vbukcu8.fsf@alter.siamese.dyndns.org>
	<20100626061305.GB10290@coredump.intra.peff.net>
	<AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 15:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSVcV-0003fZ-OQ
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 15:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab0FZNk0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 09:40:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57159 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab0FZNkZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 09:40:25 -0400
Received: by iwn41 with SMTP id 41so2911426iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aZ8MUw3NcaPqsXTxSn2yIVYjqBC3lBZ7/P6UuBN53Dk=;
        b=am1n9zfFNbmv9aR00hNyRtaQEFQ2qoCEvOOAmz1PdAbYqhcJ0TjofnazHq7KrS3+Y7
         +TBvF5a5jvuHmYRp581Y2LLFP3MEko+Mr+p51y1iObL9awO3MiGF16+qMxrjFCk6W5BC
         JkWd73LC3vlQfu5BImerroDtXoqTj+msL68bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KNJ+dnRFrak3lnd3Xe72VOM+sxPzdJSmwRYngIh9huWFc6+Utd1fNz9Vm+jFl9hzO+
         0++QoiCFGBFOizr6YWqFZimOmRGL7WuvklvoNm8iEAUtxRbqPR+vpSs6VWfPzA7jkD74
         8J7+FuhEM7+Y0clVXK7wBziG9rXHRcHM62F1A=
Received: by 10.231.167.69 with SMTP id p5mr2367110iby.126.1277559624218; Sat, 
	26 Jun 2010 06:40:24 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Sat, 26 Jun 2010 06:40:24 -0700 (PDT)
In-Reply-To: <AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149756>

Hi,

On Sat, Jun 26, 2010 at 8:14 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> But it sounds like we need some general discussion on what stdout and
> stderr should be used for in Git with regards to progress messages,
> errors and other similar things.

I'd say - submit a patch for the style guide with your proposed
guidelines on stdout and stderr usage.

--=20
Cheers,
Ray Chuan
