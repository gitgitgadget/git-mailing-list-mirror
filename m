From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 15:42:02 -0700
Message-ID: <7vbo8vabet.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<7vhaindcuk.fsf@alter.siamese.dyndns.org>
	<CAMP44s2S4AtZUfH4NWCLt=p49QXeYSZKELYbahpBUgDofaFMsw@mail.gmail.com>
	<7vsj27ac2a.fsf@alter.siamese.dyndns.org>
	<CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 00:42:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXJFT-0000DE-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 00:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933874Ab3D3WmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 18:42:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933732Ab3D3WmF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 18:42:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A4651A64F;
	Tue, 30 Apr 2013 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LBPveoqbClNaEM6LLs1Ero1pyRQ=; b=C0q4zx
	rTqj+RaCwEOLLmL1aT1zMWE6x29w+lKKIiTmGMfbxOqUGoFx7ur0ldNcnbe2v/1i
	ioFEWOn4+vQYtfQJqyi2hWissMCF+/I7evw8LFPvjoa3LDgTBy/DQviaQaON8945
	F7ICFGT/jdEvqRvafAeCTDY5OGLGK8vXycLYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/zi3TtHP7oKIvPDz4trdCxTuP1dtzlf
	xtDirKeQh2ZPkyJIbbcu9u6hVma3tcK8NHZoBFg2Dblnqoi1dpW2G5hUPQnyTdxQ
	ct/y4MrTu5TPPTe35Gn94Tk1kPTwUVth8lJDe2v1uhvdwEixUc4E6SSlhlFJ7Nl5
	2QE8dXAUe8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DB611A64E;
	Tue, 30 Apr 2013 22:42:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C26FC1A64C;
	Tue, 30 Apr 2013 22:42:03 +0000 (UTC)
In-Reply-To: <CAMP44s3=frHWUh8rQ5kTooUJqwAtkEG37MaeY3Ho6G7-kwZQ_w@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 30 Apr 2013 17:38:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DD2934E-B1E7-11E2-8F4E-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223035>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Since 'update-ref master' updates the 'master' ref, and not
> 'refs/heads/master' (IOW; no parsing at all), I think it makes sense
> that @{-1} is not parsed, and neither is @.

That is a very valid point.

What should "rev-parse --symbolic-full-name @" say?
