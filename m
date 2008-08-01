From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 11:47:46 +0400
Message-ID: <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <200807311257.49108.litvinov2004@gmail.com>
	 <20080731104529.GE7008@dpotapov.dyndns.org>
	 <200808011023.32139.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Alexander Litvinov" <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOpNd-0005zH-Ov
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbYHAHrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 03:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbYHAHrr
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:47:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:8627 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbYHAHrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:47:46 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1260837wfd.4
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=cf0YMwPVsLff0o7dw/U93PBmFUXP/lHD38FnterJ+vY=;
        b=D+67DLoSFgir9klBEtd1KycaOh1Fw9BMXkB8ESu84FKk5aZvVUzszmQVWw/+oTrmju
         kTfijdduyHlZ2JA3xJ2duNRE7q7t6bXR5T5hP5GzGYkp19uTDg+aKDmcHddFQSKxO+jM
         l0vQosuAKintVF1WAujo5LU6H3uO2nnu3Odqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HABQUA+pdTrWw6rnAT3nD1oZU4K4TL9N8bIY+OI7ahstGA4hp2d0rcLKQCp1TyUOaf
         tI1zkCTSsY0XY5VFg2jrLEqRgUTNzQiY+JYg73HLgdJYAdYTYnF40iTN44Kd3U6TZYDb
         82ShizF3xz9tTSNri/HdLzUnxgMShqQEH+Nkg=
Received: by 10.142.155.4 with SMTP id c4mr3624324wfe.9.1217576866146;
        Fri, 01 Aug 2008 00:47:46 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Fri, 1 Aug 2008 00:47:46 -0700 (PDT)
In-Reply-To: <200808011023.32139.litvinov2004@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91038>

On Fri, Aug 1, 2008 at 7:23 AM, Alexander Litvinov
<litvinov2004@gmail.com> wrote:
>
> I dont think that disabling convertion is a good way. I really want to convert
> my files.

To being able to synchronize efficiently in both ways, you need to store
files exactly as they were received from SVN then there will be no
problem with applying binary delta patch. All CRLF conversion should be
done on checkout and checkin from/to Git repository.

Dmitry
