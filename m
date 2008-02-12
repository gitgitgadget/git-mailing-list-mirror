From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 16:36:32 -0500
Message-ID: <9e4733910802121336x42055baawf2b8f3714e2a1eb4@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
	 <200802091627.25913.kendy@suse.cz>
	 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
	 <alpine.LSU.1.00.0802101640570.11591@racer.site>
	 <alpine.LSU.1.00.0802101845320.11591@racer.site>
	 <alpine.LSU.1.00.0802122036150.3870@racer.site>
	 <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nicolas Pitre" <nico@cam.org>, "Jan Holesovsky" <kendy@suse.cz>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:37:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2oR-0000u1-Tf
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbYBLVgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbYBLVge
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:36:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:34516 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYBLVgd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:36:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2996496wah.23
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 13:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KmfIkkPxrB2cd47Qr9B03E1AHgPuBuS2XBl6FY0E1sc=;
        b=jf6RNj2WEu9VJZ2UYYNBLlzz6UG/UEMsSGOZ0V9SGIkMP9SIB9hofxIZIcokbF/goFazuRIxUlRrCWf11qHN3AEKq3oH9CNzkla/3bQw/dxeCGB8c7V2I5UBffe7xKj58nEBr6pofQ7aLk2+cAHdTXwg/+xglaCV5R4p4she+sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C++N8b9df2+bQ18QDLVnDBUbIc78jwcsrb3AxS8b56ZCubGbeGpCCaL4Z+M8CLa3wxeAanacUVUMVmcyWsPO2zy0OyVTd/rW2BjdhK3HPUYYYxawGNnGiaAb+hGrTEr2qqa2B0PcyD4xRdJLegYHx14RW36XcxN5xDQ41KQ90Yw=
Received: by 10.114.134.1 with SMTP id h1mr2082024wad.4.1202852192271;
        Tue, 12 Feb 2008 13:36:32 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Tue, 12 Feb 2008 13:36:32 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802121303450.2920@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73695>

How many diffs should it take to compress a 2000 delta chain with
window/depth=250?

-- 
Jon Smirl
jonsmirl@gmail.com
