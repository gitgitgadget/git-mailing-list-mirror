From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 18:54:34 -0400
Message-ID: <9e4733910609091554m2a8a001axd575defff9a0e7a9@mail.gmail.com>
References: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	 <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	 <17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	 <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	 <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	 <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	 <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	 <20060909204307.GB16906@coredump.intra.peff.net>
	 <Pine.LNX.4.64.0609091433460.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"linux@horizon.com" <linux@horizon.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 10 00:55:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMBj0-0002kZ-JE
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 00:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWIIWyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 18:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWIIWyg
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 18:54:36 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:19679 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964874AbWIIWyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 18:54:35 -0400
Received: by py-out-1112.google.com with SMTP id n25so1467284pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 15:54:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YnrvLu6pV4Cfl/XxVok+Nv019thGaWVlJY8pUWnts5BZBQSZy7zsIVMwjHPLByq1reluLQkWptoGaUoLPt3uqTO/bfzeR/fqhnWN2i8QoHD9UczrGFdieHxLLsGdrlI7MKK3wTDnPQZj1TxMW16yRQRT9hDJIcBMKyCYDJynlXs=
Received: by 10.35.22.17 with SMTP id z17mr5662517pyi;
        Sat, 09 Sep 2006 15:54:35 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sat, 9 Sep 2006 15:54:34 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609091433460.27779@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26774>

On 9/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
> However, it's just a heuristic. "Most recent date" is not well-defined in
> a distributed environment that doesn't have a global clock. If somebody
> does commits on a machine that has the clock just set wrong, "most recent"
> may well not be _really_ recent.

When a merge happens could git fix things up in the database by adding
a corrected, hidden time stamp that would keep things from having an
out of order time sequence? That way you wouldn't need to rediscover
the out of order commit each time the tree is generated.

-- 
Jon Smirl
jonsmirl@gmail.com
