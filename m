From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid html output repo.or.cz (alt-git.git)
Date: Sat, 16 Feb 2008 12:07:36 -0800
Message-ID: <7vve4o7jhz.fsf@gitster.siamese.dyndns.org>
References: <20080216130037.GA14571@auto.tuwien.ac.at>
 <m3lk5kbry3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mkoegler@auto.tuwien.ac.at (Martin Koegler),
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 21:08:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQTKs-0006JD-Hp
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 21:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbYBPUH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 15:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754866AbYBPUH7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 15:07:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbYBPUH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 15:07:57 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 49A2262C8;
	Sat, 16 Feb 2008 15:07:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 868E662C3; Sat, 16 Feb 2008 15:07:43 -0500 (EST)
In-Reply-To: <m3lk5kbry3.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 16 Feb 2008 11:52:42 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74073>

Jakub Narebski <jnareb@gmail.com> writes:

> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>
>> http://repo.or.cz/w/alt-git.git?a=shortlog
>> 
>> fails to load in my Seamonkey browser (Debian stable):
>> 
>> XML Parsing Error: not well-formed
>> Location: http://repo.or.cz/w/alt-git.git?a=shortlog
>> Line Number 561, Column 33:<td><i><span title="Uwe Kleine-K<span class="cntrl">\e</span>,Av<span class="cntrl">\e</span>(Bnig">Uwe Kleine ...</span></i></td>
>> --------------------------------^
>
> It looks like gitweb uses esc_html instead of esc_param (or leaving it
> to CGI module) title attribute of span (?) element in a shortlog.
>
> I'd try to fix this bug.

Thanks.
