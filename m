From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] updating examples/git-merge (plus a builtin/merge fix)
Date: Tue, 17 Aug 2010 07:46:12 +0000
Message-ID: <AANLkTikf-do4nyQO=W93BxKxDekQJpExLtop__tz1n8o@mail.gmail.com>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 09:46:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGsS-000667-Fo
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab0HQHqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 03:46:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62113 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab0HQHqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 03:46:13 -0400
Received: by ywh1 with SMTP id 1so2287479ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LqYs7ztm+dzJNaimjT/dWCYS6JNsHbTXNy9QnGKwups=;
        b=T7k1w8UWMzrOaIEdMBqRk3otmLRxhS/x9Z2iY1efxqMYa4TznjMPpXUotslOa9oszr
         U2SzjvBKNz6cqZsmjk7kN8NCnwx6kIZdNZ1WB0aEGJsdZqhv5m/5UaU+rKl/8SZkPD9N
         IW7rXdj8Y9ZHDG0ERLsQTOrxKDtiVBJfOaxJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AWjlNzlU3b7tA3kOuLnookWwwM2odPD3MjOpIQQzXEnpXEdI/VRhIcmqglT7M9TODA
         P5QbiQtV7YD9n+xYK2hp7RR5i1BCjO5gosDzsoHFOm8IVbhMz+aQYJvp4KhNSkc0wZuG
         2b7PPEhdydM00xSbCKggGFWyqfJt1HDVasA1o=
Received: by 10.231.148.20 with SMTP id n20mr7079477ibv.196.1282031172795;
 Tue, 17 Aug 2010 00:46:12 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Tue, 17 Aug 2010 00:46:12 -0700 (PDT)
In-Reply-To: <20100817065147.GA18293@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153731>

On Tue, Aug 17, 2010 at 06:51, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> While preparing to make some minor "git merge" changes, I noticed tha=
t
> the old merge script does not pass all tests any more. =C2=A0Since it=
 can
> be easier to prototype in shell and then port to C, I think that is
> worth fixing.
>
> Of course this is not urgent at all.

> Patches 2-7 are minor test changes. =C2=A0They are early in the serie=
s
> to give flexibility about when to merge them.

Those all looked good, thanks for tackling that.

> Patches 8-10 expose functionality used by merge when handling octopus
> merges.

You mean 9-10, 8 looks good. I don't have the familiarity to comment
on 9-10.

> Patches 12 and later are ports of various patches to builtin/merge.c.
> I did the bare minimum to make tests pass. :)

Those also look good to my untrained eye.

How do you run the tests against git-merge.sh? Is there some make
target to use it instead of git-merge.c, or do you manually move it in
place?

If it's the latter a switch somewhere to run the test suite against
these .sh alternatives might compliment this series nicely.
