From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: don't output git commits in quiet mode
Date: Sun, 29 Mar 2009 23:44:23 -0700
Message-ID: <7vvdprjyrc.fsf@gitster.siamese.dyndns.org>
References: <49CFCD5A.1080801@simon.arlott.org.uk>
 <20090329224324.GB20675@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Arlott <simon@fire.lp0.eu>, gitster@pobox.com,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 08:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoBG3-0006YE-7c
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 08:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497AbZC3God (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 02:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbZC3Goc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 02:44:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbZC3Gob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 02:44:31 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 364EAA9B5;
	Mon, 30 Mar 2009 02:44:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7AAD7A9B4; Mon,
 30 Mar 2009 02:44:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3870956A-1CF6-11DE-BD78-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115086>

Eric Wong <normalperson@yhbt.net> writes:

> Simon Arlott <simon@fire.lp0.eu> wrote:
>> Ideally only errors should be output in this mode so fetch
>> can be run from cron and normally produce no output. Without
>> this change it would output a single line on each git commit,
>> e.g.
>> r1909 = 32ef87860662526d4a62f903949ed21e0341079e (u2_10_12_branch)
>> 
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>
> Thanks Simon,
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
> and pushed to git://git.bogomips.org/git-svn

... and pulled from there.  Thanks, both.
