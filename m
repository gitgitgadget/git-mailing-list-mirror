From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is the status of merging with whitespace conflicts?
Date: Wed, 02 Dec 2009 09:04:58 -0800
Message-ID: <7vy6lli9xh.fsf@alter.siamese.dyndns.org>
References: <46a038f90912020234g3094cccbxd8ca80c7c0b32ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsdu-0005BQ-Sm
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbZLBRFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbZLBRFR
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:05:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbZLBRFP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:05:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D69A84CDC;
	Wed,  2 Dec 2009 12:05:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bPIx3UdXo0Hh9NMWHWWQCLgWwqs=; b=EBK+tp
	Ull+CfFGuD0hxXfxyNW9luHIw3RL3Ho2by5wHfkR5J/BALVIiEWjjsVr2Wwdf9BS
	UrTDsaU6j/gSJkJbco+oi6fs8mbSJ45ovU7SVpjHPjSqVs0NDsy01sIbhAW9ZBUe
	5b1y3B2NbHpLKSpbeDaBs79v6vIhhHHzTyc/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsMZ0pYxvt7I8uwrn6KY+9GdLQXRh8rG
	1/yfNwpYxeveVproyZlA+Lx8fqyBEGUmMotjICfmjeOkud//ugZhjrDjx0UBtz6W
	/dTfpErHLNjYmzm+0z4imhmPXPbOB+9a90To+7dhi9Rabm7M9tPG4eOaX3FJif5L
	1mUncuj2VHc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6841E84CD5;
	Wed,  2 Dec 2009 12:05:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4929484CCE; Wed,  2 Dec
 2009 12:05:00 -0500 (EST)
In-Reply-To: <46a038f90912020234g3094cccbxd8ca80c7c0b32ca4@mail.gmail.com>
 (Martin Langhoff's message of "Wed\, 2 Dec 2009 11\:34\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D8210D16-DF64-11DE-857A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134351>

I am not working on it, and I didn't hear from anybody who is.  If you
limit the whitespace-only changes to the ones that do not cross line
boundary, it wouldn't be too hard to add.  Probably it would take less
than one summer for a good student.
