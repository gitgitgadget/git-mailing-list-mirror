From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Conforming to pep8
Date: Fri, 09 May 2014 02:18:54 -0500
Message-ID: <536c815ee0b9c_182dd0d3104b@nysa.notmuch>
References: <20140509015429.GA550@wst420>
 <536c3911ea173_741a161d310f2@nysa.notmuch>
 <20140509035759.GA9051@wst420>
 <536c5b4d9e2c9_377dfcb2f02b@nysa.notmuch>
 <20140509051623.GB9051@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: William Giokas <1007380@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 09:19:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wif5I-0007jd-WF
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbaEIHTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:19:01 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:47526 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbaEIHS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:18:59 -0400
Received: by mail-yk0-f171.google.com with SMTP id 142so3118053ykq.2
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=VdN+MdVtQdcnmGJOHOYMRJX0FZQ+0nV3Po/4/eSbJZE=;
        b=ADejZhDv+UxIPc+pjm8q3GSPQOytI57pFBIpftPwuOdXzEsdjegkqw+HBZSKe9WaiV
         y01sD5mjXakmKYjbWu6ZkosyoaWLnchbAKaOxAT9cD3nIE56V7Jcl8UHSj+8qU/8d6Sl
         V/kRTMa/D8ZHAqCUivYvRGhB1gB6B/f2E/+M/DZHkCE2w2c+yU035Y0GmDNct4gVgB6N
         HicviWPUF88l7f4N3Q9GyOZSqxiq/8qfZPbD5niGyHxLyx/tOg4iDkuCGo+VjawpwTuz
         /CJM/qqY+f/WU6Ur+WPBMHA+VFxiSNTXbBsM1+Yfry6Bt5MdmrDiw1bttA03YANPEDXu
         F9LQ==
X-Received: by 10.236.78.168 with SMTP id g28mr12129413yhe.157.1399619938947;
        Fri, 09 May 2014 00:18:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n5sm5024246yhn.43.2014.05.09.00.18.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 00:18:57 -0700 (PDT)
In-Reply-To: <20140509051623.GB9051@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248521>

William Giokas wrote:
> On Thu, May 08, 2014 at 11:36:29PM -0500, Felipe Contreras wrote:
> > William Giokas wrote:
> > > E401: Multi-line imports seems like something that would just be
> > > changing one line
> > 
> > Yes, and make the code very annoying.
> 
> It's 1 extra line in git-remote-hg, and 4 lines in git-remote-bzr.

Ah, it refers to the '^import *' not '^from x import'. That's fine then.

> > > E302: Blank lines don't seem to be that hard to do either. That can even
> > > be automated quite reliably. It shouldn't detract from the readability,
> > > juts makes the file a bit longer.
> > 
> > The problem is not that it's hard to do, the problem is that it makes
> > the code uglier.
> 
> I would disagree, but this is one of the less important things.
> 
> > > E20{1,2,3}: Extra whitespace is something that just makes things more
> > > consistent and readable.
> > 
> > I don't see how this:
> > 
> >   {'100755': 'x', '120000': 'l'}
> > 
> > Is more readable than this:
> > 
> >   { '100755': 'x', '120000': 'l' }
> > 
> > No strong opinion on this one though.
> 
> It's not so much that it's wrong or less readable, but there is
> inconsistency on this one and I'd err pep8. Again, will send a patch to
> your tree for you to review, though it looks like you mostly fixed this
> in [1].

I don't see inconsistency within the script. All the hashes are in the
form of { content }.

> > > >   max-line-length = 160
> > > 
> > > The standard states that this should, at most, be increased to a value
> > > between 80 and 100.
> > 
> > And why's that?
> > 
> > This has been discussed many times in the LKML, and the end result is
> > that we don't live in the 60's, our terminals are not constrained to 60
> > characters. Going beyond 100 is fine.
> 
> Fair enough. At the same time, it'd only change 14 lines in the current
> git.git tree and would probably increase the readability of some of the
> sections. I noticed that some of the changes in the referenced patch
> actually fixed this on a few lines as well.

If the result is not so horrible I would consider this, otherwise I'll
just ignore the warning.

-- 
Felipe Contreras
