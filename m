From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] get_sha1: support ref^{/regex} syntax
Date: Mon, 13 Dec 2010 10:10:11 +0700
Message-ID: <AANLkTik2M=PPCXqtepRhntVYofrA0PUgzBLvdMNeeP5P@mail.gmail.com>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com> <1292209275-17451-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 04:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRyoh-0002J1-3l
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 04:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab0LMDKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 22:10:43 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54596 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab0LMDKn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 22:10:43 -0500
Received: by wwa36 with SMTP id 36so5864923wwa.1
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 19:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BKAe3aGkM91VVvZtWXCJQkwDLd0ofXT1XvcAl/qSzyk=;
        b=Bhc0Mxk5ds4L0Nx9OZyafTGY69HJEvDRc0xbEzjIge7XFbTO95GcrDJ+rOCLq6i/Oc
         lSzIcH9M1qVtrxes9eNsm4rtT52CTr3F2S36vLO58JMHcYPIxvbmOyN0bwYmtrOQxPGj
         mKPqmDA9aXhWA1i2E3bMdKcwueZAFb0ABoLyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GKa8pyqYl6NqQyB90vyYI32e/Qs04pucuDsZnP3nqfVKSHd3W8gbEYAgsKKLxLsFVH
         xw69hqRL0Rl4Nuh6ScXXpXzVeNVcnem2FOlqkLvVFYcF6QX2pEwB0Vet3H5KJ8wIJM9C
         3cLO9hmQqLfFJg86Cf1qUk1PJk0JrEAxFgBiE=
Received: by 10.216.30.144 with SMTP id k16mr2455345wea.19.1292209841867; Sun,
 12 Dec 2010 19:10:41 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sun, 12 Dec 2010 19:10:11 -0800 (PST)
In-Reply-To: <1292209275-17451-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163508>

2010/12/13 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> This works like :/ syntax, but only limited to one ref.

Argh.. I read Jonthan's comment too late. Maybe "limited to one commit
tip (of a DAG)"?
--=20
Duy
