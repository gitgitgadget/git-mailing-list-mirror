From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: improve performance with large files
Date: Fri, 06 Mar 2009 01:42:09 -0800
Message-ID: <7vfxhrt2by.fsf@gitster.siamese.dyndns.org>
References: <20090304215438.GA12653@zoy.org>
 <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
 <20090305172332.GF25693@zoy.org> <7vzlfzwiyn.fsf@gitster.siamese.dyndns.org>
 <1d48f7010903051725v510f99f0h2a05b9381ff75ac1@mail.gmail.com>
 <20090306085357.GA12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfWao-00023M-Se
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 10:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbZCFJmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 04:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZCFJmS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 04:42:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbZCFJmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 04:42:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B1369FEAD;
	Fri,  6 Mar 2009 04:42:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A9D7E9FEAC; Fri,
  6 Mar 2009 04:42:12 -0500 (EST)
In-Reply-To: <20090306085357.GA12880@zoy.org> (Sam Hocevar's message of "Fri,
 6 Mar 2009 09:53:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12F6BF4C-0A33-11DE-B5FD-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112410>

Sam Hocevar <sam@zoy.org> writes:

> On Thu, Mar 05, 2009, Han-Wen Nienhuys wrote:
>
>> i'd say
>> 
>>   data = []
>> 
>> add a comment that you're trying to save memory. There is no reason to
>> remove data from the namespace.
>
>    Okay. Here is an improved version.
>
> Signed-off-by: Sam Hocevar <sam@zoy.org>

Sorry, but that's not a commit log message, so signing it off does not add
much value to the patch.
