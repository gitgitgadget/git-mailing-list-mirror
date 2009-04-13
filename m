From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Add config option for sender address
Date: Mon, 13 Apr 2009 00:45:34 -0700
Message-ID: <7v1vrxhu8x.fsf@gitster.siamese.dyndns.org>
References: <1235005238-15500-1-git-send-email-xyzzy@speakeasy.org>
 <20090410093432.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Trent Piepho <xyzzy@speakeasy.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 09:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtGst-0005TO-GP
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 09:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbZDMHpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 03:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZDMHpm
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 03:45:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZDMHpm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 03:45:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 99D32AA3DE;
	Mon, 13 Apr 2009 03:45:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 38CB7AA3DD; Mon,
 13 Apr 2009 03:45:35 -0400 (EDT)
In-Reply-To: <20090410093432.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 10 Apr 2009 09:34:32 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15F2B180-27FF-11DE-B562-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116417>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Trent Piepho:
>
>> The sender address, as specified with the '--from' command line option,
>> couldn't be set in the config file.  So add a new config option,
>> 'sendemail.from', which sets it.  One can use 'sendemail.<identity>.from'
>> as well of course, which is likely the more useful case.
>> 
>> The sender address would default to GIT_AUTHOR_IDENT, which is usually the
>> right thing, but this doesn't allow switching based on the identity
>> selected.  It's possible to switch the SMTP server and envelope sender by
>> using the '--identity' option, in which case one probably wants to use a
>> different from address as well, but this had to be manually specified.
>> 
>> The docs are also fixed up somewhat.  If '--from' is specified (or the new
>> sendemail.from option is used) then the user isn't prompted.  The default
>> with no '--from' option (or sendemail.from option) is GIT_AUTHOR_IDENT
>> first then GIT_COMMITTER_IDENT, not just GIT_COMMITTER_IDENT.
>> 
>> Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
>
> Junio, may I ask what happened to this patch?

If I recall correctly, it didn't look too invasive and I found it Ok, but
I didn't see any comments on it, so it was dropped on the floor.

Perhaps Trent cares to resend?
