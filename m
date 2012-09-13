From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestions for "What's cooking"
Date: Thu, 13 Sep 2012 11:06:31 -0700
Message-ID: <7vmx0t94rc.fsf@alter.siamese.dyndns.org>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org>
 <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
 <5050E0CA.7080907@web.de> <A7A1DB46082142E683753CFBC0A22A6B@PhilipOakley>
 <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:06:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDoJ-0006bn-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab2IMSGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:06:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959Ab2IMSGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F34E8CC2;
	Thu, 13 Sep 2012 14:06:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ePue0HatKfHiwXTvKTNIBmeqVQ=; b=Q3/OwZ
	bJ7hlyC7xgfayKrnEbmgo9pQG1Dh4MbU8CMBcc8DlvouLxibZ9MsBC0+qA+EWBvM
	awBGGqpjtzadImiyJpK8w198z8X1GHSWn/ecSugdv51o5eZAi5p40kBsBZAlc/CR
	yP95ncVF1gNufyvE0pZ8ZFbhI+TfCEGiVJpUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HxsfWITvL1KnaVVWAOvm5AUtuPBGRpdM
	wHQUG1j3SX3VhRSpoWFOQP6aZ5Uv9otRHWvpCUMv+TF6sT6EY4auTgCzz8EyMcEB
	n3MlapFUOxAjcTUXduAP3Rz/YN4TiXA8xKzZMxMEgu29MPfWZwcqkvL1hEjWAOEr
	25Uax1TwXY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BC168CC1;
	Thu, 13 Sep 2012 14:06:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD2AF8CBF; Thu, 13 Sep 2012
 14:06:32 -0400 (EDT)
In-Reply-To: <CAH5451kmwZehys4nL+NV8m8VGjDJtkSxru3o44_J_d3jD5ipxA@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 13 Sep 2012 15:14:26 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFF57E22-FDCD-11E1-B7CB-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205401>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Currently, the output for each branch looks something like:
> * <branch-name> (<creation-date>) <number-of-commits>
>   (<merge-status>)
>  [list-of-commits]
>   (<branch-usage>)
> <long-description>
> <notes-and-memoranda>
> <next-steps>
>
> and these are grouped by current integration status (new, graduated,
> stalled etc)

Yes.  Thanks for a concise summary.

> A format that would make this information easier for me to parse would
> be something like:
>
> <short-branch-description>
>   <long-branch-description>
>   <notes>
>   <next-steps>
>   * <branch-name> (<creation-date>) <number-of-commits>
>     (<merge-status>)
>    [list-of-commits]
>     (<branch-usage>)

I do not see how it makes any sense to have the "This is where the
section begins with, and its name is this" line in the middle of a
block indented in such a way.  Care to explain?

I can see some people may care more about the description than the
list of commits [*1*], though.


[Footnote]

*1* It however is an indication that the title of each commit needs
to be improved to convey enough information so that I do not have to
write the branch description myself for them.
