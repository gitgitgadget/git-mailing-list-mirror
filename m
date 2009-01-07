From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] diff --no-index: test for pager after option parsing
Date: Tue, 06 Jan 2009 23:02:15 -0800
Message-ID: <7veizfbnuw.fsf@gitster.siamese.dyndns.org>
References: <1231286163-9422-1-git-send-email-trast@student.ethz.ch>
 <7vfxjwf041.fsf@gitster.siamese.dyndns.org>
 <20090107032013.GO21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 08:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKSSG-0008OK-5B
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 08:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbZAGHCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 02:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZAGHCc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 02:02:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZAGHCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 02:02:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 51BDA1BE4B;
	Wed,  7 Jan 2009 02:02:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 932B51BE28; Wed, 
 7 Jan 2009 02:02:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2361C0B6-DC89-11DD-A1BF-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104766>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Jan 06, 2009 at 04:09:18PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> But I wonder if it still makes a difference in real life.idn't we stop
>> reporting the exit status from the pager some time ago?
>
> I just wanted to write this, I think that code could be just removed
> since ea27a18 (spawn pager via run_command interface, 2008-07-22).

I think we shouldn't.

People may already have got used to "git diff --exit-code" to disable the
pager, and doing the same for "git diff --exit-code --no-index" should be
with less surprises.

I'll queue the "--" fix, "-q" fix and this pager fix.  Thanks.
