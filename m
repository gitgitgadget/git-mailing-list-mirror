From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Mon, 02 Nov 2015 08:42:41 -0800
Message-ID: <xmqq37wofj3y.fsf@gitster.mtv.corp.google.com>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
	<5633CE60.8060907@gmail.com> <5633D0C7.2020709@gmail.com>
	<20151030205955.GC21923@csclub.uwaterloo.ca>
	<56345076.30207@gmail.com>
	<20151102151123.GF21923@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: The development of GNU GRUB <grub-devel@gnu.org>,
	savannah-users@gnu.org, git@vger.kernel.org
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtIC0-0000zH-Su
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 17:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbbKBQmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 11:42:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752246AbbKBQmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 11:42:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C22BA26FCB;
	Mon,  2 Nov 2015 11:42:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RXbhTdwLbFt/RE5KnB/xNHJowBI=; b=i4ou9s
	U3If6/q4r3O/Qx9jevL+uxRRHK6QmdRYYy7BVv2RFCFCzY6WySpx8QVs8A/scBh3
	98KG6NP6268asxkDvz32u9x3rmC+DrrvVO7SGCb8IoBLxGFi5d/wgKIGvPPfGGPD
	oUqKyaHIQl8lvAdAFdJ4P4LhZTz7FH2gm9H84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wEGU573w0lla8wfSGnM9rot8uSRN8CyS
	3Rb3QX6qIoQdhgdX3x3WTmbX68nhgUOr7w5ZIa4ATM/QfpWzEnMYSYlpVtI0bm2R
	PIUlrcV0MeYPdjIoBpT7H23X6pDxREH9vPKDdVzxIRTqkBIQaj6p90nI3+qncVU0
	N6PuDREAYJE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAAD926FCA;
	Mon,  2 Nov 2015 11:42:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4465B26FC3;
	Mon,  2 Nov 2015 11:42:42 -0500 (EST)
In-Reply-To: <20151102151123.GF21923@csclub.uwaterloo.ca> (Lennart Sorensen's
	message of "Mon, 2 Nov 2015 10:11:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC7F72B8-8180-11E5-96E4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280698>

"Lennart Sorensen" <lsorense@csclub.uwaterloo.ca> writes:

> On Sat, Oct 31, 2015 at 08:24:06AM +0300, Andrei Borzenkov wrote:
>> If we decide to fix this commit it is better done now, while it is the last
>> one. It is annoying but do you have suggestion how it can be done
>> differently?
>
> Well the only options are:
>
> 1) Leave it alone
> 2) Break the tree of anyone that already pulled.  (Posting instructions on
> how to fix it would at least be nice then).
>
> Not sure how many people regularly pull the tree.

Is the discussion still require attention by Git folks for their
help?  If not, could you take this back to savannah specific mailing
list?

Thanks.
