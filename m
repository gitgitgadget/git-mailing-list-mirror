From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Sun, 20 Mar 2011 11:25:43 -0700
Message-ID: <7vhbaxwswo.fsf@alter.siamese.dyndns.org>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pavel Raiskup" <xraisk00@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 19:26:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1NKG-0001SJ-CR
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 19:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab1CTSZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 14:25:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab1CTSZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 14:25:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C6F34A90;
	Sun, 20 Mar 2011 14:27:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=z0XVi6QZE5wtVrvwULjWbk4Rhm8=; b=xgSBWGDqipJLSg8EyiYF
	YWUjxLkpVybsUG78qMX+esckApVDyfZw4DQpTC0lIsyoHfvc7WK+W6lLhNoeFTfp
	qhm1ukgWfy5i5RIjrrVbXkat1A3XFSgnxy3Q9SrBAxvX5BsNhZyenI1QvH+PvPmS
	VFZYf5tYyMvzh4UNyUhpF2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mKOkyW9ljj6/rnjjT2R4su7xE3ljwHN9FFiYgcH17iCCq4
	3/LpJctPumkayA6ylS0Z50YWbOhlvXjWDy2ByaMETsYkgKuhowklPSnnJaxCReC9
	0n6I2XdQb6hPy5G4vH57POz1Tjhva1sp6vaPuhBrRU6J2RqQMnQ6GwfUVC+ms=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A0134A8F;
	Sun, 20 Mar 2011 14:27:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 963CE4A8E; Sun, 20 Mar 2011
 14:27:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B4D74F3E-531F-11E0-A56C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169517>

"Pavel Raiskup" <xraisk00@gmail.com> writes:

> I have one theoretical question -- what if the benchmarking/study of
> histogram diff leads to conclusion that this algorithm will not be
> useful for upstream?  Does it mean "fail" in terms of GSOC?

Not necessarily. A negative result is often as valuable as a positive
result.

It will take a clearly good implementation to justify why a negative
result is a success, though. If it is clear to the reviewers that the
implementation is poorly done, the negative conclusion does not
necessarily mean that use of the histogram algorithm is a bad
approach---it would just mean the particular implementation that didn't
implement it well was, and then the GSoC task may have to be marked as a
failure. But otherwise, if the submission is done with the usual code
quality we would expect from contributors and explained well in its log
message (either positive or negative), I would say it should be considered
a "success".
