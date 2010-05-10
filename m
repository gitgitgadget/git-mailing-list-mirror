From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Mon, 10 May 2010 09:25:11 -0400
Message-ID: <AANLkTikYUypxH5WhCOMby_zpHsnHEFyix5MGpD96FVWD@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
	 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
	 <20100509070043.GB14069@dpotapov.dyndns.org>
	 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
	 <AANLkTikRJ6Hl_fRNRZbxeNNgwv9UTm2fPrOKv4GbT0qJ@mail.gmail.com>
	 <E6434515-5357-4FF4-8049-5E4FCE8B29E4@gmail.com>
	 <AANLkTikg7Tc6zJvfBELBQoeAxebFenNLivEs92j8c83D@mail.gmail.com>
	 <91F47297-A1B5-4AE5-8835-E3A8E452FB8A@gmail.com>
	 <AANLkTilDiP_5Q9HrssB0lyf-jsE8LAF2ULGwEMO4BzdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 15:25:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBSz6-0003Ca-GU
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab0EJNZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 09:25:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59497 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab0EJNZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 09:25:13 -0400
Received: by wyb32 with SMTP id 32so39191wyb.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ublB6LSFz+pI/oyJhKtDOUys2ZS00Mk4T6aT5GUj1cU=;
        b=oNwCAqWzWIJEJJHp7SOomXIywPy/n9/Y8UNTMHHtvkLqgD2+53HheDp0N+U0Yc4HA2
         Qsm6FjOnS24xsiAD2PWt2hQPyLDlR5A3Slq6GMmBXNplSl+2qVTCejOxmsirmFykU3sJ
         rygRbVeEUxkwxnKXqvK9fAPJBZmg4NqVcypL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=F+K/NwmZ9G/2cnzzP3cZxo6Iom6wRQs84PFDdtjhLrGrOgR+SQZpS3Jo81j7fCiiTZ
         jNYpgbPATLBLafsbsxBGPEWosbFO4LzQXkAOIpwtHPwZJCqv2kaXOs1XX5dfWItRCHW0
         XKeMGEVjqmFiAB+rzveUwpKsAOotSdMXJVRs4=
Received: by 10.216.89.140 with SMTP id c12mr1092675wef.163.1273497911713; 
	Mon, 10 May 2010 06:25:11 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Mon, 10 May 2010 06:25:11 -0700 (PDT)
In-Reply-To: <AANLkTilDiP_5Q9HrssB0lyf-jsE8LAF2ULGwEMO4BzdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146813>

Today I am writing up some documentation related to Git use at the
company, and planning to check in all the data from Git vs Hg testing,
and all on-boarding/first-day documentation related to Git use. So
within the directory containing all these files I init-ed the
repository and got this when I attempted to add multiple files. Mind
you, this is on Linux!

  "warning: LF will be replaced by CRLF"

This _really_ of scares me being that this was on Linux. Is this one
of the problem spots that the topic of this thread attempts to
resolve?

Bob
