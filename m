From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Mon, 06 May 2013 23:36:02 -0700
Message-ID: <7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 07 08:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZbVS-0008GZ-Od
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 08:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab3EGGgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 02:36:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999Ab3EGGgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 02:36:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43D4F18A77;
	Tue,  7 May 2013 06:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYcSSydOyw0tq6q4fLKtjnDTiqY=; b=IcaVzW
	JCULYs8Hdaj12BHvGV5TmMug3dk891QUJ19Xau9wFHpNMEHnICgRlNhVXl8NzOUD
	15HenbMNjyxA47eQNdGL7CvhXZYaMg30SWvjBj15ZI+Y9dCb2+6H36LjXwCiKw9X
	aWXwar6Zy8mnJdI79MKeIB2VFWB/DTM7RsMIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdBUbooRaV5p2KRBVwRyoU6AxC0xx9kB
	M1LFuzM66SNpjwarEHjv4HPHIXlkQUepuyg5MOpUCcu5xjpY8P3AmeNt3/Dv7QQh
	E1fzysYj++UzpxskKcEvHwWMdzbPeXYcuGpZRHHfDZU4TXRtp4PLoev1KqanqnOm
	yJLCmtLNJR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3973518A76;
	Tue,  7 May 2013 06:36:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE2D818A75;
	Tue,  7 May 2013 06:36:03 +0000 (UTC)
In-Reply-To: <vpq1u9kunba.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 06 May 2013 17:42:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63C3BC82-B6E0-11E2-8102-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223554>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> More precisely: you should have a look at git-multimail (in directory
> contrib/, in branch for now pu/, or from
> https://github.com/mhagger/git-multimail) before spending time on
> post-receive-email.

Oh, by the way, is this a vote of confidence in that topic, hinting
that we would want to advance it to 'next'?

As it is only adding a new script to contrib/, it could be argued
that we could even push it to 1.8.3-rc1, but until I hear from the
original author (who will be the champion for that corner of the
contrib/ area), I wouldn't do so.
