From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull --no-ff documentation
Date: Mon, 01 Oct 2012 13:24:40 -0700
Message-ID: <7vmx06aqk7.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6ROuyCg9WK79igJ=a=6pwT+7TjOJLCNwe454oW3hiJETg@mail.gmail.com>
 <7vsj9yerbh.fsf@alter.siamese.dyndns.org>
 <7EAC0E5241D6431599764E90FA821FCF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 01 22:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TImXv-0006vG-5l
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 22:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab2JAUYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 16:24:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50956 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab2JAUYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 16:24:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D2BC9B5B;
	Mon,  1 Oct 2012 16:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HrTgVpOwq+NhErB4GoRhbu3Luxo=; b=k0ILll
	jtU44YKGXzru0RoShWdrDmHIBJep3nRByDjz/ca3PA4Cix9q80YiOUZymbXgaYZe
	R1Tw5nb224vho0oIHLxLh1hmjW0j/xWANwc0Gzbm8ZJKskETomncUy442IcPzSM5
	Pdf9FODFgIxzwQvDx21yuAyOZoUjiEbcFH7eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZDwmc1gHo6zwacoo/wEqTCt5wSgKfuqi
	3rdqUCYKFgaNmk67dpuruIe8zhX4Ee3XnQ6meYGq3Gbfk8+e0KXoH3riqAx0TMfu
	AEMq3iAjT+UNeHiIENR3q3v0n1wMAtZYEzimyRv1RySlHeSvzsF3S2yVm9YD2N5t
	TNrGT3ONVpI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B9659B5A;
	Mon,  1 Oct 2012 16:24:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0ECE9B59; Mon,  1 Oct 2012
 16:24:42 -0400 (EDT)
In-Reply-To: <7EAC0E5241D6431599764E90FA821FCF@PhilipOakley> (Philip Oakley's
 message of "Mon, 1 Oct 2012 20:54:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08B4F778-0C06-11E2-A992-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206765>

"Philip Oakley" <philipoakley@iee.org> writes:

>> This actually is not about --no-ff but about --no-tags.  Any option
>> that "pull" itself does not care about stops the command line parser
>> and the remainder of the command line is fed to underlying "fetch".
>>
>
> Should this be said within the documentation's synopsis ?
>
> e.g.
> git pull [pull_options] [merge_options] [fetch_options [<repository>
> [<refspec>…]]

We certainly could do that, but I was hoping somebody would
volunteer to make it easier to the end users so that they do not
have to remember which one is which.

The "perhaps something like this?" patch was a hint to show the
first step in that preferrable direction.
