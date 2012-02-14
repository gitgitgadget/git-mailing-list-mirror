From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] test: check that "git blame -e" uses mailmap correctly
Date: Tue, 14 Feb 2012 23:41:07 +0200
Message-ID: <CAMP44s2M8Ava6xyKX32h9+pbxG+zq1wH1RkdWwfNsZMzcVQEmw@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214203603.GD13210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:41:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQ7f-0006Ga-1r
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760610Ab2BNVlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 16:41:10 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61510 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755490Ab2BNVlJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:41:09 -0500
Received: by lagu2 with SMTP id u2so427625lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zrH2y7IsRxeDUrzauY/jiMncQHSflyZST/gILEIj3vY=;
        b=cktHFlnpFqTzwPAI/HoHJRsp9Zw1+yCcHfwJQWiGu8ECuNSiePI8LwtVSKo6dE2rVd
         qZYflqcZrcPPxPzyB5oD009bdZfjMMZ8xN/LZMTF+U0N1+sQTlXOPQc0OzKrUYcUP4KC
         uZahIth188uJ3qW4KJVIdhqE+AGf+tORkzDBc=
Received: by 10.152.123.68 with SMTP id ly4mr15651004lab.13.1329255667750;
 Tue, 14 Feb 2012 13:41:07 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 13:41:07 -0800 (PST)
In-Reply-To: <20120214203603.GD13210@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190763>

On Tue, Feb 14, 2012 at 10:36 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>

> test: check that "git blame -e" uses mailmap correctly

I wonder what extra information is in that text that is not in my
original "t: mailmap: add 'git blame -e' tests". I guess all tests
'check' something, and the purpose is to make sure things work
'correctly.

> Until f026358e ("mailmap: always return a plain mail address from
> map_user()", 2012-02-05), git blame -e would add a spurious '>' after
> the unchanged email address with brackets it passed to the mailmap
> machinery, resulting in lines with a doubled '>' like this:
>
> =C2=A0620456e6 (<committer@example.com>> =C2=A0 2005-04-07 15:20:13 -=
0700 8) eight
>
> Add a test to make sure it doesn't happen again. =C2=A0This reuses th=
e test
> data for the existing "shortlog -e" test so it

> also tests other kinds of mail mapping.

'Also' is a keyword that strongly denotes this patch is doing more
than one logical thing. My patch adds those checks *independently* of
the fix on f026358e, so it's truly logically independent.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I did not sign this.

--=20
=46elipe Contreras
