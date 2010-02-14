From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sun, 14 Feb 2010 22:55:12 +0300
Message-ID: <37fcd2781002141155r1af33e54w41422dea57661185@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
	 <20100213162924.GA14623@Knoppix>
	 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
	 <20100213223733.GP24809@gibbs.hungrycats.org>
	 <20100214011812.GA2175@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de>
	 <20100214024259.GB9704@dpotapov.dyndns.org>
	 <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de>
	 <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com>
	 <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 14 20:55:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgkZ0-0003ca-EH
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 20:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab0BNTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 14:55:17 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:57989 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab0BNTzO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 14:55:14 -0500
Received: by fxm27 with SMTP id 27so519893fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=qyRLAFbWQ3CSqyX94GwRcRw9uWPRbzpoUicDCA5K8z4=;
        b=hSOaWK9kxN+sAVlWp35U6qiMWAx0jTJfwU0gzwFi+aYT3rvxI92kNDFPIeYFpeHfed
         UviFlisgNeCl78VnQcEdSw5eiZ8QLtGfCRGbhWdQ4eV5dv8QksvWnfJcg3DgMsVKJfoB
         WiXTce2I9EeFqR+K2mhu/ICJ1n7387AElKtF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=umhuGNzof8mxLXwfewvEskpG+s5W/XCPMV4nmPbmStsiG4MlAYxkGXp23RdezclRsL
         UW0MWzNoilNjbeVzf9IzvybSpMBhkCMRxd8thvka6hKovd9hqjT4a8BernJCDP44qrWh
         XF2084/dGQzRDkDDIVWRfo7wOStoIcu2IDIUI=
Received: by 10.239.190.137 with SMTP id x9mr460371hbh.17.1266177313176; Sun, 
	14 Feb 2010 11:55:13 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002142021100.20986@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139934>

On Sun, Feb 14, 2010 at 10:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Git was touted as a "content tracker". So I use it as such.
>

Well... those who got their Git repository corrupted also used Git as a
"content tracker". But I believe Git is a content tracker primary for
source code, thus using it as a backup tool or to store your multi-media
collection is abuse of Git... Having said so, I have no objection that
Git could be used in those areas too... So, I would like to hear any
specific suggestion how to achieve those goals better...


Dmitry
