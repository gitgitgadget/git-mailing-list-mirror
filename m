From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: git blame with valgrind massif
Date: Tue, 11 Dec 2007 22:50:53 -0200
Message-ID: <b8bf37780712111650i1b291cbaneea5efd16b92cb8b@mail.gmail.com>
References: <9e4733910712111257h20a4a916gd4747e816e4706ff@mail.gmail.com>
	 <20071211212052.GC29110@artemis.madism.org>
	 <9e4733910712111345i23d86a85jfedb4f37f20a5b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pierre Habouzit" <madcoder@debian.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Foj-0007B6-Nx
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 01:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbXLLAu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 19:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXLLAu4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 19:50:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:30244 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbXLLAuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 19:50:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so443049ugc.16
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 16:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qdCinLTTCxdT1YqqfuAYH1GqpyFfFtxjgPqvW+HpQLo=;
        b=RfRn3wLuDZ9zViO4fRoO95zLtiy6xeAtj9UOGvEtmTIeQhPXJLqN8BODNOAWKJS3TU+c4Fa+KtV0L1DNrXq8VLO/Okyb0qecFo6vJvC2VMpGRQimdYILmKK409nIHOHsoBv4VlHLXYiUvZWyghgv8vwlbjf5nRR41YlZqcXztrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gWlxepHFkp/M6MRiO/a47KFeQeAgPiEdaEpdzWRiqFOKxlzDe4QTIKuAhGQHZ7zrFYNicuy+sqZj6r8+oU07kfCn3SRrCewBOx06+z8ehFt+6sHJu9cRU93XQoyxGjFTXCU4HvV6meAz4zGTXV2mOl74iDz13V4cM1vay2sUNPw=
Received: by 10.78.175.14 with SMTP id x14mr62283hue.7.1197420653397;
        Tue, 11 Dec 2007 16:50:53 -0800 (PST)
Received: by 10.78.100.6 with HTTP; Tue, 11 Dec 2007 16:50:53 -0800 (PST)
In-Reply-To: <9e4733910712111345i23d86a85jfedb4f37f20a5b0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67977>

On Dec 11, 2007 7:45 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 12/11/07, Pierre Habouzit <madcoder@debian.org> wrote:
> > On Tue, Dec 11, 2007 at 08:57:24PM +0000, Jon Smirl wrote:
> > > I ran:
> > >  valgrind --tool=3Dmassif --heap=3Dyes git blame gcc/ChangeLog
> > > it used about 2.25GB
> > >
> > > How do you interpret the massif output?

A bit unrelated, but there's a new valgrind release:
http://www.valgrind.org/docs/manual/dist.news.html

"The main excitement in 3.3.0 is new and improved tools.  Helgrind
works again, Massif has been completely overhauled and much improved,
Cachegrind now does branch-misprediction profiling, and a new category
of experimental tools has been created, containing two new tools:
Omega and DRD.  There are many other smaller improvements."

Best regards,
--=20
[]s,
Andr=E9 Goddard
