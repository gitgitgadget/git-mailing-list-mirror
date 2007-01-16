From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 23:37:31 +0100
Message-ID: <200701162337.32759.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701161514.47908.jnareb@gmail.com> <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6wvX-0000qB-Cs
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbXAPWhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbXAPWhI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:37:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:38418 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbXAPWhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:37:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1824755uga
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 14:37:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HI16zJWl5lFrDbFSggzZqU3XtXfnQGhO+RHVi46IZpV5C3T/rFfCN0yzZv/ImwHg0YAKEpZxX9AxB5jB3umpIxEHh+qdogCkuNdaWwYksoU3vX+xm91EOl6MunAi92bSk3lY8FLk6MOXoZgoqudB44e3m0KwLnnssclk/sjQb1g=
Received: by 10.67.119.13 with SMTP id w13mr8418916ugm.1168987024346;
        Tue, 16 Jan 2007 14:37:04 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id j2sm7820616ugf.2007.01.16.14.37.03;
        Tue, 16 Jan 2007 14:37:04 -0800 (PST)
To: "Nikolai Weibull" <now@bitwi.se>
User-Agent: KMail/1.9.3
In-Reply-To: <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36974>

Nikolai Weibull wrote:
> On 1/16/07, Jakub Narebski <jnareb@gmail.com> wrote:

>> But I agree that XML is serious overkill...
> 
> I don't know if it was clear from my first mail, but I wasn't
> suggesting --xml as a serious alternative.  My point was that if we're
> going to go through all the fuss of adding all these switches for
> outputting the configuration file in some fixed format, why not go
> with one that at least is universal in some sense (not necessarily
> XML).  And, as Johannes already pointed out, it's very disturbing
> having to dump a configuration file so that it is more easily read by
> other programs.  That would suggest that the ini-based format for
> git's configuration file is suboptimal.

No, ini-based, or rather ini-like format for git configuration
is nice, but I think git is too forgiving in accepting input.
Examples: section header and key/value pair in the same line,
allowing multiple quotes in in value part.

Well, the idea I had was to have --dump switch to git-repo-config
to dump init file as if it was created by git-repo-config invocations,
without any hand editing (canonical format).

-- 
Jakub Narebski
Poland
