From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t4010: match_pathspec_depth() and trailing slash after submodule
Date: Thu, 23 Jan 2014 13:38:43 -0800
Message-ID: <xmqqwqhqs7j0.fsf@gitster.dls.corp.google.com>
References: <2550653.GHkhBQDSTk@localhost.localdomain>
	<1390483326-32258-1-git-send-email-pclouds@gmail.com>
	<1390483326-32258-2-git-send-email-pclouds@gmail.com>
	<xmqqa9emtngr.fsf@gitster.dls.corp.google.com> <52E188D4.20904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, pawel.sikora@agmk.net
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6RzD-0000Xr-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbaAWViw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:38:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaAWViv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:38:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F58265315;
	Thu, 23 Jan 2014 16:38:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xfMAKXmwotN0jtpO76AWhn7nCqc=; b=jJoyrC
	gbNaj2yNfRpBWkIDP7GtRBhrPdFAcNiwPGXdqmtVvNLcmSGF7Rely6Pd41Om4oXf
	1nd5XlOdZwbJ9wCfmIx1W2iq6mtlOW+1qGuE9amos1j2F6MHKBhlv/L5G6f+lj8n
	G0J/mx/nhLmkNREphJXf3rUxVbNgD0EcqBm9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cdW2wZS13/fk7R/ahgacgVFRMxuLipq3
	vlXjDlbpFmrzHjkEyQG9GSBDMMTTIidh7LsnDnMMto81GPxv47GavODvOaB3Fzhs
	wQ0dPRN7pRBfSExmu+yK3MEypViHudOWjJwBj3HDeHXClyXqFoG7pTSg9VHED9Ui
	1MD2gt+sGEg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C6365314;
	Thu, 23 Jan 2014 16:38:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E6E9652FD;
	Thu, 23 Jan 2014 16:38:48 -0500 (EST)
In-Reply-To: <52E188D4.20904@web.de> (Jens Lehmann's message of "Thu, 23 Jan
	2014 22:25:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE33A9B6-8476-11E3-8BC8-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240963>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> ... But a single
> trailing '/' does mark "submod" as a directory, which I think is
> ok for a submodule. And it makes life easier for the user if we
> accept that, as shell completion will add it there automatically.

OK, that would be annoying.

Perhaps the completion is what is broken here, then?  I dunno, and
haven't thought things through.
