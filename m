From: Torstein Hegge <hegge@resisty.net>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Sun, 3 Nov 2013 20:15:33 +0100
Message-ID: <20131103191533.GC7462@pvv.ntnu.no>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 03 20:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd39k-00056o-7M
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 20:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab3KCTQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 14:16:06 -0500
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:52007 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3KCTQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 14:16:05 -0500
Received: from torstehe by microbel.pvv.ntnu.no with local (Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1Vd393-0000P2-Ox; Sun, 03 Nov 2013 20:15:33 +0100
Content-Disposition: inline
In-Reply-To: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237275>

On Fri, Nov 01, 2013 at 15:52:06 -0700, Junio C Hamano wrote:
> * th/reflog-annotated-tag (2013-10-28) 1 commit
>   (merged to 'next' on 2013-11-01 at 8b154cc)
>  + reflog: handle lightweight and annotated tags equally
> 
>  "git log -g $annotated_tag", when there is no reflog history, should
>  have produced a single output entry (i.e. the ref creation event),
>  but instead showed the history leading to the tag.

This isn't really what th/reflog-annotated-tag does, 
"git log -g $annotated_tag" now produces no output.

Is the proper behavior to output the ref creation event? In that case,
should the same happen for lightweight tags?

Or am I missing something related to "when there is no reflog history"?


Torstein
