From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The ciabot hook code in contrib/ is obsolete - delete it
Date: Tue, 02 Oct 2012 15:58:23 -0700
Message-ID: <7vr4pg5vn4.fsf@alter.siamese.dyndns.org>
References: <20120928024045.E0D6F42F19@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com (Eric S. Raymond)
X-From: git-owner@vger.kernel.org Wed Oct 03 00:59:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJBQC-0007oU-7K
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab2JBW61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 18:58:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab2JBW60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 18:58:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ADA983B9;
	Tue,  2 Oct 2012 18:58:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NVWpTz3jOvtaGCxLZN902cVCsYw=; b=WcetJk
	H7ukCM2mTHj3D7duS5XcCEXz04u0N0wqx7zK0ES4WHGkk18XeWOLfYZZNgOlKsfI
	z71OGPYwQZ/0X1mnA5FnStAlvhW1HLBeCHFDgvTAhTuO0yMsrROw7q8h5K7Vc8ci
	LrRdceYTAf6JphWyheBbb4WZ8JpaxMSNAyce0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=be9pLkVFdS9Qsov8vsbY4kAjUeF9qwWw
	1eYgdfGydJ8Px+vUQ7RYXPROA7savj7iLXYwXMdte0cJHgi4rF/SdpZwPB/jgsSc
	stU7tMmburGy0LOWufYhe/gJ7SjoTeO+YEfUw1+7SsWFYuduGb3XtvcG2EYxH9aM
	vZ8QOgwXf5s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6856483B8;
	Tue,  2 Oct 2012 18:58:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD8F483B7; Tue,  2 Oct 2012
 18:58:24 -0400 (EDT)
In-Reply-To: <20120928024045.E0D6F42F19@snark.thyrsus.com> (Eric S. Raymond's
 message of "Thu, 27 Sep 2012 22:40:45 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABC60496-0CE4-11E2-8667-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206850>

esr@thyrsus.com (Eric S. Raymond) writes:

> The CIA notification server died about two days ago, done in by
> a screwup at the cloud service hosting is VM.  For various technical
> reasons there cannot and will not be any effort to revive it.  If you want
> the whole sordid tale, read "CIA and the perils of overengineering" at
> <http://esr.ibiblio.org/?p=4540>.
>
> Accordingly, the contrib/ciabot code is now obsolete and should be removed.
>
> I have written a replacement service. irker, with a different (and
> fundamentally simpler) design. Though I released irker just today, it
> already has multiple deployments.  A lot of hackers like their IRC
> commit notifications and have instantly seized on this option to get
> such a service running again - this time as a distributed flock of
> lightweight notifier proxy daemons that cannot be taken out by any
> single-point failure. 
>
> Interested persons may wish to monitor the freenode #cia channel,
> which is morphing into a discussion about coordinating irker
> deployment and building various proxy/symbiote/statistics-gathering 
> services around it.
>
> I'm shipping a generic repo-hook script that supports both git and
> Subversion in the irker distribution, so there won't be any need
> for git to carry a special hook.  I remain grateful for your previous 
> cooperation in supporting and distributing the ciabot code. 

Seeing the above without a signed-off patch and then this on cia.vc

    We intend to have the CIA.VC Site running soon then bring the
    service back at a later date!  We currently do not have an ETA for
    the Service but hope to have it functioning soon!

I am not sure what the right course of action at this moment.
