From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Wed, 27 Jan 2016 20:56:47 -0600
Message-ID: <87fuxil8cw.fsf@waller.obbligato.org>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
	<xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
	<87twmbaizo.fsf@waller.obbligato.org> <569EE046.9040506@semantics.de>
	<871t9cvqsp.fsf@waller.obbligato.org> <56A4CC85.90705@semantics.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: Marcus Brinkmann <m.brinkmann@semantics.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 03:57:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOclX-0005t6-DP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 03:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300AbcA1C44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 21:56:56 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:39383 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755296AbcA1C4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 21:56:54 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aOcnF-0003fc-Jq; Wed, 27 Jan 2016 20:58:45 -0600
In-Reply-To: <56A4CC85.90705@semantics.de> (Marcus Brinkmann's message of
	"Sun, 24 Jan 2016 14:07:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Marcus Brinkmann <m.brinkmann@semantics.de> writes: > With
    my patch, "git subtree split -P" produces the same result (for my > data
   set) as "git filter-branch --subdirectory-filter", which is much > faster,
    because it selects the revisions to rewrite before rewriting. > As I am not
    using any of the advanced features of "git subtree", I will > just use "git
    filter-branch" instead. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- ------------------------------------ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284976>

Marcus Brinkmann <m.brinkmann@semantics.de> writes:

> With my patch, "git subtree split -P" produces the same result (for my
> data set) as "git filter-branch --subdirectory-filter", which is much
> faster, because it selects the revisions to rewrite before rewriting.
> As I am not using any of the advanced features of "git subtree", I will
> just use "git filter-branch" instead.

Heh.  :)

I hope to replace all that ugly split code with filter-branch as you
describe but there are some cases where it differs.  It may be that your
changes fix some of that.

Are you still able to do a re-roll on this?

                      -David
