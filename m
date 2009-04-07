From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 10/14] difftool: add various git-difftool tests
Date: Tue, 7 Apr 2009 15:38:35 -0700
Message-ID: <20090407223834.GA71200@gmail.com>
References: <1239092483-14973-1-git-send-email-davvid@gmail.com> <1239092483-14973-3-git-send-email-davvid@gmail.com> <1239092483-14973-4-git-send-email-davvid@gmail.com> <200904071952.21109.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, charles@hashpling.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJxo-0000SJ-4l
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 00:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760251AbZDGWin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 18:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759361AbZDGWim
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 18:38:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:9244 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbZDGWim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 18:38:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2957438rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NcVmZeFMAeWdxTa+EJ0v/x4mB7XdZhoYJEXEv+a8Wpo=;
        b=rxmQl7J/mhYGIwdYMo+T8P0NRtJjN/QXjfGjhtCDsh2x0VJ8TPG2EBF/NKroTdIUR6
         7HZR1gvVmrvd69g6aWNXGQB2M9T+8r/pUso0NzgCphi8uDL1T39y5GQFptR1hWFhf07j
         UWzT7eTAe0xfZDV5tgWMSfk7+4XX6ygLkoE8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gc296SwuGWrNCAve4K4dIMD9qDoJFt1xLwfx3dVwC1Kxqto1uRr62myYp/D7VDmJSP
         lt/fi3tzngKEmuh2SVL17RSybDZ3ySpEB4aeqo8CzVNmwbh4dM20/lGSjaYeDj5TOgKT
         TnFWeIO3RRGeEXTfR0VPoM9b3/rcxOOZSTLVk=
Received: by 10.140.207.18 with SMTP id e18mr196422rvg.4.1239143921550;
        Tue, 07 Apr 2009 15:38:41 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id k2sm23261353rvb.14.2009.04.07.15.38.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 15:38:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200904071952.21109.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116005>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> David Aguilar, 07.04.2009:
> > t7800-difftool.sh tests the various command-line flags,
> > git-config variables, and environment settings supported by
> > git-difftool.
> > 
> > Signed-off-by: David Aguilar <davvid@gmail.com>
> > ---
> > 
> > The original broke the test suite on Mac OS.
> > Testing difftool.<path>.path is hard without internal support
> > for a fake tool.
> 
> Mac OS doesn't have the "echo" command?
> 

Hmmm maybe the thing that validates the merge tool isn't
using the $merge_tool_path when validating.  All I know is that
it was failing so figured I could add it again later.

-- 
		David
