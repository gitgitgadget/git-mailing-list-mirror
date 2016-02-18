From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/20] log_ref_write_1(): inline function
Date: Thu, 18 Feb 2016 14:23:38 -0800
Message-ID: <xmqqvb5lejyt.fsf@gitster.mtv.corp.google.com>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
	<5c317eec82b3da3cd4f4a2bba276afe6ef2603d9.1455626201.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 18 23:23:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWzB-0000ge-Dg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426698AbcBRWXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:23:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1426141AbcBRWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:23:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9816E4537F;
	Thu, 18 Feb 2016 17:23:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmITcCLqXAg0miORi7vmZC4jmxc=; b=C4Fjpw
	TwHZ5U+qxbuqGCBd4HKOFNP9Cv7Io+u26tKtdEJ+/HvBHc0tZASCVRO3ubsnM86l
	6LzZVNIhHWdBtK2J4GkYHBDKIhuDZQbMdWrOf4xF6DxqLVf/wfPsP0F78r9nNru4
	q0Qzvkeo+/BASwwVwWPBg1SW17RsmvtKIiCCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HD+oR3LqAPPaPfTrewpz2yTTV+jhBTXg
	Ii6PRelICKyTqFeQnZ544nI+pMW5BUz24Ok7Dt7NMD0g+0lL1bxZnQGll3sE6Vv/
	XYT1Y6OQBF7KR7Qndkdjs1mBU9mXu3lNUZaeg83T0yviYB69Yo7hFATOVn5B3TI6
	KAsRhReP6dk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E9B84537E;
	Thu, 18 Feb 2016 17:23:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 11F854537D;
	Thu, 18 Feb 2016 17:23:40 -0500 (EST)
In-Reply-To: <5c317eec82b3da3cd4f4a2bba276afe6ef2603d9.1455626201.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Tue, 16 Feb 2016 14:22:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42E7D00E-D68E-11E5-A40F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286634>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Now log_ref_write_1() doesn't do anything, so inline it.

Nice.
