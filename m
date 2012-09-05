From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/2] Add --expand to 'git notes get-ref'
Date: Wed, 5 Sep 2012 17:58:37 +0200
Message-ID: <CALKQrgdRqd59pfLtpROwxtrFjvO5oYgKKN3KCp1NA4aMEEcj1w@mail.gmail.com>
References: <cover.1346848834.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:58:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9I0A-0008A0-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 17:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2IEP6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 11:58:43 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:63924 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab2IEP6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 11:58:42 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2012 11:58:42 EDT
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1T9I01-0008R3-7z
	for git@vger.kernel.org; Wed, 05 Sep 2012 17:58:41 +0200
Received: by obbuo13 with SMTP id uo13so520869obb.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 08:58:37 -0700 (PDT)
Received: by 10.182.159.42 with SMTP id wz10mr17603810obb.49.1346860717841;
 Wed, 05 Sep 2012 08:58:37 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Wed, 5 Sep 2012 08:58:37 -0700 (PDT)
In-Reply-To: <cover.1346848834.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204833>

On Wed, Sep 5, 2012 at 2:48 PM, W. Trevor King <wking@tremily.us> wrote:
> The second commit makes the expansion less strict about the location
> of note refs.  In his initial mail introducing 'git notes', Johan says
> that note refs should live under 'refs/notes' [1].  This seems like a
> good place for local notes, but note refs from remote repos should
> probably live somewhere else (e.g. 'refs/remote-notes/' or
> 'refs/remotes/<name>/notes/'.  In the initial thread there are a few
> messages talking about looking up reverse mappings under 'refs/notes/',
> but this seems to all have been before the 'refs/notes/<namespace>/'
> stage.  If I'm missing a good reason to keep everything under
> 'refs/notes/', feel free to ignore the second patch.

This has been discussed a couple of times on this list, but it never
resulted in any actual changes. Read up on this thread to get some
context:

http://thread.gmane.org/gmane.comp.version-control.git/160503


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
