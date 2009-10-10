From: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Sat, 10 Oct 2009 10:12:15 +0000 (UTC)
Message-ID: <slrnhd0nfv.tq2.antti-juhani@kukkaseppele.kaijanaho.fi>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <7vskdss3ei.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 10 12:16:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwZ0C-00033Z-Nb
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 12:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494AbZJJKNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 06:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757432AbZJJKNW
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 06:13:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:38553 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757430AbZJJKNV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 06:13:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MwYwN-0001Zs-T1
	for git@vger.kernel.org; Sat, 10 Oct 2009 12:12:43 +0200
Received: from a91-156-165-180.elisa-laajakaista.fi ([91.156.165.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 12:12:43 +0200
Received: from antti-juhani by a91-156-165-180.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 12:12:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-156-165-180.elisa-laajakaista.fi
User-Agent: slrn/pre1.0.0-11 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129877>

On 2009-10-09, Junio C Hamano <gitster@pobox.com> wrote:
>> +If there is no repository at $GIT_URL, the server MUST respond with
>> +the '404 Not Found' HTTP status code.
>
> We may also want to add
>
>     If there is no object at $GIT_URL/some/path, the server MUST respond
>     with the '404 Not Found' HTTP status code.
>
> to help dumb clients.

In both cases - is it really necessary to forbid the use of 410 (Gone)?

-- 
Mr. Antti-Juhani Kaijanaho, Jyvaskyla, Finland
