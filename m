From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] Add Documentation/CodingStyle
Date: Thu, 8 Nov 2007 11:29:32 +0000
Message-ID: <e2b179460711080329j4979dc00w421ec79a6f3159ed@mail.gmail.com>
References: <20071106201518.GA6361@ins.uni-bonn.de>
	 <20071106201809.GD6361@ins.uni-bonn.de>
	 <20071106202600.GH6361@ins.uni-bonn.de>
	 <7vtznzf5jb.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0711062317330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 12:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq5Zz-0003Mx-Le
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 12:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758177AbXKHL3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 06:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755927AbXKHL3f
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 06:29:35 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:26681 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758577AbXKHL3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 06:29:34 -0500
Received: by wx-out-0506.google.com with SMTP id h31so138933wxd
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 03:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RwAEgJgHJH7ZEXN3hGSiFvbe+m6Q/f5kRUcYeklZOFY=;
        b=LqYPmX3MNVeSev2QaTLKa7PVgUGh8bNPI18zDESpCL/LCE3rZ4aKxiWY8ep26K2TBLZxlYjzXIbDGhpxYupdtz/eRQbt6Adsmyj0PIg7OsM4+D6wLW6wFJ8yJr/YUGYtCVU9UQ5Wj9tn8fmAB4ex7TLeCWURMale3dNBmUcWgEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZpvYWSvdpScvHC6xc+9HeDySODJWhV0B9gprH3S+5Yo4/6Q1cAWSiNl6RXKEIALi4sSQrqblsIjPYWGNIc2lKxDnLpNMZ+Jd3+jk/G3XDH+Yk5GLD65PY9KEsToM1K5pqxiaNKDa2TlwOFb/FxEw9theShqDq9/+nxg0l/u7Cng=
Received: by 10.90.87.5 with SMTP id k5mr369632agb.1194521372186;
        Thu, 08 Nov 2007 03:29:32 -0800 (PST)
Received: by 10.90.100.12 with HTTP; Thu, 8 Nov 2007 03:29:32 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711062317330.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63996>

On Nov 6, 2007 11:17 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Even if our code is quite a good documentation for our coding style,
> some people seem to prefer a document describing it.

Might this file be a place to document exactly which licenses we
accept code under? I.e. is it GPLv2 only or any license compatible
with GPLv2 ?

Currently I see only GPLv2 in core git, but I have a series of patches
which give me a speed-up of two orders of magnitude for some cases of
at least git-status (on my platform, with my repos etc) and so far my
two approaches involve bringing in code which is either public domain
with restrictions (which may be too onerous for us to carry in
mainline) or 3-clause BSD.

Cheers, Mike
