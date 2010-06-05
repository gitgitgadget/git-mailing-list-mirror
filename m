From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Sat, 5 Jun 2010 17:02:25 +0200
Message-ID: <20100605150225.GA16594@localhost>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>,
	Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 17:03:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKuuk-0003qx-Ae
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 17:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab0FEPDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 11:03:52 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:35665 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0FEPDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 11:03:52 -0400
Received: by ewy23 with SMTP id 23so37700ewy.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Sl36/eH4/Ss1DBu2BUN5jwCkrr7JKlYrBxZViLHvI5I=;
        b=FfJSLyxAkFFC936I/gdr6d4SUofXuRj9zxYohajDaIlKISVThccaHO9Fc67RJaRq7q
         j7dhILcJseIzjmOouqlbGY7WDWyrypjrao82FnTl74emR4hI2LjwJr8lDbGQ0rEcktop
         6rjeloEAd1Rt9kc59A0THmeTFfadAKfRC0s5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=IA2hQLN9XcLpO+ujzWYmQK3H4KH2dFlqGWa7JeNaM2IXHB0Oqd2qtEXqolSWK595ob
         JT1EyvM1QPDrYnfGBm1cu0NQM+FwXalOCBw1ZtI7328vkMAesNWCAyFbyY9ldwILPD8W
         3/gH4BiR5ENTUwGQsaWnhnFiDiTshHSceoupk=
Received: by 10.213.35.193 with SMTP id q1mr9429678ebd.38.1275750228540;
        Sat, 05 Jun 2010 08:03:48 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 13sm1406616ewy.5.2010.06.05.08.03.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 08:03:47 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKutF-0004Oj-Qv; Sat, 05 Jun 2010 17:02:25 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148475>

On Sat, Jun 05, 2010 at 04:03:30PM +0200, Sverre Rabbelier wrote:
> On Sat, Jun 5, 2010 at 15:58, Clemens Buchacher <drizzd@aon.at> wrote:
> 
> > I could not make much sense of the thread that came with the patch.
> > The discussion first seems to conclude that it is a bad idea, only
> > to implement it anyway.
> 
> I think it would be useful here to have some links to relevant posts,
> or at least to the relevant thread.

The discussion ends with this posting
http://mid.gmane.org/7viqesz3mk.fsf@alter.siamese.dyndns.org ,
which basically says "we all agree this is bad."

Then Junio changes his mind his mind and posts the patches.
http://mid.gmane.org/7vzl7pyvzl.fsf@alter.siamese.dyndns.org

Whether the feature has merit or not is suddenly not an issue any
more and the discussion veers off in other directions about minor
technical details and about the --nodwim/--noguess option, the
notion of which I find ridiculous by the way. But it further
illustrates how random and anti-DWIM this feature really is.
