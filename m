From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: msgmft segfaulting on tiger
Date: Sat, 23 Feb 2008 06:57:49 +1300
Message-ID: <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
	 <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
	 <20080222065836.GE8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"=?WINDOWS-1252?Q?Basilio_Brice=96=F1o_H.?=" <bbh@tampico.org.mx>,
	gsaldana@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:58:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JScAG-0002Ii-1Q
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYBVR5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbYBVR5w
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:57:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbYBVR5v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:57:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1360692ugc.16
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=J95oyF6/NUO7hsNANbi+gGC406VcIpZgQ1PcpP8g5oo=;
        b=aGMa19YN6ORvHWDoIgD/sbWNOpqsNgGa94xIStrzFoHc3aFjgcDM7QcDAZ1YUXCRVcnCdshXJpPDWqesiUJ5i5jWPMg2tvM+vwUARvZWJSOTupxni8lnepJYxsgeDmjSGAQas8J8iwFCFT2dA606W65K430ENZk4UGipdN1uf5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q5wgY+yuIRixUmuiE5m5jFqwynQBWQCfjTK2BFGU7ecLlmmKldtp54ubN3NxFNAvPHmOBYdUO8S/a3NSHvDzMIJxAELWCRW49k87cKjH6n7oi1DxGwTz6ZfjXLznmk81lwhyHi4e/X0fsV2pMrwX4EgBlyJ0EYByjwUI1C5QTcU=
Received: by 10.66.221.5 with SMTP id t5mr2641185ugg.83.1203703069319;
        Fri, 22 Feb 2008 09:57:49 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Fri, 22 Feb 2008 09:57:49 -0800 (PST)
In-Reply-To: <20080222065836.GE8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74743>

On Fri, Feb 22, 2008 at 7:58 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>  Did you try building with `make V=1` to look at the full output and
>  not the prettied up simplified output the Makefile uses by default?
>  It won't fix your issue but it may be interesting to see if msgfmt
>  is failing with a particular message or not.

I'll track down Basilio (it's his laptop) today and try, I think he's
still at the conference. I also suspect that OSX's own build tools may
include a different msgfmt, but the fink one is earlier in the path.

cheers,



m
