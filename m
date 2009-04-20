From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Oldest supported Perl version
Date: Mon, 20 Apr 2009 14:32:32 -0400
Message-ID: <76718490904201132h3932e6dan3b1c0d841bd3cf00@mail.gmail.com>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	 <m3eivnp5p4.fsf@localhost.localdomain>
	 <76718490904201127n5bd9836ak796792ce3cfd18a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:34:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvyJk-00032P-BW
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbZDTScf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 14:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbZDTSce
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:32:34 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:12660 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbZDTSce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 14:32:34 -0400
Received: by yx-out-2324.google.com with SMTP id 3so863390yxj.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K+t7d012uBVMwyKDeVTKwXNsnOyDX9gzF4auF+GBMFY=;
        b=NTlpQPxgbGIuXFd89fIVqNYIU35iTqGkXlQr5dcrUoB5xTQnw35FGftHZcKSIdx3hq
         zI3JtXwyFs3iFCtwLgIxUu/LBnunrZRcVirp1nwUbnK5KZsy1OnVrYdPrnLWNNLWArAP
         mxSKzJS/uavxkzkTNtcbeHsZ1K3g0NyKwVlH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ifmW9QiRS7r7L94l5bITdfRKqPqKKuIcx8cXcFQCboARxovr5DYwTXiMbSjND6pZdY
         9xLsco6SMQxRqqMsmwmKmjOH15p0VCrPn/FVuPj8LyeMCfqtaQmTt96X0nk/77mXagun
         pKcBT0JGKhe0EcQqu0bxn1BT4Wy7/YYrT+KO0=
Received: by 10.151.106.4 with SMTP id i4mr1708218ybm.5.1240252352991; Mon, 20 
	Apr 2009 11:32:32 -0700 (PDT)
In-Reply-To: <76718490904201127n5bd9836ak796792ce3cfd18a6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117016>

On Mon, Apr 20, 2009 at 2:27 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Um, isn't that basically exactly what I said? The only difference is
> you're clarifying gitweb to be 5.8.1 instead of 5.8.0. Fine. that's
> why this went to the git list.

Oh sorry, I see we differ on the *.perl scripts. You're saying 5.6 for
those. I was suggesting 5.8 for the *.perl scripts based on:

http://article.gmane.org/gmane.comp.version-control.git/94523

Anyway, I see that there are basically a few categories to decide on:

1) gitweb
2) the *.perl scripts
3) Git.pm
4) the parts of the test suite that use perl

I think there is consensus that (1) is 5.8.1 for unicode reasons. (3)
and (4), for all practical purposes, are apparently 5.6.0. So that
leaves (2), which is either 5.6.0 or 5.8.1 depending upon which gmane
thread you consult.

j.
