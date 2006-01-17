From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 17 Jan 2006 12:01:40 -0500
Message-ID: <1137517300.20556.26.camel@dv>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Jan 17 18:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyuDk-00060x-Ui
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 18:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWAQRBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 12:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWAQRBr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 12:01:47 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:44959 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932200AbWAQRBq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 12:01:46 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EyuAV-0006BT-2Y
	for git@vger.kernel.org; Tue, 17 Jan 2006 11:58:51 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1EyuDE-0008Pu-Du; Tue, 17 Jan 2006 12:01:40 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0601160018x206faf9ck@mail.gmail.com>
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14797>

Hello, Catalin!

On Mon, 2006-01-16 at 08:18 +0000, Catalin Marinas wrote:
> On 13/01/06, Pavel Roskin <proski@gnu.org> wrote:
> > 1) "stg new --force" becomes "stg new" and "stg new" becomes "stg new
> > --empty", i.e. empty files can only be created with the "--empty"
> > switch.
> > 2) "stg new --force" becomes "stg record" or something.
> > 3) "stg new --force" becomes "stg new --record" or something.
> > 4) "stg new" works both with and without modified files.
> 
> Regarding (1), the newly created patch is empty anyway, you would need
> to run 'refresh' to add the modified patches to it ('stg series -e'
> would show the empty patches prefixed with a 0).

I was going to suggest that would be logical to run "stg refresh"
implicitly if "stg new" is used on modified files.  But then I realized
that it would be even better if future versions of StGIT allowed to
refresh (i.e. add changes to) patches other that the current one.  In
this case, indeed, you don't want the newly created patch to suck in all
the changes in the local repository.

> Anyway, I would also prefer option 4. If there are no objections, I'll
> modify StGIT accordingly. It would also be useful to have a wiki page
> about StGIT vs. Quilt to show the main differences.

That would be great!

I'm trying to make StGIT my primary development tool, and I think it has
a great potential the could be realized if StGIT is freed from the need
to emulate older tools.

-- 
Regards,
Pavel Roskin
