From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merging .gitignore
Date: Wed, 03 Oct 2007 12:38:56 -0700
Message-ID: <7vejgcdm3z.fsf@gitster.siamese.dyndns.org>
References: <20071001130314.GA5932@lapse.madduck.net>
	<200710031128.56472.johan@herland.net>
	<Pine.LNX.4.64.0710031314530.28395@racer.site>
	<200710031506.23938.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>,
	martin f krafft <madduck@madduck.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdA3w-0008IJ-0R
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbXJCTjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752324AbXJCTjG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:39:06 -0400
Received: from rune.pobox.com ([208.210.124.79]:52136 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbXJCTjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:39:05 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id E0BA1141203;
	Wed,  3 Oct 2007 15:39:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1464B140EC1;
	Wed,  3 Oct 2007 15:39:19 -0400 (EDT)
In-Reply-To: <200710031506.23938.johan@herland.net> (Johan Herland's message
	of "Wed, 3 Oct 2007 15:06:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59871>

Johan Herland <johan@herland.net> writes:

> On Wednesday 03 October 2007, Johannes Schindelin wrote:
>> On Wed, 3 Oct 2007, Johan Herland wrote:
>> > - Teach the .gitignore parser to ignore conflict markers (i.e. regard them 
>> > as comments)
>> 
>> You might be delighted to know that in practice, it works already (because 
>> you usually do not have a file named "<<<<<< blablub" or "======" or 
>> ">>>>>> blablub"...
>
> I suspected so... ;)

Yeah, and that is one of the reasons why we made gitignore and
gitattributes one-entry-per-line format.
