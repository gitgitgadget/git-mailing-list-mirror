From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge-friendly text-based data storage
Date: Mon, 26 Mar 2012 12:51:19 -0700
Message-ID: <7vobrjnnt4.fsf@alter.siamese.dyndns.org>
References: <CAD77+gRTv4Aq_4FLAQcD9E0p7VBD7h6hQq3CJ9Wo5DU9Zjt+Hg@mail.gmail.com>
 <7vfwcvp6pi.fsf@alter.siamese.dyndns.org>
 <CAD77+gQVDtoK0vJnSgX-+i9EeJo6QErUGuzd25_cfBmUfPvW4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFwt-000789-PG
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab2CZTvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:51:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab2CZTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:51:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 523676977;
	Mon, 26 Mar 2012 15:51:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/GnJqSi/PGL+T9LDCuiZrBT/G7c=; b=oKNrPC
	pZzjrhu0jvqv5uuv3GX+/bCO2Hoh4ptkDxvFEhzZFkGq63FFfpP7SWs4UxH8l3dj
	9DmAGiBxUDN8AmyL5myH23jLiaOs+u/P4alJHEUV4UJjUjpYUta86D5OPjKldbjE
	ytdmI5rYZq3q4FzXh8QJwbXhc0HziojjtG9y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d2aePXG9MkFWnFaNZUF2b3+w25b7A6XN
	K2m4RcKx4KjeqmnKL8OzdM62cOHf9ByxF/6SATvZs79k8FMogUNkQdmorZoIUGCV
	H5AgZTeWPwaWsWin5NbqwxlUDxpqUYFWxKOeFbB71TooqwJ5sKjZ9b7RwwT7q9/w
	Zw8aSoGDGoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1FC6975;
	Mon, 26 Mar 2012 15:51:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D147F6974; Mon, 26 Mar 2012
 15:51:20 -0400 (EDT)
In-Reply-To: <CAD77+gQVDtoK0vJnSgX-+i9EeJo6QErUGuzd25_cfBmUfPvW4g@mail.gmail.com> (Richard
 Hartmann's message of "Mon, 26 Mar 2012 21:06:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F45D602-777D-11E1-AA49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193964>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> On Mon, Mar 26, 2012 at 20:17, Junio C Hamano <gitster@pobox.com> wrote:
>
>> It may be of interest to run "git help attributes" and read up on
>> "Defining a custom merge driver" section.
>
> Sounds good, thanks.
>
> My file layout looks fine?

I have no opinion on it. It is for the consumers of your datafile (the
ones that read it and find these databasy items in it, and your custom
merge driver) to decide.
