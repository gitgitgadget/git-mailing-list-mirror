From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sat, 14 Nov 2009 09:59:44 +0100
Message-ID: <6672d0160911140059r78dda7bbvbd3cc67828dc4322@mail.gmail.com>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
	 <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
	 <20091114071946.6117@nanako3.lavabit.com>
	 <4AFDE421.5050307@fastmail.fm>
	 <20091114081040.6117@nanako3.lavabit.com>
	 <4AFE41AF.8050802@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Sat Nov 14 10:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9EUn-0005l0-Uy
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 10:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbZKNI7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 03:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbZKNI7k
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 03:59:40 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43098 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbZKNI7j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 03:59:39 -0500
Received: by bwz27 with SMTP id 27so4207776bwz.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 00:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TUchJ+0HdoNcWhC5y+cAQtR+ErKY4i7efqL7Al7RLJE=;
        b=ao0jubPblnH4QzRceODX12vseF/EFYv8M0ley+fOccwX26HEDfZ+VYcbqgnQxYyvoo
         iNrHmpNnGynSJC0gspCzjVSFd9aCiG5v0RuxBbR0G2MfYCru2ckMDEceHppbNH3wn6oj
         7FqshskNLJdBIXHBmPCMaeyupYXgWLATSnqo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nsSispi1AlCuRhUKBKZkUPVpKK8/JaFCLS+psRoh47t111K4m+tN9AR7lYY09s8xny
         HZl9T+QOQJ6Wwmneq7Kzv5gpgMTicvRC4dRErPgYUmkxlZvP9nxInLbAesLhhtE82dQt
         ziQEj5Otv8LT5Nb6+w8imgK6T6DWcw6huxDQc=
Received: by 10.204.48.131 with SMTP id r3mr1316995bkf.195.1258189184244; Sat, 
	14 Nov 2009 00:59:44 -0800 (PST)
In-Reply-To: <4AFE41AF.8050802@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132863>

On Sat, Nov 14, 2009 at 6:35 AM, Raman Gupta <rocketraman@fastmail.fm> =
wrote:
>
> Ok, another dumb question: since you have now submitted a patch on to=
p
> of my patch, what is the proper etiquette for proceeding? Who
> maintains this patch series until it is committed? Since your patch
> applies on top of mine I can't really make any more changes without
> affecting your patch right? I can't find any guidance in the
> SubmittingPatches document.

I can't answer the questions about proper etiquette, but you *can* do
more changes
if you first apply Nanako's patch on top of your previous changes.

/Bj=C3=B6rn
--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
