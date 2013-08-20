From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] gitweb: Ensure OPML text fits inside its box.
Date: Tue, 20 Aug 2013 12:52:25 -0700
Message-ID: <xmqq61v0w35x.fsf@gitster.dls.corp.google.com>
References: <cover.1377019362.git.dot@dotat.at>
	<724e6c13dba3ee00967b4e3f13e472357e24b6c5.1377019362.git.dot@dotat.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:52:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBryj-0003CS-PA
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab3HTTwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:52:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266Ab3HTTw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:52:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8B363A891;
	Tue, 20 Aug 2013 19:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mCw5vc3f4CHIO6i7WramZXMy7Ng=; b=BO4bR1
	8sX+cRryO+9rgJ+h2mWOdCYfxLdxfLTmEo59olo49JVAB5thz6m7yGnZkfGuz004
	hPs1cn4SYzs/1d4fWm9mobzwTC+vGWF1ScwPJ6v6DZhiryY7PFeDZVwkLsR5NyJT
	pot86I3rDqRWNYRU0+en3SS/R2HWSppfA8soA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3RFTTZbUyMLGiz2EvAXTP3vvUvVKb5r
	v8dz4PRdYheGTdFhSs1v4ChD5oQuFsTipj2hr3deydylKF6ZttH/DfOP9eOpThzc
	S+dlycfsOKlIvfK2keJ34mzcRYi4gr+PYLq/9Wp7sQI5LP2WgRohX0I4TGjSz6Pt
	5vyueDxgxvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFA303A890;
	Tue, 20 Aug 2013 19:52:28 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 524773A889;
	Tue, 20 Aug 2013 19:52:28 +0000 (UTC)
In-Reply-To: <724e6c13dba3ee00967b4e3f13e472357e24b6c5.1377019362.git.dot@dotat.at>
	(Tony Finch's message of "Tue, 20 Aug 2013 17:59:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0AFDF384-09D2-11E3-AF7F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232641>

Tony Finch <dot@dotat.at> writes:

> The rss_logo CSS style has a fixed width which is too narrow for
> the string "OPML". Replace the fixed width with horizontal padding
> so the text fits with nice margins.

Makes sense to me (although I do not do css).

>
> Signed-off-by: Tony Finch <dot@dotat.at>
> ---
>  gitweb/static/gitweb.css | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
> index cb86d2d..a869be1 100644
> --- a/gitweb/static/gitweb.css
> +++ b/gitweb/static/gitweb.css
> @@ -548,8 +548,7 @@ a.linenr {
>  
>  a.rss_logo {
>  	float: right;
> -	padding: 3px 0px;
> -	width: 35px;
> +	padding: 3px 5px;
>  	line-height: 10px;
>  	border: 1px solid;
>  	border-color: #fcc7a5 #7d3302 #3e1a01 #ff954e;
