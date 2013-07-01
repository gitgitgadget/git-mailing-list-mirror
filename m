From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] show-ref.c: Add missing call to git_config()
Date: Mon, 01 Jul 2013 14:56:00 -0700
Message-ID: <7vtxkeaq06.fsf@alter.siamese.dyndns.org>
References: <51BCCE98.3070201@ramsay1.demon.co.uk>
	<7vppvlighf.fsf@alter.siamese.dyndns.org>
	<51C0A939.8030200@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:12:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmL2-0005Ta-Br
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab3GAWMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62619 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204Ab3GAWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFA12D35B;
	Mon,  1 Jul 2013 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=cpL8hIPltdKw3kCAZKINTN0CEW8=; b=iEiTjko1oMycwxzJxHBi
	MNC5MOmJNVJm2Dpty4PYWM0RDHJv59RUXm9w5JlMjj98FWc0ZrcFDr0gsXV4irB/
	EeqeVpIsfPvvGz42bGa0RoHXp8lRP6nSGk6KrLkCpb/IWW2w2nK0GUouC0iDYKMO
	ifGR3mWzjW3ZXRyPwEvRuIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aRP3/huf68HrP9E+nTZA3lN55olj62YOxE9nmIN21qi2uQ
	JPu14vcLk16Rl6Cy8vSVcJbcATd6nO9hcFbxVI1yFae+jCmvRvW+E6v/JicjYIgu
	sCCclfJGGDaF6X8k8ag9OTO/bbJwB+JZXbiRTHgZb3k6LSjXIdtj///IIky8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4348D2D35A;
	Mon,  1 Jul 2013 22:12:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE74B2D359;
	Mon,  1 Jul 2013 22:12:42 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59BD0914-E29B-11E2-89D2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229333>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Yes, I will send a v2 (soon-ish, I hope).

Ping?

No need to hurry, but just to make sure this didn't disappear from
everybody's radar.

Thanks.
