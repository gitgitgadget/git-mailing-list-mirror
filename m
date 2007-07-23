From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git tree for old kernels from before the current tree
Date: Sun, 22 Jul 2007 20:00:58 -0400
Message-ID: <9e4733910707221700o16659129ra2daed0833f02cf0@mail.gmail.com>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
	 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
	 <20070722211314.GA13850@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Paul Mundt" <lethal@linux-sh.org>,
	"Jan Engelhardt" <jengelh@computergmbh.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 02:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IClMG-00040e-PT
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 02:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbXGWABA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 20:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759818AbXGWABA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 20:01:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:41293 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760830AbXGWAA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 20:00:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1793302wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 17:00:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ULk84YAMxP485l88VQvpKzBNUVsk1rU3k3doHz2zF2ToSJ1yPucvaboFvThcLb4O3Kcb9qfQ9EwI0myiNL/w6H+YmpjPChImfPRhGNGJL1mZaSi3oLiPxnxLqlpkghE/+dtD+ilMqodQpFDi4dSN5QslCOhH7DEGgXtjepzfHEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KL7tuxQQF8Q0bkheamH9koIXHGMI9ODl9PRsys+QUDVGHxdoxPO4i2gykt6z+c/U9g4G1FjH1Ohq08r7e7IxWoeqMxY5OBjF4fAb1VNoQUev/DqcaIe935EwyZij4Gtd8peCvzB3qmu8QjfNKe3f2OL2Yu5nVbwqNyf7JKeqS3c=
Received: by 10.115.89.1 with SMTP id r1mr2469432wal.1185148858278;
        Sun, 22 Jul 2007 17:00:58 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 17:00:58 -0700 (PDT)
In-Reply-To: <20070722211314.GA13850@linux-sh.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53373>

On 7/22/07, Paul Mundt <lethal@linux-sh.org> wrote:
> Anyone still sending 2.4 patches with the intent of them being moved
> forward and applied to a current kernel needs to be killfiled.

These patches are coming from companies that aren't interested in
participating in the GPL process but are being forced into releasing
code because of the license. Some of them will go out of their way to
make the changes difficult to read. All of the patches I am looking at
come from embedded systems, many of these systems are still shipping
2.4 kernels.

Most of the patches contain junk, but there are occasional diamonds.
One I'm looking at contains code for accessing encryption hardware.
The goal is to look at the vendor diffs and see if I can spot anything
useful. Spotting something useful can be hard if there are 100,000
lines of noise in the diffs, I'm also trying to spot missing drivers
so that we can ask for more code.

-- 
Jon Smirl
jonsmirl@gmail.com
