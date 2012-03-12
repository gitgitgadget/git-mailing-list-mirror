From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 14:34:19 -0700
Message-ID: <7vipi9pkpw.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
 <7vobs1r3kn.fsf@alter.siamese.dyndns.org> <4F5E5A77.1070605@lyx.org>
 <7vd38hr22e.fsf@alter.siamese.dyndns.org> <4F5E68C5.5070300@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 22:34:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Ct0-0004UA-91
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 22:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395Ab2CLVe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 17:34:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757366Ab2CLVeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 17:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAB5D7BF1;
	Mon, 12 Mar 2012 17:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lyy+VDuw3P8B5BKm3JdMS4UCdIA=; b=oTrnVG
	NQRwNJRcoEmCuL5cjZxKdUfzY1gQP8T7OB5pbs598Q0FOfL+gojF//HCVCXKJQTj
	/zuHyHtIbaFTnK/kF9HlAC7OOaLCTAhH3P+jS7xRtKdA5zzv5d3U2At2NhS99IAg
	twYR22HANw7NMzCfhPNxbqnvHFhcXFrjE0Yl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IMhNwVdijoK5ELZg5kShfHfIHIXFuW81
	/HH1qHRDawFiR6amJ8b+vi3HNTBkhpJeTVukmw83gdDy4nQrzbLIOLj+JPhKadGL
	ysh40MO5q3ZT4F83/O6iU0pdLy3IV8MHDkN3PO3h8b5KLZhX+2BzoJx1VP+pdYjt
	KToqaWKuDn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE9967BF0;
	Mon, 12 Mar 2012 17:34:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E6E77BED; Mon, 12 Mar 2012
 17:34:21 -0400 (EDT)
In-Reply-To: <4F5E68C5.5070300@lyx.org> (Vincent van Ravesteijn's message of
 "Mon, 12 Mar 2012 22:21:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 214B56B2-6C8B-11E1-8405-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192950>

Vincent van Ravesteijn <vfr@lyx.org> writes:

>> The problem I have with "rerere edit" is it is an offline process,
>> and to validate that the update is correct, I would have to have the
>> problematic merge in my working tree once _anyway_.  And at that
>> point, updating the target file in the working tree and recording
>> the updated resolution using the usual "git rerere" feels a more
>> natural way to do so, and more importantly, it is a more convenient
>> way to do the "update and validate".  On the other hand, "rerere
>> edit" is a more convenient way to "update but not validate the
>> result".
>
> This last part probably makes the difference indeed. In my case the
> merge resolution was very very easy (the conflicting hunks have
> fileformat version numbers), but it is a bit annoying and it requires
> some 'vim'-skills to redo the merge conflict just to correct a newline
> somewhere, or a missing ','.

Now you confused me.  How do you envision your "rerere edit" not to
require "vim-skills" that is needed to navigate to the problematic
line to correct a newline or comma?  To put it another way, how much
more "vim-skills" is needed to fix the conflict in the real file,
than "rerere edit"?
