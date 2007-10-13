From: "Dan Z" <dzwell@gmail.com>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 16:50:35 -0500
Message-ID: <cff973550710131450r3b54a328k8db97488f4b50e2a@mail.gmail.com>
References: <471045DA.5050902@gmail.com>
	 <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	 <20071013172745.GA2624@coredump.intra.peff.net>
	 <20071013175127.GA3183@coredump.intra.peff.net>
	 <47112491.8070309@gmail.com>
	 <8DDFBF9A-2C68-404B-843C-BE63C52F0DAF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jonathan del Strother" <maillist@steelskies.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Frank Lichtenheld" <frank@lichtenheld.de>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 23:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igosl-0006Ob-Vq
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 23:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXJMVuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 17:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbXJMVuh
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 17:50:37 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:35931 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbXJMVug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 17:50:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1104183rvb
        for <git@vger.kernel.org>; Sat, 13 Oct 2007 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/OSzyW6YfxDB/7EHKQTOTSSNOk5LhW5XvtcKybSHHuw=;
        b=WbyIWbn+UGDQzWxF9VIo66LU+HGdLvWDvfMZeIqkYYdQuu5yBEbLkTDiCnL2Ly18qgaBDX5yWJ3rdxf01Kr/Azo2qTTFjaG2vOJnxJT1nWuEZDF6aJVjsbT54bsH1BNFhvozguSpIn8tjR6QqO9CLFFIXaO+0y66QabAAUSx/ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hqPhmz1esDwwyYezA0KfQsGqE6BUeJuaarJ58psABeonJJQTuMVPveOITpwuhckBALAbtn/zekp9JUjaM4lYQzZEtBTuI0U0fa5bX0J+1lm5lfpWSJSDm2hE6uXyQJoye/W8iELPizzWe5cBlt8JjCwdX+y0ml7cttNrP2cexO0=
Received: by 10.142.86.7 with SMTP id j7mr1288560wfb.1192312235397;
        Sat, 13 Oct 2007 14:50:35 -0700 (PDT)
Received: by 10.142.216.17 with HTTP; Sat, 13 Oct 2007 14:50:35 -0700 (PDT)
In-Reply-To: <8DDFBF9A-2C68-404B-843C-BE63C52F0DAF@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60780>

On 10/13/07, Wincent Colaiuta <win@wincent.com> wrote:
> Or could you just piggy-back on the settings for color.diff.<slot>?
>
> And if a separate group for git-add is necessary, perhaps "add" would
> be enough, rather than "add-interactive".
>
> Wincent
>

I think color.add is better, because git-add--interactive goes beyond
coloring diffs. When this is complete, it should probably use
color.diff.<slot> for the actual diff output, and color.add.<slot> for
colored prompts/commands.

Dan
