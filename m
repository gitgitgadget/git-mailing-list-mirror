From: Mark Struberg <struberg@yahoo.de>
Subject: Re: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 18:51:36 +0000 (GMT)
Message-ID: <585748.13758.qm@web27802.mail.ukl.yahoo.com>
References: <81b0412b0909271144o26743e05uac3132cdc5b530b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 27 20:53:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MryqV-0008Oj-Vb
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 20:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbZI0Sve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbZI0Svd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 14:51:33 -0400
Received: from web27802.mail.ukl.yahoo.com ([217.146.182.7]:38608 "HELO
	web27802.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751107AbZI0Svd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 14:51:33 -0400
Received: (qmail 14047 invoked by uid 60001); 27 Sep 2009 18:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1254077496; bh=grh/0cDO8lEtMKPPJXuHtPH/tT1JHjZhPLZSONGq0Bw=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=b0Gpi//oATCpgNOtDVjSZ4UOes6dcwMxftt6+gSjg9Dp3ahpNqGPhtyyvGDy04e5IO56/zXyJHtigYoCWOxR12RCWPb9oC6vzaPFBL0RMlti1+rBH4gJofWUZCNoxdNoCVaRbDNth6t4Px1tHTqRqygKDW79E8RmATYF/u8Yb94=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1d0Jmzp2wiOLDlxJcm4gGwK6RqGIkUFg2UOppbNw/3V9dhpnWgMVXg62vjZt4T08v71nEN4BPzI1knp9/xbqLFy7qE2OCfuTgIbia9KznMnQ5q/xC2wUpBk2uIJLH9SVp3kIU7Z2XBcy8P9YMVq6muwNUoQFcWpIcHw80oHcg6I=;
X-YMail-OSG: BvexOuUVM1kqKMKW_8G5TjnCYcbQnkoRVD4vspUrwyO6svzdyb5bjQAXFXpBSPW1GZgNcDyXa6givnmE4VFVWHXzsBlCPaUvg_f28r9d0y7CM48f65zwZLIE3nePkt7nH4n0uojoUAoJZF4XvYz3uvhIKDt2TjG34xJ3FImWCQAF4KjxOzjMa.Cd6Trol2G7sOGlajUUOn62di5wSu4EwQco0GU5YoJ5ZP_IYHE6pUwTagZBEBbl.ig393dHAzzZw_4DI3Caq3REX_sXIkVpfmMxWB9AxLhZDz1P9CbRsfOgf0uhmO3AFlQ-
Received: from [62.178.39.60] by web27802.mail.ukl.yahoo.com via HTTP; Sun, 27 Sep 2009 18:51:36 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.3
In-Reply-To: <81b0412b0909271144o26743e05uac3132cdc5b530b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129213>

Another thing to consider: For what kind of project/language do you nee=
d git? What build tools are you using and how good is the integration i=
nto both git and hg?

LieGrue,
strub

--- On Sun, 9/27/09, Alex Riesen <raa.lkml@gmail.com> wrote:

> From: Alex Riesen <raa.lkml@gmail.com>
> Subject: Re: Deciding between Git/Mercurial
> To: newsgroups@catchall.shelter13.net
> Cc: git@vger.kernel.org
> Date: Sunday, September 27, 2009, 8:44 PM
> On Sun, Sep 27, 2009 at 20:10, Anteru
> <newsgroups@catchall.shelter13.net>
> wrote:
> > Yeah, well, the main question here is actually: Is
> improved support for
> > Windows one of the goals of future git development, or
> is this a
> > complete non-issue?
>=20
> I just hope it is not. Improved Windows support mostly
> means lots of dead code (and that's the best outcome),
> which no other platform can use.
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
