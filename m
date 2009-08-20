From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: Re: gitweb and symbolic links
Date: Thu, 20 Aug 2009 10:32:26 +0800
Message-ID: <eafc0afe0908191932pd24e6b3y72dbffdc2b2f7361@mail.gmail.com>
References: <2367E9DF-6FB1-48E6-AC9A-73E84C9D54E1@math.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marco Gualtieri <mgualt@math.utoronto.ca>
X-From: git-owner@vger.kernel.org Thu Aug 20 04:32:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdxSP-000638-RX
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 04:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZHTCcq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 22:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbZHTCcp
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 22:32:45 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:64382 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbZHTCcp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 22:32:45 -0400
Received: by vws2 with SMTP id 2so4133675vws.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 19:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ZASAB6fVivz5Rzr7O6+/s/A9Hoy3pnIf8kW4jkYm60c=;
        b=XTShrRqd0xsG5iDRxP6B5yGbMjGgYMZOfbph8u/NrU2PSOW5/u72h8wOVep6LI62Sn
         eQRcLaOgMS1OmfSSZINYsPpQqo6c0rhds02UwPx3yt1GRRzVQw2zw2PebZjFNahXGpg3
         eCknklVz7hmO4Lrhx0A9atUu1biOyn4Oy5P3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h2zEAE0sQZ5BClpqx0gPGfIzWuDS+rZGu5bjGoXDVEns9OwippiHBwENZtbWTiuit8
         g0M197gX2vG0sRxtCtQNdzWaSCEL/asy4gJYVLqgGXu6jRLZRKr/FJ58uguvcrL43OiU
         D8ihe2y210hNYOa6hxNotCKlFRk7flGYbPxNM=
Received: by 10.220.43.196 with SMTP id x4mr10082178vce.16.1250735566216; Wed, 
	19 Aug 2009 19:32:46 -0700 (PDT)
In-Reply-To: <2367E9DF-6FB1-48E6-AC9A-73E84C9D54E1@math.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126605>

Most WEB servers disable following link for security reasons. Check
it's disabled first.

                                                      Changsheng Jiang



On Thu, Aug 20, 2009 at 09:15, Marco Gualtieri<mgualt@math.utoronto.ca>=
 wrote:
> Hello,
>
> I am wondering about a possibly easy bug which you may be aware of.
>
> For some reason if I place a symbolic link in a directory under the p=
roject
> root, =C2=A0gitweb is no longer able to find the project. =C2=A0I was=
 looking through
> the .cgi file but I don't know enough perl to fix the problem myself.
>
> Let me know if this makes sense.
> Cheers
> Marco
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
