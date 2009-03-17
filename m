From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #04; Sat, 14)
Date: Mon, 16 Mar 2009 17:19:25 -0700
Message-ID: <7v4oxtuhki.fsf@gitster.siamese.dyndns.org>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0903161834530.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 01:21:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjN3L-0006sW-9a
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 01:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463AbZCQATe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 20:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755180AbZCQATe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 20:19:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZCQATe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 20:19:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B8CA6E75;
	Mon, 16 Mar 2009 20:19:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7BF146E74; Mon,
 16 Mar 2009 20:19:27 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903161834530.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 16 Mar 2009 19:11:03 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4986083E-1289-11DE-A0F3-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113407>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 14 Mar 2009, Junio C Hamano wrote:
>
>> * db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
>>  - Support fetching from foreign VCSes
>>  - Add specification of git-vcs helpers
>>  - Add "vcs" config option in remotes
>> 
>> The "spec" did not seem quite well cooked yet, but in the longer term I
>> think something like this to allow interoperating with other SCMs as if
>> the other end is a native git repository is a very worthy goal.
>
> I recently figured out a way to alter the transport API slightly to make 
> it possible to attach foreign VCSes there. This amounts to allowing 
> get_refs_list() to leave the sha1s null, and allowing fetch() to set them. 
> This just requires a copy of a ref list in the clone path, and a check to 
> make null (for not having a ref) not match null (for not knowing the hash 
> of the ref) in the fetch logic.
>
> I think I will end up changing the spec, mostly to allow a single 
> non-trivial call to the helper to provide both the list of refs and the 
> fast-import stream; this matches how the pack protocol works (except, of 
> course, that the initial list doesn't have hashes, and the output goes to 
> fast-import instead of unpack-objects). I'm going to rebase the series at 
> some point, but I've been focused more on the more core transport and 
> remote stuff now that I think I can go through that.

Thanks for a wonderful news.
