From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] archive: clarify explanation of --worktree-attributes
Date: Wed, 10 Apr 2013 14:40:30 -0400
Message-ID: <CAPig+cTM=ojKgq4HFenAaquRsR5nXL3mm4O4ZBO5CmwEYqk60g@mail.gmail.com>
References: <CAFGOX=VXifkn4oNkqLLF_WG5Dzf4rjd15EV7C=9a_H9CTM+w2Q@mail.gmail.com>
	<7vk3obpfwc.fsf@alter.siamese.dyndns.org>
	<5165A645.9090300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Amit Bakshi <ambakshi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzwi-0000V3-Is
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab3DJSkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 14:40:32 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:54937 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3DJSkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 14:40:31 -0400
Received: by mail-la0-f51.google.com with SMTP id fo12so742126lab.24
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3Pyj9mYkCGnmXebLYJJxkzkaw8dnztRs0CD69P/0GgE=;
        b=KE0UhLQM6tlmorvH/eILPCogZ49iUIA323HcpwgIdlakfo0//y7aigDq7PedrE7nHq
         +jBpra2hbkQg4fjokozKyGAFfTZJwt8YFgMlD9nTgyME4vCa3koBL3oWvJ2cNXuKF5TN
         xNYh5t8taMiUbLc84nPyVN8i7Ja50Jm2yFnJM58fM045dQu2IbE+RJ4FGJk9/Z/h3Zzw
         3NqtEiVK6A2XuFDaZvH9eStuVhz+CvuBR5haZIX9RnT/vEh1Q6OFiQMFdjPe3bkIRePx
         +KWlOYRp5MYTaLiwTes6vrNr33eBi+Lsv1xptouzzwIWV20I6TAOznmEUC4vIA2zgB4B
         BFyw==
X-Received: by 10.112.199.194 with SMTP id jm2mr1723189lbc.21.1365619230185;
 Wed, 10 Apr 2013 11:40:30 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Wed, 10 Apr 2013 11:40:30 -0700 (PDT)
In-Reply-To: <5165A645.9090300@lsrfire.ath.cx>
X-Google-Sender-Auth: dSdpuNKptXbvHER3VOSiHuOZnGY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220717>

On Wed, Apr 10, 2013 at 1:49 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Make it a bit clearer that --worktree-attributes is about files in th=
e
> working tree (checked out files, possibly changed) and not the curren=
t
> working directory ($PDW).  Link to the ATTRIBUTES section, which has

s/PDW/PWD/

> more details.
>
> Reported-by: Amit Bakshi <ambakshi@gmail.com>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
