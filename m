From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Tue, 01 Jan 2013 21:19:13 -0800
Message-ID: <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Dan McGee <dan@archlinux.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 06:19:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqGjp-0000r8-SO
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 06:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057Ab3ABFTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 00:19:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab3ABFTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 00:19:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31EB482C1;
	Wed,  2 Jan 2013 00:19:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V0DqDuiyUOuvAiMTI4LOTe0b9FA=; b=LEZrZL
	wg86P8GVrHMXe0IyogS3ImRNVP4IWVeIiqNbuiQFL0T+au+UyonRNRf+brH1MtLh
	MbyfGlOHh5F3nUJlx/gdKFqEfZciUNjP6cMWmDqfFeMysapUvn6U7n8wXS8tJeor
	CDf6DX+VbZ06y54CpFQljArmC5K3+XpEJmcFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rz1Gf7PkG4Wo0pypH4kQ0ja34JUnzav9
	fe09Y8nG7DIJbzpjm2oCVlyqTX7CBifNv9Ftdgmh40PfNHkCqQcN+8n20yXkI9uT
	vxymV/PgCnN/l8/q75jieO9PFO1ctfgST7aczDR8400X0+6/MtY3yDCv1k3H9Sp/
	DlLpV8BTg8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 170B982C0;
	Wed,  2 Jan 2013 00:19:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79B5082BF; Wed,  2 Jan 2013
 00:19:15 -0500 (EST)
In-Reply-To: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com> (Dan
 McGee's message of "Tue, 1 Jan 2013 22:12:17 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F36AFB40-549B-11E2-AB3C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212491>

Dan McGee <dan@archlinux.org> writes:

> A test case snuck in this release that assumes /usr/bin/python is
> python2 and causes test failures. Unlike all other tests and code
> depending on python, this one does not respect PYTHON_PATH, which we
> explicitly set when building git on Arch Linux due to python2 vs
> python3 differences.

I had an impression that you are not supposed to run our scripts
with python3 yet (no python scripts have been checked for python3
compatibility), even though some people have expressed interests in
doing so.

Eric?
