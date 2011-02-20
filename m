From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] Introduce CHERRY_PICK_HEAD
Date: Sat, 19 Feb 2011 20:48:26 -0600
Message-ID: <20110220024826.GB17547@elie>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
 <1297916325-89688-2-git-send-email-jaysoffian@gmail.com>
 <7vipwibfc5.fsf@alter.siamese.dyndns.org>
 <AANLkTik7cfihdu5-0pvgkq1u7kVShEqnjzh07T+5pU16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 03:48:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqzLh-0001QR-Df
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 03:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab1BTCsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 21:48:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64831 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852Ab1BTCsb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 21:48:31 -0500
Received: by iyj8 with SMTP id 8so4814782iyj.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 18:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=X9FQjeQHSGTFzef06I8HShnS7ZI250qf5/stZ0pLvew=;
        b=mPgtwtSGVevz1IHjqrj8tPjHjTxc1E2tG6y+3+BUyA/G4EZK7JQie8KbF3Z0QdU3HZ
         iY1nSe7x/uJBk2kjPWQYTdYsn4oNb+6713ZmZNV0sDeGAWB+Ubfd3ezCEZKTG8GTZK8o
         ym7DSV2i+RTiDpg2xVT6paNfJr5RmtC7YPtNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XMfQZ9EtGyI5/pQdVryTIFodr11ufZ8c2LAk2KJr1BwHXt/Qn3xzL54qCSmzrrrdYm
         Tb5dVuG2bE7ayyE0x4qIfuMC2DGa4LoFSHibLR9XH3oFscFPxkT0Qdwu64hA5XkZ4yRp
         OwZ86mpLFZfirIOZnb06bf9rU3d24GyYZF0lI=
Received: by 10.42.8.14 with SMTP id g14mr3031442icg.384.1298170110814;
        Sat, 19 Feb 2011 18:48:30 -0800 (PST)
Received: from elie ([69.209.79.88])
        by mx.google.com with ESMTPS id gy41sm3479999ibb.5.2011.02.19.18.48.29
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 18:48:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik7cfihdu5-0pvgkq1u7kVShEqnjzh07T+5pU16@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167394>

Hi,

Jay Soffian wrote:
> On Thu, Feb 17, 2011 at 3:01 PM, Junio C Hamano <gitster@pobox.com> w=
rote:

>> Micronit: "Please, commit your changes before you can merge."
>>
>> =C2=A0- We are not merging in this codepath to begin with;
>>
>> =C2=A0- I'd suggest rephrasing this (together with "MERGE_HEAD" code=
path) to
>> =C2=A0 something like:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"Commit your changes first before retryin=
g."
>
> This hunk is from Jonathan

I agree with what Jay said --- this is in cmd_merge, so the current
message is correct.  I like your wording ("before retrying") more, but
that seems orthogonal to the topic at hand.  I can send a patch
rephrasing it on top if someone reminds me.

> Okay. In that case, I think when using --no-commit, we shouldn't writ=
e
> CHERRY_PICK_HEAD regardless of whether there is a conflict or not.

Thanks for your attention to detail.
Jonathan
