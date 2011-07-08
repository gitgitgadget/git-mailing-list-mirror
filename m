From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Fri, 08 Jul 2011 09:52:49 -0700
Message-ID: <7vwrfod1hy.fsf@alter.siamese.dyndns.org>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net>
 <4E144B55.8020907@elegosoft.com>
 <20110706175803.GB17978@sigill.intra.peff.net>
 <20110706180026.GC17978@sigill.intra.peff.net>
 <7vei23htzz.fsf@alter.siamese.dyndns.org> <4E16D731.5020904@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 22:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgMm9-0005Gk-Pb
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 22:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1GKUIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 16:08:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab1GKUIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 16:08:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35C5B6268;
	Mon, 11 Jul 2011 16:08:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=MPH3f8NAnvRTEK+fzuvVDWInF7k=; b=iDBqWh0uYncCJ1hIM4FN
	EspDcmEfxJ5SvFmw5tfG/KcRcNu+h8edUxK2x/veOP49FHXkYL9ss+3UJ1ngfRE4
	np/Y7ybce027Z6VY3pZWT8FvCvhuKDcBRcpgOrUf1O5b6sJgbUTwFSZJzscFJNb+
	BNn42aRbXowhQ6V18yPJZgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=W8TtczQxTyw3cM7W3pgTY12tVdgdVtxGDabZ/TsauKruRn
	bPzaHX4fdekPY4LXKENNOJW0j0vuDyKLga4fikJXYFOZj+fcP9UEeC+/As2dwGpz
	xwKss17uSk4+o94xuAwBKhskntd54VgoNWFCXLeRrRuGmFXZ09d/KO6rrzkro=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2E7FB6267;
	Mon, 11 Jul 2011 16:08:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8FD276266; Mon, 11 Jul 2011
 16:08:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80217944-ABF9-11E0-9F0B-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176889>

Michael Schubert <mschub@elegosoft.com> writes:

> Sorry for the delay.

Thanks.
