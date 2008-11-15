From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sat, 15 Nov 2008 04:14:04 -0800
Message-ID: <7vprkx5gqb.fsf@gitster.siamese.dyndns.org>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1226616555-24503-6-git-send-email-giuseppe.bilotta@gmail.com>
 <200811150059.14515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 13:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1K3r-0008Ag-RQ
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 13:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbYKOMOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 07:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbYKOMOU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 07:14:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbYKOMOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 07:14:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BC25F16BD2;
	Sat, 15 Nov 2008 07:14:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7688916BDE; Sat, 15 Nov 2008 07:14:07 -0500 (EST)
In-Reply-To: <200811150059.14515.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat, 15 Nov 2008 00:59:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED90B166-B30E-11DD-A1C4-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101063>

Jakub Narebski <jnareb@gmail.com> writes:

> Second, this patch wouldn't do what you want from it if there are
> remotes with '/' in name.  I for example use "gsoc2008/gitweb-caching"
> for Lea Wiemann repository with her GSoC 2008 work on adding caching
> to gitweb.

I think your point is if you also use gsoc2008/gitstats from another
remote repository, these two sets of remote tracking branches will be
shown grouped together.  But is it a bad thing?  After all, you chose to
use hierarchical names for them, _and_ you chose to use the same toplevel
hierarchy name for them.  Doesn't that mean you _wanted_ to have them both
appear in the same GSoC 2008 group?
