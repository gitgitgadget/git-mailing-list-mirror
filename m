From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Clean up write_in_full() users
Date: Fri, 12 Jan 2007 09:37:46 -0500
Message-ID: <118833cc0701120637i5808ac76g6ba4229cbe3aa26b@mail.gmail.com>
References: <Pine.LNX.4.64.0701112014050.3594@woody.osdl.org>
	 <20070112043346.GB24195@spearce.org>
	 <Pine.LNX.4.64.0701112039100.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 12 15:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5NXY-0005dU-B6
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 15:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbXALOhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 09:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbXALOhr
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 09:37:47 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:61186 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbXALOhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 09:37:47 -0500
Received: by wr-out-0506.google.com with SMTP id i30so626085wra
        for <git@vger.kernel.org>; Fri, 12 Jan 2007 06:37:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dNV1DboHlEbgshQrbiei5OSnki5q+ns0jRLPCdEflUD8K6/3HS7PwWMEsOAl5sb+LeWBu17mbrEHacocohPFkE9/nWl8U8Due/CX/HIe98CGKFFaUWDDN+fgRXP7ckMFf927fenM7mTvnZDvUVcqnjESObXlBJegz2usv0YNVS0=
Received: by 10.90.105.20 with SMTP id d20mr552180agc.1168612666327;
        Fri, 12 Jan 2007 06:37:46 -0800 (PST)
Received: by 10.70.95.5 with HTTP; Fri, 12 Jan 2007 06:37:46 -0800 (PST)
To: "GIT Mailing List" <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0701112039100.3594@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36674>

> The thing is, "write_or_die()" actually makes sense.

Except for a library.  Calling exit is very unappealing in that case and trying
to change die to use longjmp is even less appealing.

M.
