From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: [PATCH] completion: remove use of dashed git commands
Date: Sun, 20 Apr 2008 12:49:06 -0500
Message-ID: <449c10960804201049o1c8f0be4m36dc5ce2afec2de6@mail.gmail.com>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com>
	 <alpine.DEB.1.00.0804201841570.5084@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 20 19:49:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jndfn-0008OO-2P
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 19:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332AbYDTRtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYDTRtI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 13:49:08 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:13900 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbYDTRtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 13:49:07 -0400
Received: by py-out-1112.google.com with SMTP id u52so2079570pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=e/2AnzTGB+jYHZy+/+piGC9rtOcHodiAJigorMWEPK4=;
        b=leU4hpHvegBVAnBrbG+QT0v5djn7953PS/YyIsWfeQ/Vgc1hHQ816QO+MIfbusDU6hnN5BOKdwPdcBauPkEBXCkTUeGJqQnGm5Ldf/7cR3YHPH6nta53D8t8u8ZAV78EfABX+xv74keEffBP4o4BBn8WwcIplOVJtSsiphJo7BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=w1gRNngSiGbOYNx+jWLUjob5fTXcoCau2KvWJkGPmDwIeYPdM/yCEtQab5tu7uW+btqhtpyr7ychZoFXtPhVHeg/lCBY/7M+kUiBxY9msgTTeWaDWlu7WVv4isd5Ydq6qeXgzeAydukC5jyi8aK1+fEV0TTIWikJMQmm9kiNlRU=
Received: by 10.140.199.3 with SMTP id w3mr2073087rvf.175.1208713746639;
        Sun, 20 Apr 2008 10:49:06 -0700 (PDT)
Received: by 10.141.212.3 with HTTP; Sun, 20 Apr 2008 10:49:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804201841570.5084@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79970>

On Sun, Apr 20, 2008 at 12:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  On Sun, 20 Apr 2008, Dan McGee wrote:
>
>  > [no commit message]
>
>  I would like to deprecate dashed form _officially_ first (as in
>  ReleaseNotes), before doing something that could lead to quite some
>  surprised users.

Now you've confused me. From Documentation/RelNotes-1.5.4.txt, it
seems fairly clear that dashed command forms are deprecated.

This patch was rather non-intrusive- it only updated the bash
completion script to use the non-dashed forms. I'm not sure how this
leads to surprised users at all.

-Dan

(Sorry for the double send, forgot the reply-all the first time. Looks
like I need another Sunday cup of coffee.)
