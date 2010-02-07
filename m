From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: fix Gmail workaround 
	advice
Date: Sun, 7 Feb 2010 13:01:13 -0500
Message-ID: <76718491002071001l7dee7c4fr64cf2e57072b184@mail.gmail.com>
References: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Aaron Crane <git@aaroncrane.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 07 19:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeBRv-0005aJ-2Y
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 19:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607Ab0BGSBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 13:01:15 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:40882 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab0BGSBO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 13:01:14 -0500
Received: by iwn12 with SMTP id 12so6114082iwn.26
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ERcLu3XEVgoCuOW96ZuuEWnSvlSZ7446VFMAK/IQIwk=;
        b=RtMSHHG02Gc5U3D9pWSUX00xt+z4Qz9bK4HnmNf0p2IJ5qMQ+Yd6rVJAWsvBR0W4w7
         JqrvJbEEI/iXIJFEDGalxovGNYPb4Hd/Dbf3qrt5kL6BrTgWVGk2CgtW4HXRdzyJpdTI
         23+8fw/zfnwfM3hOaY5peFmCa+bfOB1Vbt0+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QUgJzlh+ZYybWhwkTGkpr6x4RwSEIxxOHqLHVgGCbzlEUYZZu515uyM4atSLneGHko
         zg6FCNBg+AUhZn4sEMnofwbp3a3M5Rxmo43sh9nxH/0RmrHzBtw5i6447qKP01t+umNS
         +x2wyL3YpyQFaLLFd+TJSUxAe1MCFMuRJLQ90=
Received: by 10.231.145.196 with SMTP id e4mr3662909ibv.54.1265565673982; Sun, 
	07 Feb 2010 10:01:13 -0800 (PST)
In-Reply-To: <1265555642-40204-1-git-send-email-git@aaroncrane.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139242>

On Sun, Feb 7, 2010 at 10:14 AM, Aaron Crane <git@aaroncrane.co.uk> wro=
te:
> The suggested approach to dealing with Gmail's propensity for breakin=
g
> patches doesn't seem to work. =C2=A0Recommend an alternative techniqu=
e which
> does.
>
> Signed-off-by: Aaron Crane <git@aaroncrane.co.uk>
> ---

Thanks for writing this up. See inline.

> +However, "git send-email" needs the Net::SMTP::SSL Perl module to se=
nd to
> +TLS-encrypted servers. =C2=A0On some operating systems (like Mac OS =
X with
> +MacPorts), it may be hard to install that module. =C2=A0In such case=
s, the
> +third-party "msmtp" program might be easier to install.

Neither is harder to install than the other, I use msmtp primarily for
historical reasons (git didn't used to support SMTP over SSL/TLS) and
because it doesn't prompt me for my password. :-)

So I'd just say:

"Note that "git send-email" needs the Net::SMTP::SSL Perl module to
send to TLS-encrypted servers. =C2=A0Alternately, git can make use of t=
he
third-party "msmtp" program like so:"

Thanks,

j.
