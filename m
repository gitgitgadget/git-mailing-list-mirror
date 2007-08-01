From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 10:33:00 +0200
Message-ID: <200708011033.00873.jnareb@gmail.com>
References: <200708010216.59750.jnareb@gmail.com> <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 10:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG9fv-0002CD-TN
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 10:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695AbXHAIfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756680AbXHAIfS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 04:35:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:45235 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237AbXHAIfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 04:35:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so39017nfb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 01:35:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aGQ5XZgkr+1lq39XoTrKxtqBoRTlv28ngDkaDWWD4AXr93SsfO/KBa+vvhU2F9WgbOUdE6fVaSAR9xOJPyl/0IgCsQwYHXFtKxFN8hEmEK0eHxwVvXUpKODoqRPqi/Py4hsbTgtANUu8DsjI49XXiGj9R4hTQf6t9YH8m1NhinA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WCWjFajC7FJOgxhvDoDXHg6O88mL0WT4QYkBUV1M6A9RS5ikw4vBv4l5I9HX/Pa9jl5M1h9yDRalKlQRgwQkwMtZtr1L3DKt8NWoL5XrMloiuERWuPboHXTdtLjjsuA1IC7rTUTWrTR+LqwmUZF55Nyih4unRP21WjKLXg87vc4=
Received: by 10.86.100.7 with SMTP id x7mr362453fgb.1185957315446;
        Wed, 01 Aug 2007 01:35:15 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 28sm948662fkx.2007.08.01.01.35.06
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 01:35:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54415>

Linus Torvalds wrote:

> (The "nonconflicting merge" is probably - once more - the diffstat 
> generation that bites us. That's generally the most costly thing of the 
> whole merge, but I *love* the diffstat).

http://bryan-murdock.blogspot.com/2007/03/cutting-edge-revision-control.html
doesn't tell what is the directory structure of imported files.
If it is flat, then git does not use advantage of hierarchical tree
structure.

By the way, I guess that "nonconflicting merge" is trivial tree-level
merge, as "no changes" merge should be faster (or fast-forward).

About clone: there was "pack loose, copy existing packs" idea. I don't
remember what happened with it. At least for local clone it would be
nice.

-- 
Jakub Narebski
Poland
