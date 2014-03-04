From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue, 04 Mar 2014 11:34:39 +0100
Message-ID: <87ha7ei75s.fsf@fencepost.gnu.org>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu>
	<87ppm2i9ot.fsf@fencepost.gnu.org> <5315A974.5000104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 11:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKmgP-0002FX-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 11:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858AbaCDKel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 05:34:41 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:44653 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbaCDKek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 05:34:40 -0500
Received: from localhost ([127.0.0.1]:43694 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKmgK-0000Yc-3y; Tue, 04 Mar 2014 05:34:40 -0500
Received: by lola (Postfix, from userid 1000)
	id A8212E04EF; Tue,  4 Mar 2014 11:34:39 +0100 (CET)
In-Reply-To: <5315A974.5000104@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 04 Mar 2014 11:22:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243337>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> BTW, I purposely didn't use a "for" loop at the end (even though I
> usually like them) because I wanted to keep it prominent that path is
> being updated to the value of slash.  Putting that assignment in a for
> loop makes it easy to overlook because it puts "path" in the spot that
> usually holds an inconsequential iteration variable.

Reasonable.

-- 
David Kastrup
