From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 18:44:20 -0700
Message-ID: <7v4pifw45n.fsf@gitster.siamese.dyndns.org>
References: <767502.77573.qm@web31812.mail.mud.yahoo.com>
	<Pine.LNX.4.64.0709010224410.28586@racer.site>
	<20070901013159.GP1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	jnareb@gmail.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 01 03:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRI3u-0004l8-Az
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 03:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbXIABoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 21:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbXIABob
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 21:44:31 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514AbXIABo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 21:44:29 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 88D02129D6D;
	Fri, 31 Aug 2007 21:44:45 -0400 (EDT)
In-Reply-To: <20070901013159.GP1219@pasky.or.cz> (Petr Baudis's message of
	"Sat, 1 Sep 2007 03:31:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57244>

Petr Baudis <pasky@suse.cz> writes:

> On Sat, Sep 01, 2007 at 03:25:16AM CEST, Johannes Schindelin wrote:
>> On Fri, 31 Aug 2007, Luben Tuikov wrote:
>> 
>> > So what's the review process now?
>> 
>> Umm.  Pasky set it up, so it's Pasky who decides what goes in and what 
>> not.  What exactly is your problem?
>
>   Junio will pull from it, so he has full right to ask. :-)

Well, I won't blindly pull from it, but honestly when it comes
to gitweb I trust Pasky's judgement as much as I trust myself,
if not even more.  And I think the review process Pasky
described is good --- people will see both the patches on the
list and code in action at repo.or.cz/.

I am a bit worried about the 'master' being a "StGIT stack",
though.  Playgrounds to be cherry-picked from (aka 'pu') would
make *perfect* sense to be managed that way (and the topics that
go only 'pu' of git.git itself are managed the same except that
I do not do so using StGIT), but I think we need a stable
history for the branch git.git will eventually pull from.
