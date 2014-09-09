From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git-as-svn: subversion frontend server for git repository
Date: Tue, 09 Sep 2014 09:49:03 -0700
Message-ID: <xmqqy4tsloxs.fsf@gitster.dls.corp.google.com>
References: <20140909111903.GA13137@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bozaro@yandex.ru
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 18:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRObQ-0004Jb-OI
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 18:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbaIIQtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 12:49:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62707 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbaIIQtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 12:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06FA1372EF;
	Tue,  9 Sep 2014 12:49:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r3Xgzp/oNyTrwBNJKSTDfltRI2U=; b=TJlgn8
	RgDl4MMBGwciOjrYLdz5ibGCccEJnSOtUHMEaRhN7uVbPN5M4+VRrxHvCCl6F1so
	1c9P865lkydLYvQc3TNg89ZHOiRYSNA/HRpRj0uecDDUoRzpVyQ+zTHiLXxp3eh6
	FGPQGBil902P5t8N+XEi+idlLVupqSjPR2aFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wnVHOwHi7bdq0o4Nin0TqAunLTSXpL9j
	Jjazrk47suXzd9H5Mc0sNqCWApFgYQj9T7c5LiaPHYzpqjX7eitZlJTdAH6s95kd
	rKgLv2GsuBNgmgAkKnfb405X0QvW7SB59ISeGDsio8AFQaJWhh0mpat/JetPi9q7
	sjVt0fTDSxY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED8D3372EE;
	Tue,  9 Sep 2014 12:49:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 73530372ED;
	Tue,  9 Sep 2014 12:49:05 -0400 (EDT)
In-Reply-To: <20140909111903.GA13137@seldon> (Marat Radchenko's message of
	"Tue, 9 Sep 2014 15:19:04 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35D008CE-3841-11E4-8E10-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256692>

Marat Radchenko <marat@slonopotamus.org> writes:

> Some time ago I complained [1] about troubles using Git
> on a project with high ratio of non-programmers.
> ...
> Then, a lost'n'forgotten git_svn_server [4] was found.
> ...

Interesting.

> Current limitations:
> ...
>   * You must not do 'inverted merges'. Old HEAD must be reachable from
>     new HEAD by first-parent traversal.

I am not sure what you mean by this to properly assess how
significant this limitation is.  Care to draw a simple picture?
