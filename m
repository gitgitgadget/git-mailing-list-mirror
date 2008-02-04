From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] fsck_commit: remove duplicate tests
Date: Sun, 03 Feb 2008 23:33:06 -0800
Message-ID: <7vodaxkwgd.fsf@gitster.siamese.dyndns.org>
References: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at>
	<12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at>
	<7v3as9r3r2.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802040003360.7372@racer.site>
	<20080204070600.GA30099@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Feb 04 08:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvpu-0000MY-08
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbYBDHdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755505AbYBDHdR
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:33:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255AbYBDHdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:33:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B221D1891;
	Mon,  4 Feb 2008 02:33:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1CDB1890;
	Mon,  4 Feb 2008 02:33:08 -0500 (EST)
In-Reply-To: <20080204070600.GA30099@auto.tuwien.ac.at> (Martin Koegler's
	message of "Mon, 4 Feb 2008 08:06:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72471>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Mon, Feb 04, 2008 at 12:04:31AM +0000, Johannes Schindelin wrote:
>> On Sun, 3 Feb 2008, Junio C Hamano wrote:
>> > Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
>> > 
>> > > All tests on the commit buffer in fsck_cmd are ready done by 
>> > > parse_commit_buffer.
>> > >
>> > > This patch rips out all redundant tests.
>> > 
>> > As I believe in belt-and-suspenders when it comes to validation, I am 
>> > somewhat uneasy with this change.
>> 
>> Besides, should we really change fsck?  It's not _that_ much of a 
>> performance-critical operation.  Accuracy is much more important.
>> 
>> fsck is the reason I trust git with my data.
>
> Then please drop this patch. I hope the other two patches are OK.

Yeah, thanks for the other two, which I've queued already.
