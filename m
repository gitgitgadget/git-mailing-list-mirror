From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 14:14:55 +1300
Message-ID: <46a038f90801221714x1c31ac8du7944980d47335263@mail.gmail.com>
References: <alpine.LFD.1.00.0!801211407130.2957@woody.linux-foundation.org>
	 <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org>
	 <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org>
	 <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
	 <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	 <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org,
	"Kevin Ballard" <kevin@sb.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 02:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHUDB-0007bN-RZ
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 02:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYAWBPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 20:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYAWBPA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 20:15:00 -0500
Received: from hu-out-0506.google.com ([72.14.214.224]:61663 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYAWBO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 20:14:58 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1121159hue.21
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 17:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ouO8a2m0crt6WAcZkcYDs9I77bsZ2cZKf2GovzpvhWA=;
        b=PY9GYU/+grlb14YNoR/uv2PIKKDgpzLYRhO7Ftdw5p62NYSZ6PzZJLK3m01ARnADcJnka/erjj5P51W5mU1WnT45dZFxOIBRM4JUAk7P2xtJtefvir5d+STvW1tYqRjG5Tku/2IZZKCgS0g7M+0wZsHRmlgLOUDBLjBSkCi+nec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H9/KM7gscaPAsoYsi5fw4UDNiekTouAn5apnsotx3NraxSt/1dyABNkWTUkoKtkKKbPaxMUotjENzmUgr0FpQYghiXta/DWSkxh2KZYJfX9GOzMFWo8bj54CP/2umv4kpYYW+sBbGWXkvP9Rzet7+XUFz8Pc6YwpEy1fPO0vym8=
Received: by 10.67.116.11 with SMTP id t11mr271856ugm.61.1201050895263;
        Tue, 22 Jan 2008 17:14:55 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 22 Jan 2008 17:14:55 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71483>

On Jan 23, 2008 1:38 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> One thing I'd like somebody to check: what _does_ happen with OS X and NFS
> (OS X as a client, not server)? In particular:
>
>  - Is it suddenly sane and case-sensitive?

Yes. Similarlty with UFS partitions. After much grief with
case-insensitivity on OSX I reinstalled the OS on a UFS partition,
only to find that most 3rd party apps can't cope with case-sensitive
FSs (this was a while ago, I hope it's gotten better).

>  - Does the NFS client do any unicode conversion?

Don't know, unfortunately. I suspect both bits of mangling happen in
the fs code.


martin
