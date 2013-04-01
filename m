From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Sun, 31 Mar 2013 22:07:08 -0700
Message-ID: <7vppyeltz7.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
 <7vhajvv51f.fsf@alter.siamese.dyndns.org>
 <CALkWK0=+7ctiiYJSs3SQvV8aywT4tvwGLZ02KLozP8zjU-LQ2g@mail.gmail.com>
 <7vhajrnhco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 07:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMWy7-00080i-Dv
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 07:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab3DAFHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 01:07:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab3DAFHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 01:07:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB438FBF0;
	Mon,  1 Apr 2013 05:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jC+I9bXbyZVGLxxeaPoptPlRvSQ=; b=lJ23iV
	PXewwmA/e/WSoUGs5684T4wRAMg8wO4hsCEejv9pkEhAdijkFV8KCkMdQGxlNrQ8
	CxnKTEeM3/n79mab+V0kIUVNNY+IqykC7bGYJmcwU1rXa9tAVooG8OG6WfQyuU0W
	Kw2WZ+ABab+LmkLsGLQeg5fPsZe6Fn5k+YKZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VB7YDori3hs8WFR5POo09OAzMIE+s2f2
	AQF8PxK4k4bAYF0hMoTW//USSKEEofAwA/q7uuKXnZ8hULXUV022SnTKkH3TR6kk
	aFZHBXBla2kAUDgN4p6gnOKwOXPNW/TwaYcDtnGe0Sj0jtqbm8bVqXnfZc7NaDMq
	JedEzCbkENQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EFE5FBEF;
	Mon,  1 Apr 2013 05:07:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F462FBEB; Mon,  1 Apr 2013
 05:07:10 +0000 (UTC)
In-Reply-To: <7vhajrnhco.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 31 Mar 2013 18:56:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01D46584-9A8A-11E2-9570-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219669>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>> [...]
>>> Thanks.  That is one of the reasons why we do not want to see too
>>> many custom test helper functions.
>>
>> I noticed that you queued my original series without modification in
>> rr/triangle.  Should I submit a re-roll with Peff's suggestion
>> incorporated?
>
> If you want the topic to make progress, yes.

By the way, this series seems to break a few tests in the test
suite, both as a standalone topic branch and as part of the 'pu'.
