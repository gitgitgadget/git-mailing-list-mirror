From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did not change
Date: Wed, 23 Jul 2008 12:19:18 -0400
Message-ID: <32541b130807230919j64634e94ybb61b55fcb27582@mail.gmail.com>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
	 <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
	 <20080723120104.GQ2925@dpotapov.dyndns.org>
	 <32541b130807230853y136f41bdmf221637e35d601c3@mail.gmail.com>
	 <alpine.DEB.1.00.0807231708520.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:20:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLh4e-0001LU-RS
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYGWQTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYGWQTV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:19:21 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:19506 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYGWQTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:19:20 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1067977ywe.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ihL8JwiqlVl2sptT4YmrOrV8f2WNzi4BbzDlr88mEH0=;
        b=dVopSx4NewHEWyMsDhvLGakEhMOA5fYL+MYmjbiGrWRy5B7JF/Sa0vpxlw0ZtdBVYe
         kVhxPjcSNs/IUJMwda2PdvK93AQlV3sRw5DEkldNTNB7X9WEexjsxK6zFu2x4/FBI5sD
         uuz8Onf3kUzAuvCY1U2vZ+gYJTWXitxiF+/sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=njGxBmT/qxXpOii7OWzJ4NsYyc/IlOENMKSDjzLz9IQ57AZxL8p2FvPED+4e2bpUDY
         UsqVVNHsdqk9BC/S9JZ0vTlFT7+VDmt2+D0WCK7P1HmTvUcwbRHN0PGBqZ2bnU3QUvpX
         +MnuewSGxH57GRjtNrEScrX/bv59Zxx8IY/nQ=
Received: by 10.150.92.13 with SMTP id p13mr153073ybb.190.1216829958809;
        Wed, 23 Jul 2008 09:19:18 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 09:19:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807231708520.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89700>

On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Wed, 23 Jul 2008, Avery Pennarun wrote:
>  > However, taking out the auto-commit wouldn't pain me too much if
>  > others want it that way.
>
> IMO the -rc0 cycle is a particularly ill-chosen time to discuss behavior
>  changes like this.

Probably, but it relates to the discussion of the current patch.
Would it be better to change the rebase behaviour now and then
possibly again in the next version, or just leave it as-is for now?

Avery
