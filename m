From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-fast-import(1): reorganise options
Date: Wed, 09 Jan 2013 14:21:59 -0800
Message-ID: <7v1udu3sl4.fsf@alter.siamese.dyndns.org>
References: <cover.1357760256.git.john@keeping.me.uk>
 <e228dd4522dbf7ebfe0e5207b1dcc9591faa4d15.1357760256.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt42V-00053I-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 23:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab3AIWWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 17:22:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118Ab3AIWWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 17:22:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB905A134;
	Wed,  9 Jan 2013 17:22:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=N43FGt
	QCabbxT/aqX8u3QuGztihP2JFa1xxj2UA6EmJAYxFReOuAcRTQMFuunGxZKMA9Pm
	H0jNps3fiOVffeqDMr1bWCUx8351WO5RB7SiwGTPP84MvzM4RFTr9hvYGv5EHaXi
	HlgmSdmCFUjood1rohTtTmvybggSstI99Xbdo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MkQOOlK3vDhiuJ7JPY7wAgUzfLrzvqxc
	rQTrhQVAnR7//0/2czL6x91ScZZ+PP7g1/gb74VJNxk5dJER8FMOmuVr3q06pMvb
	AP87BQTiVslAt9iDhcmkdU9FvNBZXhAkOkDWDgKrTvPNopegucUBxtFqvKXDJhmd
	3fCZJXHAW9Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD56EA133;
	Wed,  9 Jan 2013 17:22:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CD0BA132; Wed,  9 Jan 2013
 17:22:01 -0500 (EST)
In-Reply-To: <e228dd4522dbf7ebfe0e5207b1dcc9591faa4d15.1357760256.git.john@keeping.me.uk>
 (John Keeping's message of "Wed, 9 Jan 2013 19:45:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD1EE1F0-5AAA-11E2-8442-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213110>

Thanks.
