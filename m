From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 09:28:52 +0000
Message-ID: <200702060928.54440.andyparkins@gmail.com>
References: <20070206023111.GB9222@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 10:29:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEMdP-0002HG-6m
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 10:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbXBFJ3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 04:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXBFJ3A
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 04:29:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:14451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbXBFJ27 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 04:28:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1551213uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 01:28:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OEQ0vTq9s9iGoyyKqH6G01PR3pfw/HgoKxgpz8L09bk6iTZoMR0geInooDdK4SHAqCowY1gH6jk587T7G2YiwnFlbUIB8tPFpRaz1EP+HVcpSnbyGALVWTy+wdRK2DWk17NzX05bmAvmlKq1/oENEWhf9/G+yIkYZgIb8y9I6aM=
Received: by 10.67.121.15 with SMTP id y15mr9520446ugm.1170754138157;
        Tue, 06 Feb 2007 01:28:58 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id e34sm11856483ugd.2007.02.06.01.28.55;
        Tue, 06 Feb 2007 01:28:55 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070206023111.GB9222@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38824>

On Tuesday 2007 February 06 02:31, Shawn O. Pearce wrote:

> The time of the change is specified by `<time>` as the number of
> seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> written in base-10 notation using US-ASCII digits.  The committer's
> timezone is specified by `<tz>` as a positive or negative offset
> from UTC, in minutes.  For example EST would be expressed in `<tz>`
> by ``-0500''.

Is <tz> /really/ expressed in minutes?  500 minutes is 8 hours 20 minutes.

I know what you mean, of course; and so would anyone reading it - so I suggest 
just dropping the ", in minutes" - as it's not true.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
