From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Documentation: rev-list: fix synopsys for --tags and and 
	--remotes
Date: Sat, 23 Jan 2010 21:10:37 +0100
Message-ID: <fabb9a1e1001231210o16604548kd3bb72b3f9a6ae72@mail.gmail.com>
References: <20100123072627.6509.86297.chriscool@tuxfamily.org> 
	<7vr5pgbnbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:11:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmJx-000691-Jx
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab0AWUK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682Ab0AWUK6
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:10:58 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:52869 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab0AWUK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:10:57 -0500
Received: by pwi21 with SMTP id 21so1485257pwi.21
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=MMP977Eux3nRQGAbkxw8gPaWS7ay/wdA8CuItxsZCXQ=;
        b=Hyem134CTgEDi7a8tlsWKGs82C3YJaMyaNIy7U7Fydycuqkt9QE3kmkOyNMVBojCmS
         gm/6clHzISQQP+d+RBPkuow7IBYkFDhoH7isfvTuIt0RThPOk2HZJlMhea6DQkmI+8r/
         6kYrDUhcRMtBG7/UM4qyDfS1OsuJEDjwWSPBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=NEhUtf/LM+2Rw2CFfzEwu8S/MoXHiItScoHn8xryyulT8fUkVAjP3qJFwd26p6QqcU
         YSgnhcPneguogh93dxu4dDN5f6qCxB64a0Gn+/s289g1W3n80nCtQJgeLSDqmiDxOhOE
         2goug8aRcBLTChq0b2S11lhpFVbPXugdwIEww=
Received: by 10.143.21.40 with SMTP id y40mr3129501wfi.348.1264277457354; Sat, 
	23 Jan 2010 12:10:57 -0800 (PST)
In-Reply-To: <7vr5pgbnbb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137859>

Heya,

On Sat, Jan 23, 2010 at 21:04, Junio C Hamano <gitster@pobox.com> wrote:
> I had to stare at lines before and after the change for two minutes to
> notice what is being fixed ;-).

To save others the time: the = signs were moved to inside the brackets
where they belong, since the old documentation says that --tags= is a
valid argument.

-- 
Cheers,

Sverre Rabbelier
