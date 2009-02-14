From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCHv2] git submodule split
Date: Sun, 15 Feb 2009 00:13:51 +0100
Message-ID: <bd6139dc0902141513k4316f43h90b652b71e28397a@mail.gmail.com>
References: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
	 <1234578258-48870-1-git-send-email-git@randomhacks.net>
	 <7v3aeh3a84.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902141245080.10279@pacific.mpi-cbg.de>
	 <431341160902140611x69a915e6lc3ee482f1ca66dc8@mail.gmail.com>
	 <alpine.DEB.1.00.0902150000140.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Kidd <git@randomhacks.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 00:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTjD-0002q0-SY
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 00:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387AbZBNXNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 18:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756623AbZBNXNz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 18:13:55 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:42023 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757373AbZBNXNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 18:13:53 -0500
Received: by fxm13 with SMTP id 13so4644650fxm.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 15:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=JkjVsedSVvPVcU2ylH7rTlX0JvD+7OVZtOd1fKTIZkc=;
        b=Ktk5kh7PO1lbYhiu6vDruFY13tJXRq/krDF20palhZygdt0wx90TH/RqjFNhIj5XMW
         VJ1A/fBZMdBu4HVLwzXpeYPBF7tHLCT34uaZjx3c7gVoT6FqwO/3ztIbQ4oGVP6tdmWq
         iRNnJEE5kBEUxO1U6rE+Hu6vyqhTI14NW755s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=S8qOUrW8Jn9zsnJPRh23A0Y+F+FshrAlUH4QyonU7YsYOsTzxKoQEAmcm/8Gyskwa/
         m04G19hFKLK3TcskyRItcGqYeWuBrgQYNydjhqfZgx5+J0N+gk+1S8OStD13NiM/3lg/
         R0n+hYmGnxQo7EeLgdUU54pbVHzkxr9lCSb6g=
Received: by 10.180.255.1 with SMTP id c1mr1306351bki.36.1234653231299; Sat, 
	14 Feb 2009 15:13:51 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902150000140.10279@pacific.mpi-cbg.de>
X-Google-Sender-Auth: 66723099fc8f7cb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109951>

On Sun, Feb 15, 2009 at 00:01, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> That is the problem.  IIRC we do not have a testing framework in contrib/.
> Indeed, we would not catch breakages in contrib/ at all.

I recall a patch about getting 'make test' to work in /contrib?

-- 
Cheers,

Sverre Rabbelier
