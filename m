From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 10:38:20 +0200
Message-ID: <86fy1b2goz.fsf@lola.quinscape.zz>
References: <20070918223947.GB4535@artemis.corp>
	<20070918224122.2B55D344AB3@madism.org> <46F0C3AB.8010801@op5.se>
	<20070919080030.GA28205@artemis.corp> <46F0D8E2.5090706@op5.se>
	<20070919082111.GB28205@artemis.corp>
	<86r6kv2h64.fsf@lola.quinscape.zz>
	<7vwsunoy3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 10:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXv8S-0007X8-1R
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbXISImL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbXISImJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:42:09 -0400
Received: from main.gmane.org ([80.91.229.2]:54417 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754151AbXISImH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:42:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXv7O-0005tp-NI
	for git@vger.kernel.org; Wed, 19 Sep 2007 10:41:10 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 10:41:10 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 10:41:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <7vwsunoy3d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 19 Sep 2007 01\:31\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:Yr5y1vhMjoGSQvDrA8h4rorkEtY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58699>


[Also posted to the list via gmane, so reply there if appropriate]

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>>
>> Esc x diff-mode RET
>
> Be careful when you edit format-patch output.  It seems that
> diff-mode tends to mistake the trailing "signature separator" at
> the end as if it is a removal of a line from the preimage, and
> editing the last hunk ends up miscalculating the number of lines
> in it.  It might have been fixed in the latest version but I was
> burned by it number of times.

Would you be able to prepare an example and submit it using
M-x report-emacs-bug RET (probably using an attachment)?

Emacs 22.2 is likely to come out in a few months mainly as a bug fix,
incremental change and maintenance release to 22.1, and this would be
very much the kind of bug that warrants getting fixed, in particular
since it appears likely that Emacs 22.2 will come with git support in
VC.

If there is a good test case known to fail in your Emacs version, it
would be quite easy to verify that it is or gets fixed in 22.2

Thanks,

-- 
David Kastrup
