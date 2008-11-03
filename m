From: "Peter Teoh" <htmldeveloper@gmail.com>
Subject: Re: error: non-monotonic index
Date: Tue, 4 Nov 2008 07:47:33 +0800
Message-ID: <804dabb00811031547kee54cap104ef639213cf161@mail.gmail.com>
References: <804dabb00811021832k28276bf7ke0146a8bbd648574@mail.gmail.com>
	 <20081103085105.GA13930@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:48:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx9AC-0003XT-62
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 00:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYKCXrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYKCXrf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 18:47:35 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:10750 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbYKCXre convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 18:47:34 -0500
Received: by an-out-0708.google.com with SMTP id d40so146997and.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 15:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=V7dXpxayt3aSnI5Btri7kf8jyh0N14qqu1dHzSsG0cA=;
        b=E7YoamyEmcJLP0eUNAzYZdNTDgEkBu8B2di4xETQciyP191RCTLROFhr2aq3M/fN62
         bKeTr3nNi1PKo0uZPtWHJnRf5dVrA7dhUcw2yYsDEReN14pEnxqjqKap3As5nvMZ7TT2
         g6ujU0aGBa06gi2VLO6QQDhpz0Izr8ijtayU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QuDg0rkxDiDoHc7k2VJwPoJPZDhd9svsn/Y9tVJx6DsV14mpbMo5rYRpgQr8lVGf+A
         7KqGx8/+r4MWf55g5xfubteVRVcz4uBI/RmjqHWnOd8aDylvJmdZ6qTUOu9mqWwir6L0
         dGzl+8H0eKBV0F06DBTE+C1QmWOdEYLUX6930=
Received: by 10.100.123.11 with SMTP id v11mr309497anc.71.1225756053172;
        Mon, 03 Nov 2008 15:47:33 -0800 (PST)
Received: by 10.100.33.2 with HTTP; Mon, 3 Nov 2008 15:47:33 -0800 (PST)
In-Reply-To: <20081103085105.GA13930@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100012>

Thank you Pierre,

I installed a new copy, now seemingly working, thanks a lot!!!

On Mon, Nov 3, 2008 at 4:51 PM, Pierre Habouzit <madcoder@debian.org> w=
rote:
> On Mon, Nov 03, 2008 at 02:32:44AM +0000, Peter Teoh wrote:
>> I git pull and got errors, then git repack and pull again......the
>> error increased....what happened?
>
> what is your local git version and the remote one ?
>
> It's likely that your local git is not aware of packs v2 which is now
> default. You want to upgrade your local git, if you're on Debian etch=
,
> updates have been pushed in the last dot release. Or you can even use
> git-core from backports.org which is even more up to date (1.6.sth I
> guess).
>
> --
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                                http://www.madism.=
org
>



--=20
Regards,
Peter Teoh
