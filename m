From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] pull: introduce a pull.rebase option to enable --rebase
Date: Sun, 6 Nov 2011 10:23:28 +0100
Message-ID: <CAGdFq_hpp=NTJxYM=MNQOyGz73cRcxxWpYw93agDNgP72NAduA@mail.gmail.com>
References: <1320507358-3407-1-git-send-email-avarab@gmail.com> <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 10:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMyz9-0002QM-Qi
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 10:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093Ab1KFJYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 04:24:11 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38694 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1KFJYJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 04:24:09 -0500
Received: by ywf7 with SMTP id 7so4117736ywf.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 01:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Mli8F0lYMZBJFR4UMNUZQZEGX0lkZ8SSeu+3wVxOygk=;
        b=s1mGJmiYermh3YymoRkqoDPI2tMxd1yuNElBgWReiSaprvSP+2wFK6Slw4twjdaYq0
         hOVQqnZoyR1SdBcoUz/q0QCXkEoAlzPOkYvE1hvKho9EZRwgvQkcvfv080OSvrQg+4Xo
         i8wwNhNTNgDq3QtbcSl9Iu33YRjBH8nsNce9w=
Received: by 10.182.45.102 with SMTP id l6mr1363577obm.0.1320571449123; Sun,
 06 Nov 2011 01:24:09 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Sun, 6 Nov 2011 01:23:28 -0800 (PST)
In-Reply-To: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184906>

Heya,

On Sun, Nov 6, 2011 at 08:47, Junio C Hamano <gitster@pobox.com> wrote:
> I see many reviewed-by lines, but what kind of review did this patch =
have,
> exactly? It seem to break its own test (branch.to-rebase.rebase shoul=
d
> override pull.rebase).

We looked at the patch the same way one would on list, and I assumed
that the tests passed. =C3=86var, did you sent a wrong version by accid=
ent
perhaps?

> Thanks for other topics from the Amsterdam together, by the way. I di=
d not
> comment on them individually but they looked mostly reasonable from a
> quick glance.

Thanks.

--=20
Cheers,

Sverre Rabbelier
