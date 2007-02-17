From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: suggested feature: someone mails me a blob, git please tell me what it is
Date: Sat, 17 Feb 2007 21:40:51 +0000
Message-ID: <200702172140.54203.andyparkins@gmail.com>
References: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com> <20070217061016.GA27813@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mike Coleman <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 22:44:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIXLd-00041Q-Eg
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 22:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbXBQVnw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 16:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbXBQVnw
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 16:43:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:60716 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbXBQVnv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 16:43:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so402835uga
        for <git@vger.kernel.org>; Sat, 17 Feb 2007 13:43:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mwW4asuZdrU7XqDLZvL2KBRiiQRXD0p5tOkbkTFpvwm4SVKzmj1WCDZMmv3wg4tDbs93d33ZVI7tkluWOARVKvV/QEolzxYJQYmtMeAUQEMtAGvtKmzuu+PVivORYCSZUyjdy/F7DQ49fOolC+2EE6P/wh91J+kEflBBiAOuJ7E=
Received: by 10.66.244.11 with SMTP id r11mr4756620ugh.1171748630444;
        Sat, 17 Feb 2007 13:43:50 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 32sm6408754ugf.2007.02.17.13.43.46;
        Sat, 17 Feb 2007 13:43:46 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070217061016.GA27813@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40015>

On Saturday 2007, February 17, Shawn O. Pearce wrote:

> Rather than embedding something like "$Id$" on a per-file basis
> use the output of git-describe in your build process to insert the

Actually this isn't entirely enough.  The /only/ thing I miss from 
subversion is $Id$; but not in source files - that's easily solved with 
a bit of git-describe magic in the Makefile - no, I miss embedding it 
inkscape generated .svg files, so that my title block on diagrams gets 
automatically assigned a version code.

Q: How lazy am I?  A: I can't be bothered to say... 

Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
