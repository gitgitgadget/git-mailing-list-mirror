From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Documentation: Improve revision documentation
Date: Mon, 5 Jul 2010 17:26:06 +0000
Message-ID: <AANLkTinEHbNFv-x1e4f6Jfi7sodNGSlKIPJMctFDSG7k@mail.gmail.com>
References: <cover.1278346173.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 19:26:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVpR3-0004j4-Rq
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 19:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab0GER0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 13:26:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49486 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0GER0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 13:26:07 -0400
Received: by iwn7 with SMTP id 7so5699336iwn.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4hKGDkQI7vs0XhFWHmTXremK0ifVExUD/V3datMXNOY=;
        b=eYG2A6jxwaLgDGm0nSaYYOqNZ71Bgu7PDffspB/X9Rc4hgHC9a6Ck1xFtCBzmHYQyg
         1tKGlcg3zks/a+U6kI3y2mH09r3Ld4OcgYWqpSSfwGtxm4L2DqGsh4kKcDJ6UgLKzutr
         eL/pXx4Ynt3qa1PNxyGzdmpmJHLUtbgZzub6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aNAP9X5rWJBGlFQp/3nRXlLpgfhnIcfk9+7z7lPZ++f8wbAB6ZtWRQcZIwHl67eHWX
         zHc/jS6nJFMJZ6Y9krj88LXUtVDzvURDAYNB5kxFObJ5QgtdSATjgPv1SHc6h4Y26lPn
         XkzzTyc3bjK5rtQFOI06x6jp2W/JhDivUsOTU=
Received: by 10.231.192.144 with SMTP id dq16mr4065607ibb.28.1278350766564; 
	Mon, 05 Jul 2010 10:26:06 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 5 Jul 2010 10:26:06 -0700 (PDT)
In-Reply-To: <cover.1278346173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150278>

On Mon, Jul 5, 2010 at 16:11, Michael J Gruber <git@drmicha.warpmail.ne=
t> wrote:
> This mini-series sets up a new gitrevisions(7) man page so that peopl=
e
> looking for revision syntax don't need to try to find it in
> git-rev-parse(1) which is cluttered with a lot of unrelated stuff (it=
's
> plumbing after all).

I like this series a lot. I often forget what our revision behavior is
and whether it's documented in git-rev-list, git-rev-parse or
something else. Then when I finally find it in git-rev-parse I have to
page down the manpage to discover it.

This is definitely something that should be standalone in
gitrevisions(7).

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
