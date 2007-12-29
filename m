From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sat, 29 Dec 2007 21:54:43 +0000
Message-ID: <200712292154.44169.andyparkins@gmail.com>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com> <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 29 22:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8jeT-0007PW-6k
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 22:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbXL2VzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 16:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbXL2VzD
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 16:55:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:15537 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbXL2VzB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 16:55:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2056261ugc.16
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=4pbzoxWdprayKkndaFq9DOiZDeTB7YuU0aw1zcZ5TpA=;
        b=XTkeQgx0/K3pE9nLf6fZEzXTC3isUWAJ8ogQKeDxeYKGz13hWNTygNkmbWEDPoDrsLzGILiVy5ui2Nxi9BBhgOmL+Nwficvl02RyNi961HzHGrtSZaFm1yA9iZSu5YLkP9Cq73YELAnDxDBuwk5BnorbKZHtLqHDYoruPBG83tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NbE7iVep7iT/6geouE5FV2hQaYs+7pG9QVTlavc8zxdEC8zN0k6BLmlyJbqZ2lBol+zrkySHtd5pGroHIjPGkqaLEyfC6mBJwwqyKUHbrIo5IOdvpQURvQJHhhtA3pPG7HxGmhepo7SQJZozTSlqaoiKXOR8/iZLv9AnXf+Zmh0=
Received: by 10.67.15.15 with SMTP id s15mr9003996ugi.27.1198965299259;
        Sat, 29 Dec 2007 13:54:59 -0800 (PST)
Received: from grissom.local ( [91.84.15.31])
        by mx.google.com with ESMTPS id o30sm37432761ugd.84.2007.12.29.13.54.55
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Dec 2007 13:54:55 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69332>

On Saturday 2007, December 29, Johannes Schindelin wrote:

> 	Not only does it avoid the strlen() call also for longer prefixes;
> 	it also avoids a C++ comment.

I'm sure it doesn't matter; but they're allowed in C99.  So it's not a C++ 
comment any more :-)


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
