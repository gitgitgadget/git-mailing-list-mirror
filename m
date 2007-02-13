From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-cvsserver doesn't respect core.sharedrepository
Date: Tue, 13 Feb 2007 18:21:34 +0000
Message-ID: <200702131821.37284.andyparkins@gmail.com>
References: <200702131438.30291.andyparkins@gmail.com> <200702131605.29088.andyparkins@gmail.com> <Pine.LNX.4.63.0702131910020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 19:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2KU-0000Ve-Fa
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXBMSYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbXBMSYf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:24:35 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:3367 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbXBMSYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:24:35 -0500
Received: by wr-out-0506.google.com with SMTP id i31so194603wra
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 10:24:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=i/ZcnXmT0ipD6sYA0xBIuWUncyuxHmKNk/7Te4FPIwfAqwy8y4KMD3L8byLhIXuB4uY9s+OvTBWD7HRDYDI3vqNfdx7+r04Fa0roAz9lL2Jz4KTtSCvgEdodplVf428++viQHt93OptkbeqPnrLENKcXG++ebLVb/BoumaTiAKs=
Received: by 10.90.75.10 with SMTP id x10mr19659174aga.1171391073666;
        Tue, 13 Feb 2007 10:24:33 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id g30sm12474752ugd.2007.02.13.10.24.30;
        Tue, 13 Feb 2007 10:24:31 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.63.0702131910020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39574>

On Tuesday 2007, February 13, Johannes Schindelin wrote:

> Ummm. What I tried to say is that this is intended behaviour, not bad
> behaviour. The file does not have to have write permissions for the
> group. The _directory_ has to have them.

It's not just write permissions.  The default umask could also prevent 
read access by the group - the new ref needs to be readable by the 
group.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
