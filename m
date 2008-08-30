From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git gui: use apply --unidiff-zero when staging hunks
 without context
Date: Sat, 30 Aug 2008 13:52:23 -0700
Message-ID: <7vprnqfcoo.fsf@gitster.siamese.dyndns.org>
References: <20080830164527.GA25370@localhost>
 <20080830165600.GB25370@localhost> <48B9A2D7.8090801@telecom.at>
 <20080830202706.GA13573@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:53:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXS6-0002vI-6I
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbYH3Uwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbYH3Uwc
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:52:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYH3Uwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:52:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 261386D8C0;
	Sat, 30 Aug 2008 16:52:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8E7B46D8BF; Sat, 30 Aug 2008 16:52:25 -0400 (EDT)
In-Reply-To: <20080830202706.GA13573@localhost> (Clemens Buchacher's message
 of "Sat, 30 Aug 2008 22:27:06 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 904397DC-76D5-11DD-B262-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94423>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sat, Aug 30, 2008 at 09:43:19PM +0200, Johannes Sixt wrote:
>> Clemens Buchacher schrieb:
>>> git apply does not work correctly with zero-context patches. It does a
>>> little better with --unidiff-zero.
>>
>> No, NO, NOOOOO! This kills your data!
>
> Okay. Since we have 'Stage Line for Commit', supporting this would be almost
> pointless anyways. So let's forget about trying to fix this and simply
> disable zero-context diff in git-gui, as per my original patch
>
> [PATCH] git gui: show diffs with a minimum of 1 context line

Well, showing is Ok as long as you do not try pick and apply.  Or did I
miss something?
