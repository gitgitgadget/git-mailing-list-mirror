From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 15:01:02 -0700
Message-ID: <fabb9a1e0908131501o73807f81mb230530c284ad123@mail.gmail.com>
References: <20090813150446.GM1033@spearce.org> <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com> 
	<alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302> <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com> 
	<20090813172508.GO1033@spearce.org> <fabb9a1e0908131028t438509d2m180293ca95daad74@mail.gmail.com> 
	<20090813174119.GP1033@spearce.org> <fabb9a1e0908131044g583f126dm6a3818b4b295eaf5@mail.gmail.com> 
	<20090813175211.GQ1033@spearce.org> <alpine.DEB.1.00.0908132350190.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:01:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiMU-0006So-UX
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZHMWBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 18:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbZHMWBW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:01:22 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48325 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbZHMWBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 18:01:22 -0400
Received: by ewy10 with SMTP id 10so1123677ewy.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TMT/WQjgLm/8OMDM8lwJiJ3WBisTFrKv57D/ZarWwjk=;
        b=Cw25Ux/fj/ScBZmJmXhYWZfhF9P3FvJp2sh3o17QQSWWqhoafh7nrGeReMBL+R9RYk
         1rU4j9CXkrkU+4DBddWTqnB8HzHu67jQ3kOADl/IydpEk/ESiNtB5tOLel180Mq0S2sG
         eM1HLpCMeVTREvaZKJ6VxysdQhDyFetqAo85U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tq+F1MlFJmFPKxEIEkAKAlH9f1GPuuEHRomsXjL2klbXlJfGvBDj7Wmh21dTWpu3Vu
         miPLL26HQffKomOSINmCFm+YMvlxTV/QeHbBgcQYPRqqi3Qig5J6WansdFK/xTDReuVH
         5n2B7ULVQxz4Bv9+eqeQM5zR/dIF1PTq42gvg=
Received: by 10.216.8.77 with SMTP id 55mr247156weq.220.1250200882360; Thu, 13 
	Aug 2009 15:01:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908132350190.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125885>

Heya,

On Thu, Aug 13, 2009 at 14:51, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Sorry if I spoil the party, but maybe if things get so complicated, i=
t may
> be a sign that the original version (stream overrides command line, s=
ince
> it knows better) is to be preferred? =A0After all, if hg fast-export =
says
> that the marks should be imported from a certain file, it may be for =
a
> _very good_ reason...

Yes, and that should Just Work (which it does). Also, I'm not sure how
often one would output a stream on one computer, then move it to
another and import it there, but I'll methinks Shawn brought it up for
a reason ;). However, I do think it's better design to only store the
name of the import file and then do the actual import later on (to
prevent double imports).

I don't have a preference either way (both patches are already written
after all). Shawn?

--=20
Cheers,

Sverre Rabbelier
