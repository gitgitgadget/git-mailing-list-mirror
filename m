From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestions to make git easier to understand
Date: Thu, 11 Aug 2011 15:39:13 -0700
Message-ID: <7vmxffpo8e.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
 <20110811221627.GA32005@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Rafael Magana <raf.magana@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 00:39:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrduL-0005eB-Cr
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 00:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808Ab1HKWjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 18:39:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab1HKWjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 18:39:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 160494D83;
	Thu, 11 Aug 2011 18:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9oua8HcDsuNbrAqvLqVAoCEygNw=; b=wzbHUh
	a1UfWL7dEwIOqgoYkNcVernSWBQ30Qxr08bFSsasL/mw/ZCxDjz5xrHZYI+c5f3x
	H0KjwlDNbHmqDx6Ro8bfGp3LWv0f4BtGq3rnSGkbvywwLAUOAiw0nNW/wlpxe+P8
	kgha8nAS94vt/Oeu+ifUC2ox3x/aa+UTlg5Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFf5W444WuyaQpwmllAznB4xG8pVO0U6
	5MZSeKoFLQgD6JRvhvG6oSCljkwiHjOM5enIA+7RpCSVKiU3RYJ7m2QnwPoqGx6r
	cZernWYBuSsMhBpeEOWU/AqQ8Rrlq2DNS/265wbITNIlcxZZ4vKDnc0jhH50s6mR
	nmSh/uiON6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CF5A4D82;
	Thu, 11 Aug 2011 18:39:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9579D4D81; Thu, 11 Aug 2011
 18:39:15 -0400 (EDT)
In-Reply-To: <20110811221627.GA32005@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Thu, 11 Aug 2011 17:16:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE1C8B88-C46A-11E0-9859-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179150>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Maybe
>> --cached could have an alias like --index-only for things to be more
>> intuitive as well.
>> 
>> `git rm --index-only somefile` is more understandable than `git rm
>> --cached somefile` imho.
>> 
>> Also, in ls-files, --stage could maybe use an alias like --contents
>> for it to be more self-explanatory.
>
> These suggestions also seem sane.

The --index-only synonym was throwed around in a handful of discussions in
the past. It probably would not hurt, I would say.

I do not think "ls-files --contents" makes things any better, though.
Until a new user encounters a conflicted state, it might look like that
the primary point of "ls-files -s" is to show the object names, but it
also is important that it shows the stage numbers.
