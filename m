From: James Pickens <jepicken@gmail.com>
Subject: Re: [PATCH] Add commit.status, --status, and --no-status
Date: Mon, 7 Dec 2009 17:39:51 -0700
Message-ID: <885649360912071639o4c609dbapea9891aae639194c@mail.gmail.com>
References: <20091206131217.GA12851@sigill.intra.peff.net> 
	<1260225927-33612-1-git-send-email-jh@jameshoward.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "James P. Howard, II" <jh@jameshoward.us>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:40:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHo7m-0006Py-7B
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 01:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbZLHAkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbZLHAkG
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 19:40:06 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:50790 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965208AbZLHAkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 19:40:05 -0500
Received: by iwn35 with SMTP id 35so3499399iwn.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 16:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1ZzotCMmL7rqWrreMy5O5yNFMDKVxStrDAYZDwgnciI=;
        b=kSlJGi5vufR01NaTfSPG8vKt6wvqQ0o0UcwisQc+yqr5YQFfz+75EUCR6744QrHY26
         cY02sdSYKVqoYbjw1beVP9RN4z+5P+Z1fJIYP+WenlxV/CcFJEwfPwN2IWBgOQ1tVYKe
         KlfFmcHggaBNM8l4XnV+Fw/utTd6mhcvTx3m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=q6bSvjpgvJbXngxSz3himcRTKpS+6T2nt0I2sVqShuPdBxy7uVeSF3clrYSRTlxBWk
         9JP4fiyuEYBR+W87q+ox5auZm42fAesX4SGlxonEDb31ENVltT9CoqeJqCxXIDhLjbK9
         uhAp8jyQmtyRM+AeI3VRUjtFbmfnQ03pSIptA=
Received: by 10.231.125.13 with SMTP id w13mr1056122ibr.32.1260232811123; Mon, 
	07 Dec 2009 16:40:11 -0800 (PST)
In-Reply-To: <1260225927-33612-1-git-send-email-jh@jameshoward.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134793>

On Mon, Dec 7, 2009, James P. Howard, II <jh@jameshoward.us> wrote:
> This commit provides support for commit.status, --status, and
> --no-status, which control whether or not the git status information
> is included in the commit message template when using an editor to
> prepare the commit message.  It does not affect the effects of a
> user's commit.template settings.

At the risk of sounding like a curmudgeon, I have to register an objection
to this _as a config option_, for the same reasons that I objected to the
'grep --full-tree' config option [1].  Both options fundamentally change
user visible behavior, both options IMHO will be used by a small minority
of git users, and in both cases, the desired behavior can be attained using
aliases in combination with a new command line option.

Sorry if I'm obstructing progress, but I think that, for the good of the
Git community as a whole, it's best to keep the number of config options
(and to a lesser extent, command line options) as low as possible.

Note that I do not object to adding --no-status as a command line option.

[1] http://article.gmane.org/gmane.comp.version-control.git/133681

James
