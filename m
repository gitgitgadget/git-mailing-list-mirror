From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Mon, 23 Jan 2012 14:34:35 -0800
Message-ID: <7vaa5e6oas.fsf@alter.siamese.dyndns.org>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
 <4F1DDECB.5080904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSTL-0006Ol-MA
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab2AWWej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:34:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab2AWWei (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:34:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1D377C61;
	Mon, 23 Jan 2012 17:34:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bXPfBQ1q/ubbHrMojLJNuS1f7fg=; b=pT9U5b
	R5T7jt+sV0JwUW1J7qjklULSXecel4NX6ClwE2qIBYahqNIvjK+y2DkUkdYe+OsZ
	upWxk+4Fh0PB8wl6pYkjRsp5RJ20vhiLs3x+nqWfNPJW8vpDRsWECwctxjOx1ABB
	6yMxkIkN+si/5sTWUITdfQLQjo0MaQkRZgErA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxKA5mraVqKYfoNIGUtr0Uf4e2/vCMeV
	O/z/e+NHslPviGAtOutvVv4QcFvK04wVcsQbJEC0mAk52f46KJeuJKQclMUiCb9G
	DuKqjqAlhce8B+oe4wHQCro2kBqZYYN6MD8mDJLhJcLNPwc0qqxY0gsvBfPaz++5
	HsTl1PTUGe0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A51E17C60;
	Mon, 23 Jan 2012 17:34:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248C77C5E; Mon, 23 Jan 2012
 17:34:37 -0500 (EST)
In-Reply-To: <4F1DDECB.5080904@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 23 Jan 2012 23:27:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E4B3CCE-4612-11E1-8C13-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189021>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 01/23/2012 11:18 PM, Junio C Hamano wrote:
>> Traditionally, a cleanly resolved merge was committed by "git merge" using
>> the auto-generated merge commit log message with invoking the editor.
>
> s/with/without/

Oops, thanks, ... goes to find a hole to crawl into ...
