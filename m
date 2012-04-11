From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #04; Tue, 10)
Date: Wed, 11 Apr 2012 09:46:45 -0700
Message-ID: <7vhawqmd1m.fsf@alter.siamese.dyndns.org>
References: <7vty0rnrwy.fsf@alter.siamese.dyndns.org>
 <m3ty0q9sco.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:47:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0hF-00026C-4G
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760744Ab2DKQqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:46:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760685Ab2DKQqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:46:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B11BB6437;
	Wed, 11 Apr 2012 12:46:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VbZqSbX0mCbnviqF+VBw2idir6c=; b=OuvrdF
	OCPI+LR7j6N5akZMLHpIvgya7afoyRAgLEUHnYQ1oGUvl9I44EldIJkUzpu1pINQ
	nVJ2tuPAy3+MpTbane4do2gQtwghccGSZLN6s1nycvvM5QoLYj1ZwD6oBtV5cvME
	D13izKGeZxqhRWEPNv2IgUy0yqG4SsrMo9qwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSyFZ/jR5m6a5vNWpGSY0nPOQm1rUBUk
	PqglTeRDclnV9eD8xg9OG5n8jecRTayXWE9X2j/GWBagkfZg4WzY4g0HB8SAlXJj
	D+huAd9bG5CsTrHNrsjtZBiInJqwQb+7a5xswhADISZa0DQ3ofqHuGSrmEJCZ1GG
	nqcsvoji92g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8F116436;
	Wed, 11 Apr 2012 12:46:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41EBE6435; Wed, 11 Apr 2012
 12:46:47 -0400 (EDT)
In-Reply-To: <m3ty0q9sco.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed, 11 Apr 2012 08:54:32 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED825A6A-83F5-11E1-B348-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195212>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Will discard shortly unless nothing happens.
>
> Double negation?  "Unless nothing"?
>  
>> * mk/gitweb-diff-hl (2012-04-05) 8 commits
>> * wk/gitweb-snapshot-use-if-modified-since (2012-03-30) 3 commits
>
> What about "[PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for
> regular Atom feed" from Sebastian Pipping?
>
>   http://thread.gmane.org/gmane.comp.version-control.git/194535/focus=194695

Please stop saying "What about" on Gitweb topics.  I am not keeping track
and mostly trusting your judgement; resending with Ack is sufficient.

Thanks.
