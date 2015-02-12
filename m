From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] support for --no-relative and diff.relative
Date: Thu, 12 Feb 2015 15:17:56 -0800
Message-ID: <xmqq1tlupvmj.fsf@gitster.dls.corp.google.com>
References: <54972C33.4030009@shysecurity.com>
	<54A2E748.3010008@shysecurity.com> <54A2FDD2.3010707@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: kelson@shysecurity.com, Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM31H-0006Gj-RU
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbbBLXR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 18:17:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbBLXR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:17:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C5E63820E;
	Thu, 12 Feb 2015 18:17:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=mJ/Jq4WAfZ4D/+MZ1SpYpFoxgx8=; b=SR2RzIikqm0yY17f+uwA
	KpX0dUYXBkM2QKccjvJyOJ73xDDkwhD5ilWKTDyhs0k4yTD7dSR+CBTwUpsoDawy
	nrJ3EVc9luw9G4SHi7BGqA/jIWJhOCoYQf2CKhq61LzXFmARveIgRf5aitmCQmbl
	4LGvEThtPxk9sSCD5VWoCGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DmFr7D/UzjHlWEvdYWgC/WPfRnAO7HeuGHbCIKn7628alj
	Q+xSHBGNiqMX72C9309Yru+buOPupi863sB2zP+SYZKyEP8X4Z0YWYGuhhoNMxMU
	gp2Ms8x+5pd9RitywuE6z0dFGso0kPqopKXFabnd5/D+xaz4Jf/Z3v2CDmH3I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 620413820D;
	Thu, 12 Feb 2015 18:17:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3ADF3820C;
	Thu, 12 Feb 2015 18:17:57 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 617CB41C-B30D-11E4-ADE2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263787>

These two patches

    * bp/diff-relative-config (2015-01-07) 2 commits
     - diff: teach diff.relative to give default to --relative=<value>
     - diff: teach --no-relative to override earlier --relative

have been sitting in my Undecided pile, primarily because I am wary
of touching a core command like "diff" with just me reviewing.  I
think they look reasonably safe (especially since the configuration
parsing is done only in diff_ui_config()), but I may have overlooked
something obvious and silly.

Another set or two of eyeballs are very much appreciated.

Thanks.
