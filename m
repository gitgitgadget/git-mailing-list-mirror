From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t91XX-svn: start removing use of "git-" from these
 tests
Date: Tue, 09 Sep 2008 01:40:23 -0700
Message-ID: <7vfxo9af0o.fsf@gitster.siamese.dyndns.org>
References: <20080908190205.6117@nanako3.lavabit.com>
 <20080908101631.GA6948@toroid.org> <20080908102759.GC13085@hand.yhbt.net>
 <20080909022343.GB19190@toroid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Abhijit Menon-Sen <ams@toroid.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcyn7-0000Va-GW
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbYIIIkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbYIIIkc
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:40:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbYIIIkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:40:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 109D57A8CD;
	Tue,  9 Sep 2008 04:40:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D22A67A8CC; Tue,  9 Sep 2008 04:40:25 -0400 (EDT)
In-Reply-To: <20080909022343.GB19190@toroid.org> (Abhijit Menon-Sen's message
 of "Tue, 9 Sep 2008 07:53:43 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F5F78CA6-7E4A-11DD-8878-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95358>

Abhijit Menon-Sen <ams@toroid.org> writes:

> At 2008-09-08 03:27:59 -0700, normalperson@yhbt.net wrote:
>>
>> They'll show up as false positives when grepping for "git-"
>
> Fine, you're the maintainer, but for the record, I think this change is
> dreadful. Changing all "git-svn blah" commands to "git svn blah" is one
> thing, but obfuscating tests on the off-chance that someone might grep
> for "git-" seems entirely wrong.

I think the value of this first one is not "on the off-chance" thing, but
the presense of this change makes it far easier to eyeball the result of
applying the second, large-ish patch.

If I were doing this as a series, I would probably have followed them up
with a patch that reverts the token replacement this first one does as the
final patch in the series, but I also think leaving this first patch as-is
is fine.
