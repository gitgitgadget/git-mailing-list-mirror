From: Junio C Hamano <gitster@pobox.com>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 11:50:38 -0800
Message-ID: <7vocxsy1dd.fsf@gitster.siamese.dyndns.org>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
 <20090127153837.GB1321@spearce.org>
 <7vwscgy56b.fsf@gitster.siamese.dyndns.org>
 <m37i4gy2z6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 20:52:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRtys-0006WI-A9
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 20:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755619AbZA0Tus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 14:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755530AbZA0Tus
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 14:50:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbZA0Tur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 14:50:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 659D01CE9B;
	Tue, 27 Jan 2009 14:50:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7DA601CA0A; Tue,
 27 Jan 2009 14:50:40 -0500 (EST)
In-Reply-To: <m37i4gy2z6.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 27 Jan 2009 11:17:17 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA077BF4-ECAB-11DD-9295-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107386>

Jakub Narebski <jnareb@gmail.com> writes:

> It is a bit of pity that "git add" was overloaded to also add new
> contents and not only add new file (and its contents!), instead of
> having new command "git stage" to be porcelain version of 
> "git update-index" porcelain.  And perhaps "git resolved" to only
> mark resolved entries (so e.g. "git resolved ." would not add new
> files, nor add new contents of files which were not in conflict).

I do not think so.

People who are taught with various means (including "git stage" alias)
understand that you prepare the contents you want to record in the commit
you are about to make by updating the contents registered in the index aka
staging area, then you do not need "git resolved".

You resolve, you have the desired content in your work tree, and you
register the updated contents from your work tree to the index aka staging
area, in exactly the same way as you do when you want to include updated
contents for any commit.
