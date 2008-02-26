From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve collection of information for format-patch
 --cover-letter
Date: Tue, 26 Feb 2008 10:46:49 -0800
Message-ID: <7vzltn4kti.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251822240.19024@iabervon.org>
 <7v1w70h96u.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261123170.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:48:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU4q7-0000xo-TC
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 19:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111AbYBZSrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 13:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYBZSrA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 13:47:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbYBZSrA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 13:47:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EE551A7A;
	Tue, 26 Feb 2008 13:46:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5A41B1A79; Tue, 26 Feb 2008 13:46:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75159>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 25 Feb 2008, Junio C Hamano wrote:
>
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>> > ... Note that the single boundary test is empirical, not 
>> > theoretical; even a -2 limiting condition will give a diffstat if there's 
>> > only one boundary commit in this particular case.
>> 
>> It is unclear what "a -2 limiting condition" means here...
>
> Like "git format-patch -2". What is that actually called?

"max count"?  So you wanted to say that the new code sometimes
figures out (with --boundary) what to compare against even when
the user does not explicitly specify where the range begins from
the command line.  Thanks for a clarification.
