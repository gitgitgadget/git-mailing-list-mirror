From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git on Windows, CRLF issues
Date: Mon, 21 Apr 2008 17:53:34 -0400
Message-ID: <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
	 <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Karlsson" <peter@softwolves.pp.se>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:54:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo3xw-0002WW-Vd
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 23:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbYDUVxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 17:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbYDUVxi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 17:53:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:36471 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbYDUVxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 17:53:37 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1911976fgb.17
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 14:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cJWFnGby8abK5rwzJb0BqAisL3xCpfexihm0elvP3lk=;
        b=azgdSpmpqgvNE2gBho4+2GUXE9VcCR/4yPCgE7A0VTtEz5D4VhzksnfAd/Ibk8gPH7BacTHwzTVkStrLAONtAA9lzKvSMVruEPg6Nu7STN0ToHjJbFuH3fQeFw1Bd04OH1EBFqyIU78/mffta14b+4/Q4XT128IhhmVpF92fARI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iyWWHDMiUBld554tXEJVLClkqT2o7Yy82rEEZvXMNdOEusDgigfuIRXNXBNxS2sIDBCvTOQ4FRSKVPhHe2j4ATCCQErmqGG9r28Hm9sasOap9tTrMgexi4aZcixx48xq/7KJeVU3WYMp18Z/I6Einn50FrDA4BiTu8L9PyCxSmQ=
Received: by 10.82.156.10 with SMTP id d10mr11806324bue.31.1208814814930;
        Mon, 21 Apr 2008 14:53:34 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 21 Apr 2008 14:53:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80041>

On 4/21/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I think that the only solution to this is (sorry!) to have one single big
>  checkin which converts all CR/LF to LF line endings...

If it were me (and I hope it will be, soon, if we can entirely shut
down svn internally), I would prefer to use git-filter-branch to go
through *all* my checkins and fix up the CRLFs in all of them.  That
way the history will be clean and diffs/annotates/merges will go more
smoothly.

Does anyone know the most efficient way to do this with
git-filter-branch, when there are already thousands of files in the
repo with CRLF in them?  Running dos2unix on all the files for every
single revision could take a *very* long time.

Have fun,

Avery
