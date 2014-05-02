From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 16:18:57 -0500
Message-ID: <53640bc1ee6eb_135215292ec95@nysa.notmuch>
References: <20140502000208.GB28634@odin.tremily.us>
 <5362e8b09aba1_429131b31038@nysa.notmuch>
 <20140502011004.GD28634@odin.tremily.us>
 <5362f1755f2a9_d1310572f0fa@nysa.notmuch>
 <20140502145433.GF28634@odin.tremily.us>
 <5363ea28d3c14_70ef0f30c94@nysa.notmuch>
 <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 23:29:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgL1a-0000sy-DK
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbaEBV3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 17:29:37 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39808 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbaEBV3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 17:29:36 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so5824591oag.39
        for <git@vger.kernel.org>; Fri, 02 May 2014 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Nz90zBWx+6+kGy7etpJnnA2ROYKhcxwx0gw7G0TJdnU=;
        b=QXDN0kfTJSwSSIRq8W/o462IGL3LVedTNy3N51sw1GenZuDTIz9kzpbKtNQX9QInAX
         wg4OKaTHNhVSRGvjyRGudDIzuGxSSwFUrF+fq7Z7ky6yIt8GejMl9/dbdq6Yyd74IF5F
         M7SY2sZXD7ol5cU+oIz2s3yIP0mlzP+tLe6ulCPZ5NrLfVGI2gBOn0uWYeAULjwkA8KP
         fhDUoI84/UuS5muCYzaxQDz+ZJ6mm5sK5tkl4vVofv9gF5iUWyX0264J1lJfRlUfVrTB
         vqcYdIDodXixoTgo1x1y54Z6pyYjNPclZrn3crjiHCnUSnp01zzWZ69+aVN/PP9NCBCh
         iVbQ==
X-Received: by 10.60.176.39 with SMTP id cf7mr19129387oec.45.1399066176143;
        Fri, 02 May 2014 14:29:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm803407oec.0.2014.05.02.14.29.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 14:29:35 -0700 (PDT)
In-Reply-To: <20140502211305.GN28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247986>

W. Trevor King wrote:
> On Fri, May 02, 2014 at 03:34:34PM -0500, Felipe Contreras wrote:
> > W. Trevor King wrote:
> > > On Fri, May 02, 2014 at 02:13:25PM -0500, Felipe Contreras wrote:
> > > > It would matter almost exactly zero.
> > >=20
> > > Some folks have explicit merge policies, and deciding how much
> > > that matters is probably best left up to the projects themselves
> > > and not decided in Git code.
> >=20
> > Let's make some fake numbers to see around how much this would matt=
er.
>=20
> The point isn't that this is a huge flaw, the point is that we should
> be able to configure Git to match sane workflows.

The point is that we are tainting a discussion about how to improve the
defaults for the vast majority of users, and given Git's history, the
most likely outcome is that nothing will happen, neither for the
majority, nor the tiny minority.

> Saying =E2=80=9Cthat's unlikely to happen=E2=80=9D doesn't solve the =
problem that some
> newcomers have trouble matching their project's desired workflow.

% git config --global pull.ff false

Done.

> The goal is to train them to do:
>=20
> >   % git config --global pull.mode none
> >   % git fetch
> >   % git merge --no-ff
>=20
> The 'git pull' (with 'none' mode) explainer just helps retrain folks
> that are already using the current 'git pull' incorrectly.

If you are going to train them to use a configuration, it should be:

% git config --global pull.ff false

--=20
=46elipe Contreras