From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 22:31:00 -0700
Message-ID: <7vwsk74hgr.fsf@gitster.siamese.dyndns.org>
References: <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <20080630033034.GB18930@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 07:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDBzh-0007gN-HA
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 07:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYF3FbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 01:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYF3FbH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 01:31:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbYF3FbG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 01:31:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2151D9E48;
	Mon, 30 Jun 2008 01:31:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 553979E47; Mon, 30 Jun 2008 01:31:02 -0400 (EDT)
In-Reply-To: <20080630033034.GB18930@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 29 Jun 2008 23:30:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BC078874-4665-11DD-902F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86874>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 29, 2008 at 01:55:13AM -0700, Junio C Hamano wrote:
>
>> * jk/maint-fetch-ref-hier (Thu Jun 26 23:59:50 2008 -0400) 1 commit
>>  + fetch: report local storage errors in status table
>> 
>> When the remote used to have "foo" branch but now has "foo/bar", fetch
>> refuses to delete the existing remote tracking branch "foo" to create a
>> new remote tracking branch "foo/bar", but the error message was
>> confusing.
>
> Where do we want to take this? The conversation went something like:
>
>    me: here's a patch where we hint about "remote prune"
>   you: why not just fix the refs, it's no worse than a rewind
>    me: we kill reflogs, so it is different than a rewind
>   you: oh, right
>
> So I'm not sure if that was "Oh, right, it's not a good idea to remove
> the conflicting ref" or "Oh, right, but it's probably still fine."

It is "Oh right, it is Ok.  Let's cook it in 'next', have it in 'master'
and then backmerge to 'maint'".
