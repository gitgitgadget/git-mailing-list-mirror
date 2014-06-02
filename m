From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: 2.0.0 regression? request pull does not seem to find head
Date: Tue, 3 Jun 2014 00:34:56 +0300
Message-ID: <20140602213456.GB17832@redhat.com>
References: <20140602210131.GA17171@redhat.com>
 <xmqqzjhv2e9u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZt0-0001Yi-K5
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaFBVfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:35:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11499 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbaFBVfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:35:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s52LYR1x027157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Jun 2014 17:34:27 -0400
Received: from redhat.com (ovpn-116-42.ams2.redhat.com [10.36.116.42])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s52LYPBh025024;
	Mon, 2 Jun 2014 17:34:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjhv2e9u.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250600>

On Mon, Jun 02, 2014 at 02:27:25PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Looks like pull requests no longer work for me on linux.
> 
> Wasn't "does not seem to find head" was very much deliberate?

I'm sorry I don't understand what you are asking here.
Same thing happens if I use a branch name explicitly, not just HEAD.

> Linus's patch wanted the users to explicitly tell the tool, without
> tool trying to be too helpful and risking to guess incorrectly.

So this is an intentional behaviour change?
Which patch do you refer to?

> > Some other trees (non-linux) work fine but I didn't yet
> > check whether it's the local or the remote tree that's
> > at issue.
> >
> > Or maybe it's a configuration change that I missed?
> >
> > Note: I have
> > [push]
> >         default = matching
> > configured in .gitconfig.
> 
> This should not affect anything in request-pull, I think.

I just thought I'd mention this.
push behaviour is the only big incompatible change I'm aware
of between 1.8 which works for me and 2.0 which doesn't.

-- 
MST
