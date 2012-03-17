From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] difftool: teach command to perform directory diffs
Date: Fri, 16 Mar 2012 21:24:47 -0700
Message-ID: <7vehsretww.fsf@alter.siamese.dyndns.org>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <7vlin0dlrm.fsf@alter.siamese.dyndns.org>
 <CAFouetgqsLv9HUYiUXe8aw+NQ-i=k+OGosPRNKSrqePf5wUnQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 05:25:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8lCu-00030I-QC
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 05:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab2CQEYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 00:24:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab2CQEYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 00:24:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 561B86C03;
	Sat, 17 Mar 2012 00:24:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UXrElVmjNHmE670cKbHF6gTv/HQ=; b=txMAHK
	+lqAjWPfR49pQQ3KQ0HOE5i2PAhvWmjpRNcfLHhcjUupEYheaMjE9E/6kq45Iwwj
	0WMLfUzlJmERL8e31eDMrAvQEQ4GUN51ZY60EWETN10gTWjjwyqWUb1bg2vO1Tcs
	l7igRgVavsub8dHN8bqWMnaVNfgjedRMjHsdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ssJs8EK+h7P8ns5jWRgl2a+lWBSMX1gC
	+NfvfJfZkwRf2X5To0jkUZO1LJcXQnY0qM8yr74gMCLdYu/UjrfgD/03RpnUP0J+
	/7BldHqYJu1sfkqzXwHiIe7H2A4VLuJ6o0H0uB8Tpl4VfIyCo8K/V7RCB2w1KGo2
	mWMLPgG1Seo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DC296C02;
	Sat, 17 Mar 2012 00:24:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D42B86C01; Sat, 17 Mar 2012
 00:24:48 -0400 (EDT)
In-Reply-To: <CAFouetgqsLv9HUYiUXe8aw+NQ-i=k+OGosPRNKSrqePf5wUnQA@mail.gmail.com> (Tim
 Henigan's message of "Fri, 16 Mar 2012 22:26:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2225E5B4-6FE9-11E1-ACD3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193306>

Tim Henigan <tim.henigan@gmail.com> writes:

> I began fixing those issues in 'git-diffall' by rewriting the loop
> that populates the tmp dirs in Perl.  By the time I changed the loop
> to use 'git diff --raw -z' and handle working copy changes and
> submodules, it seemed I was very near to finishing the things I wanted
> to accomplish in "phase 2".  Finishing the work by updating 'difftool'
> seemed to actually be easier than trying to update 'diffall'.

;-)  Good.
