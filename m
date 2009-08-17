From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/6 (v2)] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Mon, 17 Aug 2009 02:56:27 +0200
Message-ID: <c77435a80908161756n88eb967wbc82058fc4975c04@mail.gmail.com>
References: <op.uyb1uryftdk399@sirnot.private>
	 <c77435a80908161547x4d2a9087qf439d1c30cc4fa99@mail.gmail.com>
	 <4A889412.9090209@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 02:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McqYl-0003et-Cq
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 02:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbZHQA42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 20:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbZHQA41
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 20:56:27 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:41334 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbZHQA41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 20:56:27 -0400
Received: by ewy10 with SMTP id 10so2632144ewy.37
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vEfXrvOwFfZETT5WoNlHs4vUdqIw/iLCwvt+DpTpgSA=;
        b=mBtAfB/VPeY7popNbAhgnYLaDEbKdgIWNTiQrlwgUr3eOBinDISBlhFOBocJNT2Ngw
         2VPW4OBykCnkJv/XK9RXjjbMcGpRpQAr3e9bnPdTSOpZca8KudgwnENpmu2IAp9joW4v
         T5RzIZzTeDjX1eoz2OxyHXvTIpA9m9yxhwAoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PgTp21jYITbcih7leRBzs7xc08szqfiN6KkdBSKb1Bdk7XG7TNLQ/qrpKzcDceEyMb
         nBAiCw3Gyv5Nj270KNZimbGYii1m29hvMma0W2Pfjd9c4iNdQ3SBbNevps48j24E8XEV
         YJG+0dF1n8lfdbBJaHj+Wvvr3eG2RD90vD2/M=
Received: by 10.216.29.72 with SMTP id h50mr905031wea.137.1250470587123; Sun, 
	16 Aug 2009 17:56:27 -0700 (PDT)
In-Reply-To: <4A889412.9090209@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126101>

> Heh, that sure reads like a sentence written after midnight :-)
>
> These all say v2, and the last lot was labeled as v3. =A0And I see an
> older submission labeled as v2 (8th August) and got duplicates of tho=
se
> labeled as v3.
>
> Are the ones attached to this the ones that are the best?

Yeah, the latest ones Re: v2, uploaded a few hours ago, are the best.
They should be Re: v3 but they're not...  If I'm being confusing I can
just upload them to v3, but I didn't want to bombard everyone with
duplicates.
