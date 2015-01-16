From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PULL] git-svn updates from Ramkumar
Date: Thu, 15 Jan 2015 19:18:24 -0500
Message-ID: <CALkWK0kFngxd2uwHjAtov+9rUbo13OOoeAhmvbxxsz39hmMnaw@mail.gmail.com>
References: <20150115090703.GA12333@dcvr.yhbt.net> <xmqqr3uv7u7v.fsf@gitster.dls.corp.google.com>
 <20150115224652.GA25482@dcvr.yhbt.net> <xmqqtwzr4ofo.fsf@gitster.dls.corp.google.com>
 <CALkWK0kHQ-qhD3p0_VEhVrbD39yV=F5t2nQZ4D6RKP_gpg9tKA@mail.gmail.com> <20150116000802.GA8616@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBud5-0001FJ-9K
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 01:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbAPATG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 19:19:06 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42488 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbAPATF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 19:19:05 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so18118308iec.5
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 16:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sXiv4zfTR4sF7/5rQgCT0QKa1UiuHqXrWz+cN+EdBS8=;
        b=SigO6VQ+RPfPF2pvRltBU3x+ohxkPlmwPwhthWrxLi/ebGLsMiu7rPg7Veain8DtRT
         HiyulEgNyPvqEpZ1hKm/fCIS4wP3IU/uuwZgc+RpkpnWuhbcwuEhHTyvvyMMywAbu1v4
         qWjLdK2rDDHIqRH6i6UfSYuDT6ZTK5kN0ur3SG9Hm+tzH02jLeAnqscMpD2SYoy0I0iN
         CkQUuGmIvNQZx4nb5kkbh1/GTGGIApVBVHcrzATshwdatojll+NIKokNaGnr1ct7+9/V
         jJPsfpfnqBGYjWcNnzr6E8+onoqCPu79rpZbyer48Ovn2JqDiP8H1lJ10hqEzjT7pjcg
         Lg3Q==
X-Received: by 10.42.203.199 with SMTP id fj7mr12615684icb.60.1421367544555;
 Thu, 15 Jan 2015 16:19:04 -0800 (PST)
Received: by 10.107.13.18 with HTTP; Thu, 15 Jan 2015 16:18:24 -0800 (PST)
In-Reply-To: <20150116000802.GA8616@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262532>

Eric Wong wrote:
> I haven't seen this before.  Which SVN Perl binding version are you
> using?  Perhaps your "svnadmin" tool is from a different SVN version
> or installation of SVN than your Perl bindings?

I have two installations of Subversion: the system one is at
/Library/Developer/CommandLineTools @ version 1.7.17, and the brew
installed one is at /usr/local @ version 1.8.10. When I build git from
scratch, it links to the dated SVN bindings for some reason. I suspect
I have to tweak $PERL5LIB?

Can we patch git-svn to link to the Right one on OS X?
