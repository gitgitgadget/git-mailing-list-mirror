From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cannot delete weirdly named branch
Date: Mon, 23 Jul 2012 11:42:50 -0700
Message-ID: <7vsjcil3o5.fsf@alter.siamese.dyndns.org>
References: <CAGhmpEFg2ZcwqO=wDNPLfPCnrobq4oOcwvFCm27vrEuiES2XbQ@mail.gmail.com>
 <CAGhmpEGEZchXc4DqZ21BAKxf6_mHRp=TOUH8s=GG0vPscz1kfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "abhisekpan\@gmail.com" <abhisekpan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNat-0004aT-I7
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab2GWSmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:42:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab2GWSmx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:42:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79A1186B5;
	Mon, 23 Jul 2012 14:42:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UcToP8IKUPc7ybEA7NwrcEMz390=; b=tC1Y+i
	py+x29hiY+AKf5hOu3va1ZQnsXNWRmMsV/4mIx5+sjM0B+levOyEevSv8zwsSgv1
	hqxlwlRnecEhuY2YD2TQebA/+Q2CfZx1+tfiN6oeItBHoHvCZQorODsmtoR26DjY
	Z0fwejwKCY5k/BmgjYTx7tD+1bNefW6qZcnm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fN77Qs/UlRH+iO9UckFRp/ktL809fVrg
	gPzY73kPy+wNR5SB+Q37pAuf/UlysFEvci7hG0k4gnL4tXCboRgt2p9tojmMl94P
	6KXSBidSbk0s0AvywvECkJXdSyl3OB2xQKFknMznhatuGLz+gQRoNXqjJG1dNhj/
	vSeW09KOKxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6747986B4;
	Mon, 23 Jul 2012 14:42:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 541D586B1; Mon, 23 Jul 2012
 14:42:52 -0400 (EDT)
In-Reply-To: <CAGhmpEGEZchXc4DqZ21BAKxf6_mHRp=TOUH8s=GG0vPscz1kfg@mail.gmail.com>
 (abhisekpan@gmail.com's message of "Mon, 23 Jul 2012 14:32:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35906B2A-D4F6-11E1-A099-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201956>

"abhisekpan@gmail.com" <abhisekpan@gmail.com> writes:

> Now I cannot delete this branch. Running:
> git branch -d --tracking
> gives an error: unknown option `tracking'

I do not think this is supposed to work, but it does by accident.

    $ git branch -d -- --tracking
    Deleted branch --tracking (was 8670e20).

A more recent git would not let you create such a branch to begin
with. Perhaps time to upgrade?
