From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 11:58:30 -0800
Message-ID: <7vfxvn4cyh.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org>
 <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
 <76718490802201149w5a7c0b88udef968f4083190ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRv6R-0006Xk-0z
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762660AbYBTT6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762642AbYBTT6r
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:58:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626AbYBTT6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:58:46 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DBAF4569E;
	Wed, 20 Feb 2008 14:58:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 E575F5699; Wed, 20 Feb 2008 14:58:32 -0500 (EST)
In-Reply-To: <76718490802201149w5a7c0b88udef968f4083190ea@mail.gmail.com>
 (Jay Soffian's message of "Wed, 20 Feb 2008 14:49:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74543>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Feb 20, 2008 2:24 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> This order of values is definitely the right thing, for the mapping
>> reasons you saw. And I think "aka" is generally used to indicate
>> additional non-canonical names for something with an official name (see,
>> for example, IMDB's usage). I haven't been able to come up with anything
>> better to indicate "this is a name that I will recognize but not use
>> myself".
>
> I think the word you want is "alias", isn't it? I've never really seen
> aka used in a technical sense, whereas alias is used quite often (URL
> aliases, DNS aliases, etc). So:
>
> url.$canonical_name.alias = $local_name.

Read the first line you quoted, and think again.
