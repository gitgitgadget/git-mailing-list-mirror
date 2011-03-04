From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 11:23:18 +0700
Message-ID: <AANLkTimG7Hg4YxJbMVaXVkZ1CRb0ttK6RAYEoRQ_4iW4@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com> <7v8vwv927a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 05:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvMYU-0000mP-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 05:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758608Ab1CDEXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 23:23:50 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47077 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758381Ab1CDEXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 23:23:49 -0500
Received: by wwb22 with SMTP id 22so2255680wwb.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 20:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=sOAaO7LeH7ymE64zhut2oonsIa0R5bLX2h03rxM1zZY=;
        b=CelaHLm+MhZtNLBAOc2PZ4k1EHjnKFj1sAPuWBu02YDfPM5WfkmtvkL8O5woXpPBuW
         DiupG58uxiNAknBqi5RJBMpFLnA2cQJXNsLpi5JLi6RoBAehyC5ZJJHiUBR0NJyjVPKA
         zdrDAEJ65xcwSGdPgtMa0voCo6zfHancYAbxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vHPBJl6WtHsGyPnZE6BLMP15JScdKSpuulqhzwsreNI0qkPPuUNNqd4NREcT2UMb6k
         tnAEfgRwUpT7tX//Hu49roikhN4mo33lYwScarKf2Ijuq6t3Igi+XdD6aUWkw65Zi6DN
         bD1epZiK4lMKj3b0iOJUWqjDNX08xkG9PTh2w=
Received: by 10.216.185.142 with SMTP id u14mr169796wem.31.1299212628128; Thu,
 03 Mar 2011 20:23:48 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 3 Mar 2011 20:23:18 -0800 (PST)
In-Reply-To: <7v8vwv927a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168426>

2011/3/4 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0I intend to make 'git init --real-git-dir' move current repo t=
o
>> =C2=A0somewhere else if called on existing repo.
>
> I don't know if that is useful in real life. =C2=A0Do you have a conc=
rete use
> case (like the one I showed an example above) in mind?

Moving .git away from existing repos/worktrees I have.
--=20
Duy
