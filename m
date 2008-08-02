From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Sat, 02 Aug 2008 10:36:38 -0700
Message-ID: <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
References: <1217684549.8296.10.camel@heerbeest>
 <20080802172742.GT32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Nieuwenhuizen <janneke-list@xs4all.nl>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Aug 02 19:38:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPL49-0004u1-M6
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 19:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYHBRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 13:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbYHBRgq
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 13:36:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYHBRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 13:36:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C4202481CF;
	Sat,  2 Aug 2008 13:36:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CBEA1481CE; Sat,  2 Aug 2008 13:36:40 -0400 (EDT)
In-Reply-To: <20080802172742.GT32184@machine.or.cz> (Petr Baudis's message of
 "Sat, 2 Aug 2008 19:27:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9353BF1A-60B9-11DD-8523-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91159>

Petr Baudis <pasky@suse.cz> writes:

>   Hi!
>
> On Sat, Aug 02, 2008 at 03:42:29PM +0200, Jan Nieuwenhuizen wrote:
>> Signed-off-by: Jan Nieuwenhuizen <Jan Nieuwenhuizen janneke@gnu.org>
>
>   Just your email should be within the <> brackets.
>
>> ---
>>  git-svn.perl |   11 ++++++++++-
>>  1 files changed, 10 insertions(+), 1 deletions(-)
>
>   You forgot to document your option. (And possibly write a testcase.)

I am not sure if this is generic enough to be in git-svn.perl itself, or
perhaps there should be a hook make_log_entry() would call in the form of
some Perl scriptlet given by the user to munge $log_entry{log}, which
would be very specific to each project.
