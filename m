From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: GIT as binary repository
Date: Thu, 21 Oct 2010 22:19:51 +0800
Message-ID: <AANLkTim6qsUDf5LS7C9o+C92Aqh7CohLLJ=+13BE3Tze@mail.gmail.com>
References: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Wilson, Kevin Lee (OpenView Engineer)" <kevin.l.wilson@hp.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 16:20:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8w00-00040g-8W
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 16:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758188Ab0JUOTx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 10:19:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41458 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756881Ab0JUOTw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 10:19:52 -0400
Received: by ewy7 with SMTP id 7so139371ewy.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K/gnHtImbw+2J8GosGm51WgenUKaw90ZL9F7Gd+GgVI=;
        b=AyIfFT5Yjpf5xlrFVfhsz6LXs9s9qt1GWm7i37tZEIe2dqSWS0d9BVmMfFEimy3+25
         vZTksymuzb3F1lW7+3F8SoDQ5Kf2ex18L9OX1E1FdNT31xFVVlKy+3JPnM4EevfTLmhr
         RgnWXR95LzGUFNDXy8ljkfUeHLptMWnfgrVZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G1XzeeAICZh7BGJ7WGoDzzzhi43tZRi9u/UkhtFMQrJ2aeqFR1Y+MMXUQ36I0Lmh0h
         kzkSsjbnygg8yUyX/AW5P/GO8NlbM19hNxxIvlJjn1UgyrIYrkp2i5qHBwhdt/D+RDzr
         VI+t9GnCd6bVctt/W1g1ANcqiD5j5jspJVNgg=
Received: by 10.213.26.81 with SMTP id d17mr2850299ebc.42.1287670791302; Thu,
 21 Oct 2010 07:19:51 -0700 (PDT)
Received: by 10.213.3.78 with HTTP; Thu, 21 Oct 2010 07:19:51 -0700 (PDT)
In-Reply-To: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159508>

Hi,

On Thu, Oct 21, 2010 at 8:52 PM, Wilson, Kevin Lee (OpenView Engineer)
<kevin.l.wilson@hp.com> wrote:
> We are investigating the use of GIT as a binary repository solution. =
Our larger files are near 800MB and the total checked out repo size is =
about 3 GB the repo size in SVN is more like 20-30GB, if we could prune=
 the history prior to MR, we could get these sizes down considerably. T=
his binary repo is really for our super project build. =A0From what I h=
ave read and learned, this is not a good fit for the GIT tool. Have the=
re been performance improvements lately? Some of the posts I have read =
have been quite old?

check this out:

  http://github.com/apenwarr/bup

It's a modified git system that's purpose-built for large files.
That's just about all the sensible information I can share you with
you.

--=20
Cheers,
Ray Chuan
