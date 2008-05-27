From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH/RFC] Revert "filter-branch: subdirectory filter needs --full-history"
Date: Tue, 27 May 2008 11:55:46 +0100
Message-ID: <e1dab3980805270355n6121ee9ehc285497b20b70a15@mail.gmail.com>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com>
	 <200805251426.54755.johannes.sixt@telecom.at>
	 <alpine.LFD.1.10.0805251359290.3081@woody.linux-foundation.org>
	 <200805262109.19015.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Sixt" <johannes.sixt@telecom.at>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue May 27 12:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0wrH-0004GU-Rf
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 12:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422AbYE0Kz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 06:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbYE0Kz4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 06:55:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:52581 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756422AbYE0Kzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 06:55:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1570990ywe.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hKGogHOugFPK8bB7exlw49fThMrR1qIha3ZmazssyE0=;
        b=WI75ElyQmo8iFPIzOyrAm5znIZLkNznRkzKHslY51Oo0aCu7vMD8pbtnDhv1TwJV5f9oRrsAr9hwSEnCr3VYH9sbvslQQgCbjxva3L0yYfci+EKQAw/Wv4xmYkVGUk4ss/bpHlRj3EA8B2n/piyBARReuzFTSH+b2gVcoTL0Jwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FRMHq/1eg1b2NSDpWrvwBS/Xus9iJwU7sRCcfv50WD8zWrDwE11msFRB9kDx7QBuywsG2otLT2q1YRRGeSKvz2Fip2d5XWTW7GAsJzO9jl8WUCuLC20/SiAdlQLESt+lq+4B/hFVVMLrtxxpxRWL0nHb40W02Vk1Z3WSdNjdoGI=
Received: by 10.150.11.1 with SMTP id 1mr4424733ybk.8.1211885746929;
        Tue, 27 May 2008 03:55:46 -0700 (PDT)
Received: by 10.150.225.18 with HTTP; Tue, 27 May 2008 03:55:46 -0700 (PDT)
In-Reply-To: <200805262109.19015.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83004>

On Mon, May 26, 2008 at 8:09 PM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
> This reverts commit cfabd6eee1745cfec58cfcb794ce8847e43b888a. I had

FWIW, applying this patch (getting 1.5.6.rc0.29.g3beb5.dirty) it now
filters the case I was trying successfully (although I understand
Johannes' point that this fix only works because my commit graph is
only "quite messy" and it wouldn't work if it was "extremely messy":-)
).

Thanks to Johannes for his time looking at this.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
