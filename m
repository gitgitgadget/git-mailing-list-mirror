From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: Problems trying setup git assistance is needed.
Date: Thu, 5 Jun 2008 23:51:28 -0700
Message-ID: <9af502e50806052351w71fbf437q4012e7607abe8b3d@mail.gmail.com>
References: <Pine.LNX.4.64.0806051545260.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Boyd Lynn Gerber" <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 08:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4VoE-0003P6-PD
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 08:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYFFGva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 02:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYFFGva
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 02:51:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8732 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYFFGv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 02:51:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so587186fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 23:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Fp92xtwJeTd2L7hNYLr++XAlCcAX87t8ZGRASz8QmvI=;
        b=jvqEPqH8AWdFPNhyfDvOzQ/GQKQ3q32qaQrdo92LfYSCWMxmtZoejlrppiok1qUW8t
         s0oSFXtsCrhInae3OpMvhpzzDtqQo257DDK1hrmgvDTydX/1/Yd9RcnTnXVz/XdDegB0
         Zni3kg/jRNF2EC5kmKVuVYFnr/q1XnGjYla/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AAP2Palr5Ufww8JIzMpnk+jYnam0ZZhdal1+kxFkjTpfpMGIwhx6W21ydv2AUYRNcR
         WBJbg1L58hXGvjR5/BZmU0kt0wTymEqDCcwT8CumAfoR26umLkITHy5yXn3Ir5/cFkK1
         cSNE21+38GMs5isprXzv3xwo6HIzDY65Vi/8I=
Received: by 10.86.82.16 with SMTP id f16mr3522913fgb.9.1212735088099;
        Thu, 05 Jun 2008 23:51:28 -0700 (PDT)
Received: by 10.86.95.16 with HTTP; Thu, 5 Jun 2008 23:51:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806051545260.18454@xenau.zenez.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84031>

On Thu, Jun 5, 2008 at 3:03 PM, Boyd Lynn Gerber <gerberb@zenez.com> wrote:
> To meet the requirements for the various
> management systems, I have to have their directory with a copy.

I don't know what this is supposed to mean.

It also doesn't sound like you should be bothering any environment variables.

> git clone /master/git/git /working/git/git
>
> worked and I am able to use the above to pull every thing for git, but the
> tools to convert cvs, hg and svn do not seem to work.

"X doesn't seem to work" is not a good description of a problem.  "I
tried X and expected Y but got Z" is how you should describe your
problems, with verbatim but concise cut/paste of X and Z input and
output.

As an example, did you try:

git svn clone /master/svn /working/svn

i.e., the first line under "Basic Examples" in the git svn manual page?

Backing up a step, though, the point of what you're doing is unclear.
Why bother with /master/svn, rather than just cloning the remote repo?

Bob
