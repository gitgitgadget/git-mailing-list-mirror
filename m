From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git log --graph -p -m" (version 1.7.7.6)
Date: Tue, 05 Feb 2013 09:40:37 -0800
Message-ID: <7vtxpqslpm.fsf@alter.siamese.dyndns.org>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Tue Feb 05 18:41:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2mVz-0007bI-Al
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 18:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab3BERkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 12:40:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab3BERkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 12:40:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C02CD8E;
	Tue,  5 Feb 2013 12:40:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NE544DQl83hzvGdLAP4v1/aClM4=; b=hj31Y4
	v95QsSGjnhqWIYEZfnpjKdgR4k78CjjTR3g8dXWlUTwC27big1TE7C80k67bC3OY
	s7lsTyLGoujAYBZmQ1mLSDtIXijR879kL4O2/M0qfNZjrzdsbam8LcfhvCGkM3qn
	SvYYoKUIPzfEdClbjlAPnsz3s4ZmDswyP2U2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tzO9pCqKgyS4KS4xqkFTnwne4p/8dxkj
	Ghq0xLTkW+IhjPvkQDcmV8IOn2Whav3XqM1pm81ysBhfBh+v/nC3LPYkVzD77U2x
	Q8gOwfDaiSIBsfDg8SGUE01KrofJ4eMnZvrO8O3rYqBQyaPqH80XlV4Z6XT5urJ2
	3KZ3hK2JOuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6908BCD8D;
	Tue,  5 Feb 2013 12:40:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1895CD8C; Tue,  5 Feb 2013
 12:40:38 -0500 (EST)
In-Reply-To: <201302051700.r15H0GXx031004@freeze.ariadne.com> (Dale R.
 Worley's message of "Tue, 5 Feb 2013 12:00:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27A62AB2-6FBB-11E2-9A2C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215525>

worley@alum.mit.edu (Dale R. Worley) writes:

> I have found a situation where "git log" produces (apparently)
> endless output.  Presumably this is a bug.  Following is a (Linux)
> script that reliably reproduces the error for me (on Fedora 16):

Wasn't this fixed at v1.8.1.1~13 or is this a different issue?
