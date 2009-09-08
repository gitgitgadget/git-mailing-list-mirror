From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Improving merge failure message
Date: Tue, 8 Sep 2009 09:20:07 +0200
Message-ID: <fabb9a1e0909080020i3daa92aar952fc5102df62bdb@mail.gmail.com>
References: <20090908153101.6117@nanako3.lavabit.com> <7vbplmhr0i.fsf@alter.siamese.dyndns.org> 
	<7veiqhgb4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkv0G-00078K-2t
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZIHHU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 03:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbZIHHU0
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:20:26 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:49431 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753661AbZIHHUZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 03:20:25 -0400
Received: by ewy2 with SMTP id 2so2538090ewy.17
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BMp5/rCscVU89VBWSO4UiI2hfUytGHafrYZY9MzE8vI=;
        b=rZz7fchPcb8JPUTM1vLVRh4C7P73jHq8HUaIeq4rvmfhv+Jng9/9H+BoMqvmlHs4Rd
         vQKOV7P9YUzFOyEhx5MlVsJeNNbKmQbpEGFf4D2Gy+dmk52zy8Guv0bzajchbjpHQGdl
         tgpayTm0vm1KjMtzOH1Q7al3fj7HtfCf7Qsck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J19ZYcDXmpdM+wC8XO3LPz+7AzdrQ32y6D1BVMRGTLgePr0QSrnks0n8DUGkc0rB2P
         CLIT4Kga6h+atlBnzZOuv4XbX1aXTuRyCViGIdBNdGCLUNRlGYSqHnjTR/RCJ82DHCRI
         njWpdUId+3Ba6F+Vc6yH8/GfG1GHLCgSlFwPM=
Received: by 10.216.93.141 with SMTP id l13mr1674981wef.67.1252394427127; Tue, 
	08 Sep 2009 00:20:27 -0700 (PDT)
In-Reply-To: <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127984>

Heya,

On Tue, Sep 8, 2009 at 09:15, Junio C Hamano<gitster@pobox.com> wrote:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* would_overwrite */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Your local changes to '%s' will be clo=
bbered by merge. =A0Aborting.",

Still scary, shouldn't that be s/will be/would be/ ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* not_uptodate_file */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Your local changes to '%s' will be clo=
bbered by merge. =A0Aborting.",

Ditto.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* not_uptodate_dir */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Updating '%s' would lose untracked fil=
es in it. =A0Aborting.",

Not sure, but maybe s/in it//

--=20
Cheers,

Sverre Rabbelier
