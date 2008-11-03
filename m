From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI revamp
Date: Mon, 3 Nov 2008 10:53:01 +0100
Message-ID: <bd6139dc0811030153o669a2cfax6fb9ef5e6d3e294e@mail.gmail.com>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
	 <20081031003154.GA5745@sigill.intra.peff.net>
	 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
	 <1225691960.20883.41.camel@maia.lan> <gemhdp$lev$1@ger.gmane.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 10:54:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kww8b-0008Es-0U
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 10:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbYKCJxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 04:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbYKCJxG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 04:53:06 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:44644 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbYKCJxF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 04:53:05 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2134759fgg.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aWu1DL+J5vUC97rDpNe/RXrkccm5AVTcBPTDy6onzEg=;
        b=rCKz+vaGxvCJo0KxH0Xi+jjNL/pfIDYguFFJveUTy6rgVSeMTCkXZru/AHFNrImV0E
         JKx7ya86UV5DiFNFIENm4QiOOkonrkz4cfjrkT7njSZvPxAZkNLfwQgK5/9dWxc3OwX5
         lPLOT4E0r1c5MByjMuaAAqdetRxHAaUvk+Nxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ga4OF8o3VFP1BNGliUcbgcbgjl9X+okpw7gn/uOqyoDjoLJyDrh7G7q4H9k0m2GsRA
         j50gNHX3/dYIQrFM/rQDdSWVHWffXaccMRhtWpicMHhYy8e5/Ut9Wv7pyBZXgAj9iwmy
         DlEWPL2Y0FpjCkwq19CQqXi8qpYQxK4t1F/Nw=
Received: by 10.187.222.16 with SMTP id z16mr1870644faq.58.1225705981910;
        Mon, 03 Nov 2008 01:53:01 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Mon, 3 Nov 2008 01:53:01 -0800 (PST)
In-Reply-To: <gemhdp$lev$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99925>

On Mon, Nov 3, 2008 at 10:48, Jakub Narebski <jnareb@gmail.com> wrote:
> "git remote <remote> push" for push matching?

Not another command that is made to perform yet another piece of
funcionality. Let's let remote handle (configuring, and maintaining
of) remote related things, not also make it do push stuff.
Unless ofcourse, you mean that "git remote push <remote>" (certainly
not the other way around) is for configuration only.

-- 
Cheers,

Sverre Rabbelier
