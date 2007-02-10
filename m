From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: restriction of pulls
Date: Sat, 10 Feb 2007 09:59:38 +0000
Message-ID: <200702100959.40401.andyparkins@gmail.com>
References: <200702091149.12462.duelli@melosgmbh.de> <200702091645.33384.andyparkins@gmail.com> <45CCB041.1000500@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christoph Duelli <duelli@melosgmbh.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 11:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFp44-0006SJ-3r
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 11:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbXBJKCg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 05:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbXBJKCg
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 05:02:36 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:49454 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbXBJKCf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 05:02:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1050431nze
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 02:02:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LDp8Ds0qWdelqNakTFDNilxuT95NrhjxrXQvdW0qpZqxSB38Cxowmq/000kDnrgqBHZe+e7uakjl2xuz2Z9wLausG/50zczmqSw6cuS+AHSeYDmL6OR00+1GYNWYSb2pmIbcqm6sN2NaiFgt66csnvqxc4uNfdfTTiUI7mS8TT8=
Received: by 10.65.254.5 with SMTP id g5mr4015945qbs.1171101753752;
        Sat, 10 Feb 2007 02:02:33 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id f12sm4603659qba.2007.02.10.02.02.30;
        Sat, 10 Feb 2007 02:02:30 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <45CCB041.1000500@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39214>

On Friday 2007, February 09, Rogan Dawes wrote:

> Well, the new commit would have the previous commit as its direct
> parent, even though it may not have all the blobs to support it.

This I agree with; this seems like the way that a partial checkout would 
be supported.

As you say - there would be no need to have the blobs available for 
objects you aren't altering.  Unfortunately, it seems like it would be 
a huge amount of work to actually do.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
