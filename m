From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: have ls-files and ls-tree "see also" each
 other
Date: Mon, 04 Jun 2012 22:43:32 -0700
Message-ID: <7vehpuqpob.fsf@alter.siamese.dyndns.org>
References: <1338873037-4343-1-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 07:43:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbmYQ-0007ej-DT
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 07:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab2FEFng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 01:43:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649Ab2FEFnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 01:43:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B46B4623E;
	Tue,  5 Jun 2012 01:43:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0MXtoCWhrNeqxwWoYbGEw/fXw0s=; b=NVxbXTbk9UYWRIeNe7u2
	qrH0LuTu3goZiOQo6h2GEw2a+bELy1It/J05jinAl4pnFx90yqkU2S9uBhXFh2P4
	SMDTVwQLLRCEsFIb4laNRGx32fcenGwHbO+1p+tgPaG/wcQRS7n7sHd1VEqXpKE8
	lV8C+xu1u/4kajy9VWsCNaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hoEqjgx3ubhS4V0Wy9Z0GjQA95ScnDqwlDHjfuMO+oC1T2
	CxT3DSmnzbOpDtgAr6zJvSIKAOuTwvrRSROlJsTKbELseata3HPD0QJgjUinBQz6
	D/4g7yEATlkG1TH8Pt9gdJQxPzoQ7fC2y/btnJx6MRa4/wSMWs47s4XyUCly4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC08A623D;
	Tue,  5 Jun 2012 01:43:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44768623C; Tue,  5 Jun 2012
 01:43:34 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63C26782-AED1-11E1-A098-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199202>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> ---
>
> I could have used these references when I was looking at git-ls-files
> documentation and trying to figure out how to make it list files
> from a specific commit like git-ls-tree.

I do not like this kind of patches in general.  Where will it end?

"I wanted to know how to list objects recorded in a commit, and I
could have used a reference to git-ls-tree from git-commit, so here
is a patch to make them refer to each other"?

That kind of overfiew is what the tutorial (for concepts like the
index, tree objects, commit objects, etc.) and the list of commands
in git(1).  Is there compelling reason other than "I didn't bother
to look, and it is likely other people wouldn't" to apply patches
like this?
