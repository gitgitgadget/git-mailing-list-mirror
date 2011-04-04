From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2011, #01; Sun, 3)
Date: Mon, 04 Apr 2011 08:11:14 -0700
Message-ID: <7vhbae9hm5.fsf@alter.siamese.dyndns.org>
References: <7v62quc464.fsf@alter.siamese.dyndns.org>
 <m3aag64bt5.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 17:11:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6lRC-0003BC-Vm
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 17:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1DDPLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 11:11:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab1DDPLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 11:11:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 143314D31;
	Mon,  4 Apr 2011 11:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DX6N1AeVhafI3/+aJjEVn9eq9+w=; b=IQGGL/
	JF829CvHQE0zCFIOLM7CJdSxIWFvHlDBqA12pS/LppEzGp7WbvMBT+nm1o08fQ4h
	3APP+1seE7L6T4F15MN2r1sdmP+EQbOet93lqZu76hd8/f7y7vufncoHsq/VY/Uk
	LL9gcD2wUf6quPz2LrvDOsokppLQhF7Yw8qcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X7lyGc5T1RDrso+Gvs1w0maw0c6wV3EE
	cawGImvA7k05nESoAy7bLyz7FV/9YhZBR7fD9Au+AemwXhN4hyB6iku3zl4GswGK
	eYwbb2m4k4NWnlymttAdRDoTq75QfCiFWg26FuH5in/diBZQQCh4C2CCrZFQmkWW
	1+yaLvloE48=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E50F04D2E;
	Mon,  4 Apr 2011 11:13:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0E7D74D2A; Mon,  4 Apr 2011
 11:13:08 -0400 (EDT)
In-Reply-To: <m3aag64bt5.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 04 Apr 2011 02:16:26 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E5E67C2-5ECE-11E0-BC3F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170817>

Jakub Narebski <jnareb@gmail.com> writes:

> BTW I guess that 
>
>   [PATCH (BUGFIX)] gitweb: Fix parsing of negative fractional timezones in JavaScript
>   Message-Id: <20110401190239.9686.12000.stgit@localhost.localdomain>
>   http://article.gmane.org/gmane.comp.version-control.git/170606
>
> didn't made it into this "What's cooking..." because it was send too
> late (2011-04-01 19:06:28 GMT), isn't it?

No, I didn't take it primarily because it came soon after a very similar
looking gotcha 2b1e172 (gitweb: Fix handling of fractional timezones in
parse_date, 2011-03-25) and was confused.
