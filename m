From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 15:59:05 +1300
Message-ID: <46a038f90801161859n2f7d8c33kb5d359fb25d07488@mail.gmail.com>
References: <478D79BD.7060006@talkingspider.com> <m3bq7lncak.fsf@roke.D-201>
	 <20080117005954.GM18022@lavos.net>
	 <86sl0xfd4e.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brian Downing" <bdowning@lavos.net>,
	"Jakub Narebski" <jnareb@gmail.com>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:59:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFKyk-0000RC-Hf
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYAQC7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750AbYAQC7N
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:59:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:18359 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbYAQC7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 21:59:11 -0500
Received: by ug-out-1314.google.com with SMTP id z38so293307ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vx0ej+Rtqy2Ah4P+GXgwIcyJA5DNpKQwxWj17uTZ4gg=;
        b=vd7KRGUCcW/5vteKSWJ50vRxWEDWLn9bsLtAYoBLGG0hhcpBFJWTmoYOCKpTIOZ4cJqQjKhzri74nribv/QGDwyjHIFM33BXon2UN48NHTV1BlIQ+w9VLNsQtT7YM8XB/E6lr9hlSN874ZY+bBm67s7VdptHJsd8NxOcmHf+yWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NyEZQrmdMJzZZ7LdBuyqlOYqx+LYIKr64XDudzANIH79Qyfnz0WMCB6RP6H5qm+omotYXNsejc4WNcWrFPmF8USfPLZrosRhV+cmTwDcAimLEUGndiiw+yXEO3liXSoTC9cSm466o/66IzVfpJ9aY+X0eBjvS56AThehqZawSLs=
Received: by 10.66.233.14 with SMTP id f14mr2812227ugh.84.1200538746045;
        Wed, 16 Jan 2008 18:59:06 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Wed, 16 Jan 2008 18:59:05 -0800 (PST)
In-Reply-To: <86sl0xfd4e.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70818>

On Jan 17, 2008 2:35 PM, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Brian" == Brian Downing <bdowning@lavos.net> writes:
>
> Brian> Yes, you could use rsync or some other tool, but Git already has the
> Brian> tools available, so why not take advantage of them?
>
> It's very likely that rsync will be faster/better/cheaper/more-flexible
> than git.  "Yes, you could use git, but rsync already does the job
> better, so why not take advantage of it?"  Back at ya.

We do web development, and use various deployment tools, usually git,
git+rsync or git + debian packages.

I find the discussion of git-archive as a deployment tool a bit
worrying - remember that untarring a newer version of the tarball on
top of the old version does not remove old files. In web applications
(and I think the OP is talking about web development) often security
bugs come from sloppy inclusion of files (such as sample AdoDB code).
If you deploy your "security fix" by unpacking a tarball, chances are
you'll wake up to a p0wned server.

cheers,


martin
