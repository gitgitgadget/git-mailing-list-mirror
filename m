From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Tue, 02 Feb 2016 14:13:32 -0800
Message-ID: <xmqq7fimrcab.fsf@gitster.mtv.corp.google.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
	<1454443734.5545.1.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:13:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQjCe-0006NH-5h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 23:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbcBBWNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 17:13:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750793AbcBBWNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 17:13:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D89534009C;
	Tue,  2 Feb 2016 17:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nplTP5FXxb+48w0131HahykI6Vg=; b=U+xwKF
	GLObfqGHv+r6bEQITIgfzySAXxeUOFhDAlfwIbNm10as/x7Ul+C7JIWvEW0a5c7h
	KyV4dex+qTaGrIZXLEsCg76/XguU5eIjyeKDEM7IBsZfe0bCwGWSfcmloL2ora9z
	7O3mw0iuTjgh3//iA3nCHJkUXefHUL3sQ0UYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZeGX+ytx9ive6i7GAZv0d0WkkKbNcEG9
	9N2WJ/YYi6ps6rS7ZYsnydd437T3IUgdzLppyzW+Xv+JYEYPwk4xDIXTJK9eYMIJ
	nJkNZo+ZVMeGuqyL2ieXMKqSQBFJBNIK7jrdnZiRrt18PLwPyd7CeUnkUy9zNn7L
	fPRWacCYW1c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0BEC4009B;
	Tue,  2 Feb 2016 17:13:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E3BB40099;
	Tue,  2 Feb 2016 17:13:34 -0500 (EST)
In-Reply-To: <1454443734.5545.1.camel@twopensource.com> (David Turner's
	message of "Tue, 02 Feb 2016 15:08:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 333D5F5C-C9FA-11E5-8707-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285312>

David Turner <dturner@twopensource.com> writes:

> Are there any more reviews on this?  I do have some changes from this
> set, but they're pretty minor so I don't want to post a new one (unless
> folks would rather see those changes before reviewing).  Let me know.

Thanks for pinging.  As this is a rather wide-ranging topic, it was
not practical to intergrate with the rest of the topics in flight
back then, but now it seems that this needs only one topic that
still is in flight.  I'll queue this on top of a merge between
'master' and the tip of 'sb/submodule-parallel-update' and include
in the daily integration cycle to make it easy for people to view
the changes in wider context as necessary.
