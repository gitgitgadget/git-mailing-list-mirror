From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Fri, 25 Jul 2008 02:07:05 +0700
Message-ID: <fcaeb9bf0807241207y460ebe52o9e9f4958ab07679b@mail.gmail.com>
References: <20080723145535.GA29053@laptop>
	 <20080724171519.GA21043@sigill.intra.peff.net>
	 <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
	 <20080724185844.GC21186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM6Aa-0005em-Au
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYGXTHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbYGXTHI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:07:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:54133 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbYGXTHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:07:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1476200fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=c4ibt9HXpfGxvlO+KGeVAOjaQ6uXu0q07TEe/DW8s9Q=;
        b=A5HJ4AI9ox9WtNUaazoSQWIXDm3c+GDPEJEMZ56m9ElE5t5BuxTV64PzBflmRHs0+V
         I6BufxmTR3RrcKXr3XasKL/pO3JMUE4xgkA8eNiVOhciJz3JebRchqXE1yFVsjmrl1h4
         aIdLhe62TxQ+fVrTp7HboTOIfVuiQwTx6gVaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ui8GTyOdlAFDlCO/mmiK6YWiqPwhn96a4yTUCoAkgK/32KtdSBwNcQGCWbhyPqfQId
         RSIK+/UCRhVBYnRimdazfzHnt1aklW+Ja7+zFPkiZ3SXMReb5RlBH3iSTu9HeJH6VKcg
         nyhe2gzSUhP7yF/8Xadd0aBvVMm2YzoRjsaXk=
Received: by 10.86.96.18 with SMTP id t18mr1123795fgb.78.1216926425814;
        Thu, 24 Jul 2008 12:07:05 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 12:07:05 -0700 (PDT)
In-Reply-To: <20080724185844.GC21186@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89945>

On 7/25/08, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 25, 2008 at 01:45:58AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>  > > The commit message is a bit lacking...what config are we interested in?
>  >
>  > core.sparsecheckout, but I will probably stay away from config.
>
>
> Right, I kind of guessed that from reading the rest of the series. But
>  that sort of "why" really should go into the commit message.

There was "why" in the commit before but I wanted to make the first
two patches independent to this series. Turns out bad, I think :)
-- 
Duy
