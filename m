From: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
Subject: Re: [PATCH] for-each-ref: Always check stat_tracking_info()'s return value.
Date: Fri, 02 Jan 2015 22:30:24 +0200
Organization: Intel Finland Oy, Open Source Technology Center
Message-ID: <87d26x3oyn.fsf@rkubodac-mobl1.ger.corp.intel.com>
References: <1420230521-8365-1-git-send-email-raphael.kubo.da.costa@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 21:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y795v-0002vR-T7
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 21:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbbABUpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 15:45:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:37169 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbbABUpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 15:45:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Y795k-0002sN-2M
	for git@vger.kernel.org; Fri, 02 Jan 2015 21:45:04 +0100
Received: from 134.191.220.71 ([134.191.220.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 21:45:04 +0100
Received: from raphael.kubo.da.costa by 134.191.220.71 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 21:45:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 134.191.220.71
User-Agent: Gnus/5.130012 (Ma Gnus v0.12) Emacs/24.4 (gnu/linux)
Cancel-Lock: sha1:Hx+TLjkwUqclb99tLqO/yB1Fvik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261984>

Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com> writes:

> Subject: Re: [PATCH] for-each-ref: Always check stat_tracking_info()'s
> return value.

Sorry, this was supposed to be "PATCH v2". The subject's wrong, but the
contents are fine.

> ---
> v2: Use `test_when_finished' to clean up the "parent_gone" branch.
>
>  builtin/for-each-ref.c  | 11 +++++++++--
>  t/t6300-for-each-ref.sh | 15 +++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
