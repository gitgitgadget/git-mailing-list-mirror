From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2] notes: allow merging from arbitrary references
Date: Sun, 17 Jan 2016 11:00:27 +0100
Message-ID: <CALKQrgfsnhpvqoEMjv40mvb_ZifgXddvimFugnXcMoQH-Hhi7A@mail.gmail.com>
References: <1452883636-27753-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 11:22:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKkTa-0008Kr-D4
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 11:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbcAQKVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 05:21:54 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:63179 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbcAQKVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 05:21:53 -0500
X-Greylist: delayed 1277 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2016 05:21:52 EST
Received: from mail-yk0-f181.google.com ([209.85.160.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1aKk8P-0001Cv-Bz
	for git@vger.kernel.org; Sun, 17 Jan 2016 11:00:33 +0100
Received: by mail-yk0-f181.google.com with SMTP id v14so492515192ykd.3
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 02:00:33 -0800 (PST)
X-Gm-Message-State: ALoCoQlyiumIUYqvLl4gUb/0Ig2trLp6P0LjhoFSZxconrDJw5fsVmbiAMOEpOiJ8vm0INVVmwHqHCWnHqX7PahqWXfwmxndtw==
X-Received: by 10.129.60.12 with SMTP id j12mr13474932ywa.86.1453024827420;
 Sun, 17 Jan 2016 02:00:27 -0800 (PST)
Received: by 10.37.91.10 with HTTP; Sun, 17 Jan 2016 02:00:27 -0800 (PST)
In-Reply-To: <1452883636-27753-1-git-send-email-jacob.e.keller@intel.com>
X-Gmail-Original-Message-ID: <CALKQrgfsnhpvqoEMjv40mvb_ZifgXddvimFugnXcMoQH-Hhi7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284247>

On Fri, Jan 15, 2016 at 7:47 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Create a new expansion function, expand_loose_notes_ref which will first
> check whether the ref can be found using get_sha1. If it can't be found
> then it will fallback to using expand_notes_ref. The content of the
> strbuf will not be changed if the notes ref can be located using
> get_sha1. Otherwise, it may be updated as done by expand_notes_ref.
>
> Since we now support merging from non-notes refs, remove the test case
> associated with that behavior. Add a test case for merging from a
> non-notes ref.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>
> Notes:
>     - v2
>     * don't expand notes-ref to the sha1, in order to support get-ref better
>     * fix failed tests due to mis-use of argv[0] instead of remote_ref.buf
>
> This is a resend, since no one reviewed this last time, and it's been a
> couple of weeks. At least one person has reviewed a previous version,
> but I'd like some fresh eyes on this latest version. This should be
> identical to the previous patch.

Reviewed-by: Johan Herland <johan@herland.net>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
