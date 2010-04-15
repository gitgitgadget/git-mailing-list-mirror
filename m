From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] format-patch: use current date in mbox 'From COMMIT
 DATE' header line
Date: Thu, 15 Apr 2010 16:16:21 +0100
Message-ID: <20100415151619.GK12365@arachsys.com>
References: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 17:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Qnz-0002Dg-8p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 17:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab0DOPQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 11:16:29 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:57217 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab0DOPQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 11:16:27 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O2Qnn-0001sn-49; Thu, 15 Apr 2010 16:16:24 +0100
Content-Disposition: inline
In-Reply-To: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144993>

Chris Webb <chris@arachsys.com> writes:

> Put the current date in the 'From COMMIT DATE' header line instead of using
> the fixed date 'Mon Sep 17 00:00:00 2001'. A DATE_UTC mode for show_date() is
> introduced so we can easily generate this line in the correct format.

...but this will break t4013-diff-various which expects the exact date
string 'Mon Sep 17 00:00:00 2001' in the mbox header. Patch to fix this test
to follow!

Cheers,

Chris.
