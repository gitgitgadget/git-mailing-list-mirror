From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: pass --invert-grep option down to "git log"
Date: Sun, 22 Mar 2015 14:39:40 +1100
Message-ID: <20150322033940.GC14271@iris.ozlabs.ibm.com>
References: <xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
 <1421112812-13578-1-git-send-email-ottxor@gentoo.org>
 <xmqqd25a71rt.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZWlq-0005O6-6h
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 04:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbbCVDll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 23:41:41 -0400
Received: from ozlabs.org ([103.22.144.67]:54456 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbCVDlc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 23:41:32 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0B22114018C; Sun, 22 Mar 2015 14:41:29 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <xmqqd25a71rt.fsf_-_@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266045>

On Sun, Feb 15, 2015 at 11:29:10PM -0800, Junio C Hamano wrote:
> From: Christoph Junghans <ottxor@gentoo.org>
> Date: Mon, 12 Jan 2015 18:33:32 -0700
> 
> "git log --grep=<string>" shows only commits with messages that
> match the given string, but sometimes it is useful to be able to
> show only commits that do *not* have certain messages (e.g. "show
> me ones that are not FIXUP commits").
> 
> Now the underlying "git log" learned the "--invert-grep" option.
> The option syntactically behaves similar to "--all-match" that
> requires that all of the grep strings to match and semantically
> behaves the opposite---it requires that none of the grep strings to
> match.
> 
> Teach "gitk" to allow users to pass it down to underlying "git log"
> command by adding it to the known_view_options array.
> 
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, applied.

Paul.
