From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2011, #05; Fri, 19)
Date: Sat, 20 Aug 2011 19:11:14 +0700
Message-ID: <CACsJy8Ch2b-8trK44JaeegVyYAHq-ocez+_TAUChNb3EX3F3MA@mail.gmail.com>
References: <7vsjox11tr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 14:11:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QukP0-0002MI-6h
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 14:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615Ab1HTMLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 08:11:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50334 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab1HTMLp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 08:11:45 -0400
Received: by bke11 with SMTP id 11so2759038bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UBQwhePuJnIFdYA8RgemTKQECmZZ6XpkSGrv3Qq53uM=;
        b=DDTUwMSdl9X9Gcp2CWB/91iBXDtkquC8REJ9Xzo3j8c1ID00lu8flb0eFOtAitdPjz
         0OQPAt9VwOJSiEsHQXxD1pnmbwAwcFwJF5dJ8xzTyvk38AYdv7VQ5mMxOMWPSbIfvGVL
         RVU7d0QHh22hRM4P7FmC1kXQdjxiLGOGbamag=
Received: by 10.204.150.193 with SMTP id z1mr161046bkv.123.1313842304137; Sat,
 20 Aug 2011 05:11:44 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Sat, 20 Aug 2011 05:11:14 -0700 (PDT)
In-Reply-To: <7vsjox11tr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179759>

On Sat, Aug 20, 2011 at 5:19 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * jk/add-i-hunk-filter (2011-07-27) 5 commits
> =C2=A0(merged to 'next' on 2011-08-11 at 8ff9a56)
> =C2=A0+ add--interactive: add option to autosplit hunks
> =C2=A0+ add--interactive: allow negatation of hunk filters
> =C2=A0+ add--interactive: allow hunk filtering on command line
> =C2=A0+ add--interactive: factor out regex error handling
> =C2=A0+ add--interactive: refactor patch mode argument processing
>
> Needs documentation updates.

And tests, and its user "git add". Yeah, I'm getting to that.

Sorry it takes long time because I wanted to bring this feature to
diff machinery so that I could filter hunks with "git diff
--pickaxe-hunks -Gregex" and reuse option names for "git add -p". It
turns out very intrusive changes to split/merge hunks, so I dropped it
and will go back to simple "git add -p" changes.
--=20
Duy
