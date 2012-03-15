From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to git diff files in renamed directories
Date: Thu, 15 Mar 2012 13:49:35 -0700
Message-ID: <7vbonxk2sg.fsf@alter.siamese.dyndns.org>
References: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Patrick Sabin <patrick.just4fun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 21:49:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8HcG-0007pk-29
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 21:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161512Ab2COUtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 16:49:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161383Ab2COUti (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 16:49:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3493E7817;
	Thu, 15 Mar 2012 16:49:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SlqdWiTYrVJ0lSEjIApyWRG3iW4=; b=CaLJo1
	Z9PeRhs8H3jMNVKg+/amuzg24hWridDsxaif4OtOkjk21aqKL5QXzcISdpIk3m7z
	dQdWItqNLeUlz3hjepDI605vBYo3m0jklymo3I9T1QPnnbKpK1AfGKfCXdb5KXYH
	GezQ5blhurfEhrfYtvLmZRajEr7ZYybT/F8Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JkSVPk7mRaaR/dBVowOWNki5ib//OEF+
	rHlcQKfDnNN8ioclFz2zgRzGxUgB3WoIOcq7Xqwv6c9vwRSHqvOVn4Q1ujvToIc/
	f3R5f4/uvraVXlBNmCZkjcecundXO1lpJUJnc/x92f+re1P2tAEbQX0SRUsTCOL7
	g0gm/qKrIP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B5B27815;
	Thu, 15 Mar 2012 16:49:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5B747814; Thu, 15 Mar 2012
 16:49:36 -0400 (EDT)
In-Reply-To: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com> (Patrick
 Sabin's message of "Thu, 15 Mar 2012 09:32:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60709CF6-6EE0-11E1-84E8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193224>

Patrick Sabin <patrick.just4fun@gmail.com> writes:

> I want to diff a renamed file (to a different directory) in different commits.
>
> File a was moved to the file subdir/c
>
> I tried:
>
> $ git diff b616d 0aa0 -- subdir/c a

Does

    $ git diff -M b616d 0aa0 -- subdir/c a

match them up?    
