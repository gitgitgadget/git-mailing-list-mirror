From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Tue, 17 Aug 2010 21:37:26 -0500
Message-ID: <AANLkTi=y5vr25cJMfV=7KisCB7R-s7YVonc-7QZemO0j@mail.gmail.com>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
	<injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
	<AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com>
	<20100817232838.GH2221@burratino>
	<AANLkTim77g+z3KXyCOy4G-caCncyFa0FfqPMFatZnwLN@mail.gmail.com>
	<20100817233717.GJ2221@burratino>
	<AANLkTim+YQHxkY6WWF4Yfo74jZnAE8ufdnabp9mneBgu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 04:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlYWz-0003rd-8g
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 04:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775Ab0HRCh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 22:37:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58722 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab0HRCh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 22:37:27 -0400
Received: by ewy23 with SMTP id 23so58146ewy.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 19:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=49g+KF+1ScVupL7GTtbWq9ofZw3u7XTjeljlU9LNI4E=;
        b=a9Xl4FcmwhqPH5exQdab/5y2UeR0XF8Ogme3Yn2Tkx4BxoxH8FgHOgqpUmJ1fOiMRM
         +/2mFLERJEFH3HhXm2IUfo4d1Sa18g8oBebZU4y5Tvx7m59J7WrkiXM/maqCeI3w+iOd
         rqbz2TmE+ONGxHYE1JjzAUUy6XWjdlXDhfvQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gM+zigx0x54kNtPWXtliy1FGfpZGmVLT82yt5XzayrsVt4JF3AEFKkElV+3MXV2BNg
         Gd1Q6r2xV8Ln5VhR0pSirgpjwqjk0bQspJDJrj9vyGb99GMFE1qepZ0yxsyb2QdFEOiN
         aFRDxyrkZYzlV/8JBgGhOeJ0FvRc89/nBvtjY=
Received: by 10.213.4.73 with SMTP id 9mr2662280ebq.5.1282099046421; Tue, 17
 Aug 2010 19:37:26 -0700 (PDT)
Received: by 10.213.114.148 with HTTP; Tue, 17 Aug 2010 19:37:26 -0700 (PDT)
In-Reply-To: <AANLkTim+YQHxkY6WWF4Yfo74jZnAE8ufdnabp9mneBgu@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153804>

On Tue, Aug 17, 2010 at 7:10 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Tue, Aug 17, 2010 at 18:37, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> I see. =C2=A0Maybe this is fixed by v1.7.2-rc0~33^2~1 (Makefile: add
>> PYTHON_PATH to GIT-BUILD-OPTIONS, 2010-06-09) from later in the
>> same series.

Well not actually the same series.  If I recall correctly, the
original version of
this 'skip if python vers...' patch was replaced by a resend of two pat=
ches and
one of them did the' propagate PYTHON_PATH to GIT-BUILD-OPTIONS' thing.

I think Junio ended up fixing up the original patch by hand, and the PY=
THON_PATH
bit got dropped.

Later on I resent it.

> Ah, correct. So that should have gone before this one. It works if I
> check out and build that one. Thanks.

Also, note that the test should complete successfully if run via 'make
test' since
PYTHON_PATH is exported in the Makefile.  That's why I didn't notice th=
e
flaw at first.

-Brandon
