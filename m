From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] difftool: teach command to perform directory diffs
Date: Fri, 16 Mar 2012 19:06:05 -0700
Message-ID: <7vlin0dlrm.fsf@alter.siamese.dyndns.org>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 03:06:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8j2Z-0003cq-6g
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 03:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab2CQCGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 22:06:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2CQCGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 22:06:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 468A1703E;
	Fri, 16 Mar 2012 22:06:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/m/TBpHkfuLRSc3JNalte3LRWOg=; b=FnzAX7
	rjuPJL+NL1LdsctlrVFoDcGNIhdOohTzgnPPhBrQ6Ml/4d9ERi/DdxSQ5qzVi06C
	MCHFNKphG/fNDu2nY698xVE7Ros4aMp5/bQqFLFQ5WCVhPfCL58acosq4299cEjr
	ONCffFhjYGNvXv87Qaq/6AMcwQiQn1sXBAqu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UrGICJA3Zx+AZvaNEPescUut0Y5JoVBa
	/R09om+DlQGZjj5XO60NawjDDxuERl/I/AGBAr+Qv3193kQi2zioFrdkRjfm//nt
	VuvCAG7FXQmWX0BHaxmx2AcDke6xO8UfxhHH3CqCpoI3Y/V6ufbWLOYFFMKHyVpO
	GwnEO4+XGaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37396703C;
	Fri, 16 Mar 2012 22:06:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD95B703B; Fri, 16 Mar 2012
 22:06:06 -0400 (EDT)
In-Reply-To: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 16 Mar 2012 21:57:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1CB5202-6FD5-11E1-9D86-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193299>

Tim Henigan <tim.henigan@gmail.com> writes:

> 'git difftool' is a very useful command that allows git diffs to be opened
> in an external tool. Currently, difftool opens a separate instance of the
> external tool for each file that changed. This can be tedious when many
> files have changed.
>
> This series teaches difftool to perform directory diffs, so that all file
> changes can be opened/reviewed in a single instance of the external tool.
>
> This is the second phase of development for this feature. The first phase
> was added as a separate command (git diffall) in 1252bbe (contrib: add
> git-diffall script).

Ummm.  I do not think the first step is not even done yet; fixing the
whitespace-in-pathspec and whitespace-or-lf-in-paths issues now the script
is in contrib/, while having people play with it.
