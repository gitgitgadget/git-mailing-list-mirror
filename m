From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Improve cached content header of status output
Date: Fri, 05 Jan 2007 03:22:31 -0800
Message-ID: <7vr6u9g1l4.fsf@assigned-by-dhcp.cox.net>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
	<11677659921833-git-send-email-j.ruehle@bmiag.de>
	<459E2E57.6020503@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 12:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2n9g-0004V7-EA
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 12:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbXAELWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 06:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbXAELWd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 06:22:33 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:37124 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161064AbXAELWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 06:22:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105112232.MHPX15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 06:22:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7PNn1W0041kojtg0000000; Fri, 05 Jan 2007 06:22:47 -0500
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <459E2E57.6020503@shadowen.org> (Andy Whitcroft's message of
	"Fri, 05 Jan 2007 10:54:15 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35996>

Andy Whitcroft <apw@shadowen.org> writes:

>> +static void wt_status_print_cached_header(const char *reference)
>> +{
>> +	const char *c = color(WT_STATUS_HEADER);
>> +	color_printf_ln(c, "# Cached changes to be committed:");
>> ...
>
> We seem to be using 'Cached' and 'staged' here.  I thought we had
> updated all the docs to call files in the index "Staged for commit".

	# Changes staged to be committed:

Somebody did not like the verb "stage"; perhaps we can say:

	# You have added changes to these files to be committed:
	...
        # There are yet to be added changes to these files:
	...

?
