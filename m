From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule update --force
Date: Thu, 10 May 2012 07:58:09 -0700
Message-ID: <7v8vh0ozge.fsf@alter.siamese.dyndns.org>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
 <CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
 <7vobpwpoyi.fsf@alter.siamese.dyndns.org>
 <7vk40kpnia.fsf@alter.siamese.dyndns.org>
 <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Thu May 10 16:58:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSUor-0003JR-B8
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab2EJO6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 10:58:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860Ab2EJO6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:58:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E422898C;
	Thu, 10 May 2012 10:58:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PmWDLJGfGFXHjzxKd39e8ulwwt0=; b=LpX+UZ
	dKtp/bxWhZw/PbZ9Qx68Sdfm+JRLB8KjRDh/fAkco5cA/Kz2SDpGEk9/N0wtMwU9
	lfvIzyOLAL9Aqh6cSamXqCluOo+vZ0sl8kilXkI+2+YE58jWyCvVz0vFAyLGPsz+
	CRZ5d4HjYDgMRupOXQMVshryyN7zAthp8bokw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vGx6T4TvhLtLd2z+fulmhoQ2UAL4QkHP
	aSm3CIN6wJbfHOGQxeQbqkFgYydjZQlcLCFDuG1bmpdbBQ/r3AMTMvz255xnVPCm
	VR3/+dcbr00G2+vS6Sq1BVXPDlPswRS4JFEAOp1eLIzWMbSsL5lMD8dILrSwDCuo
	0hDTuWm9/ZE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 958B1898B;
	Thu, 10 May 2012 10:58:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 145E7898A; Thu, 10 May 2012
 10:58:10 -0400 (EDT)
In-Reply-To: <CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com> (Stefan
 Zager's message of "Thu, 10 May 2012 00:20:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F8A4540-9AB0-11E1-B66A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197576>

Stefan Zager <szager@google.com> writes:

> ...  To my mind, any
> `git submodule` command should *always* run on the first level of
> submodules.  If you're going to specify --no-recurse, then why are you
> running `git submodule` at all?  I think 'recursion' only applies to
> moving beyond the first level of submodules.

Very true.

Submodule folks, any opinion on the Stefan's approach?
