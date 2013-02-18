From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] User manual updates
Date: Mon, 18 Feb 2013 00:56:07 -0800
Message-ID: <7vr4keatlk.fsf@alter.siamese.dyndns.org>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7MWZ-0007UX-I6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 09:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3BRI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 03:56:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33214 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab3BRI4K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 03:56:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7906FAE9A;
	Mon, 18 Feb 2013 03:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l4n5FzFzFYB0YvyM0IrikjdDAvU=; b=g7xSbX
	edbomhnFgb4ADIG3GkYzVMCYrGG8NU4R84AXEq1ufnbZdTFTtbalVD2s1PfUSki1
	BFBahj/Vsd0XePTWx1HM0pU7XEus11N7s+3Bi5oJPjTxTXUkWF4YaVELdcH8OxQD
	1UJ6pMHV1nePcITzALgMS+cB6F0N6nKgBKt5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N296vuMo+g4I2xrxtQ7krS37vjs0tt0a
	AP5hqHERlb8B23yKDycZxl9SoxTHCGxmpUx7DijOaKNiucJtg+CFI1aYqnPIXBXu
	8w39f75vBoN8DGLi/8HYiK6kBKCtIlv09No8VwDVczfeBDDed44ET2JHetWzn9YD
	MkRY1zYqRso=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D7FCAE99;
	Mon, 18 Feb 2013 03:56:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4F1BAE96; Mon, 18 Feb 2013
 03:56:08 -0500 (EST)
In-Reply-To: <cover.1361146398.git.wking@tremily.us> (W. Trevor King's
 message of "Sun, 17 Feb 2013 19:15:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09725884-79A9-11E2-8B53-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216443>

I've taken the following to 'maint', some with minor and obvious
fix-ups:

  user-manual: use 'remote add' to setup push URLs
  user-manual: give 'git push -f' as an alternative to +master
  user-manual: mention 'git remote add' for remote branch config
  user-manual: use 'git config --global user.*' for setup
  user-manual: use -o latest.tar.gz to create a gzipped tarball

I think I've sent reviews for all others, except for the `backtick`
one.  I think it is more efficient to do that one _after_ we are
done with all the others.

Thanks.
