From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 08:41:29 +1200
Message-ID: <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Markus Schiltknecht" <markus@bluegap.ch>,
	"Git Mailing List" <git@vger.kernel.org>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org
X-From: git-owner@vger.kernel.org Wed Sep 13 22:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbY6-0002Hy-Ge
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 22:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWIMUlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 16:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIMUlb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 16:41:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:10018 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751179AbWIMUla (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 16:41:30 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1811202nfa
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 13:41:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bgnuCO5u1QukEwbWULPYqvEz19VvoAHlmkPO/pw5LPmXg4aPlVLPJ7NPBJHK+sWSDr+rBuwGmwDUDaTDHCHd7bXmQKtm7VoWsUztU54DD68L7WmJNJYuTMl7lr7Q1jkrqFOXsrQdWOaoL4QzdEbJ3SkJNq3ZvEITvwMQ9OlV0gc=
Received: by 10.49.75.2 with SMTP id c2mr11339158nfl;
        Wed, 13 Sep 2006 13:41:29 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 13 Sep 2006 13:41:29 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26938>

On 9/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> Let's copy the git list too and maybe we can come up with one importer
> for everyone.

It's a really good idea. cvsps has been for a while a (limited, buggy)
attempt at that. One thing that bothers me in the cvs2svn algorithm is
that is not stable in its decisions about where the branching point is
-- run the import twice at different times and it may tell you that
the branching point has moved.

This is problematic for incremental imports. If we fudged that "it's
around *here*" we better remember we said that and not go changing our
story. Git is too smart for that ;-)


martin
