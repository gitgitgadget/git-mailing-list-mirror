From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Fri, 22 Aug 2014 13:33:47 -0700
Message-ID: <xmqqegw8nu1g.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<53F7A119.7070704@gmail.com>
	<xmqqiolknvfz.fsf@gitster.dls.corp.google.com>
	<53F7A68D.2000109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:34:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvXE-0000fZ-EF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbaHVUeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:34:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64216 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbaHVUd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:33:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75FDC3328C;
	Fri, 22 Aug 2014 16:33:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ngFeFh8M1D92YrGNv5m22wYC7G4=; b=Xe7H+x
	NVTYw1mdRuNgM5VdPoBUuuGbdYeK6iKsC3p/pKIS4+0Ah70tTSnVkAIU9ajqlTMY
	+VH8XjkKGxyF+x3J9905sWFbVyTGcOnCHn4Bpy83yvPni5ZC6ZSVsFip/LKR9N0X
	0/aWWRJOVvVEIYwZeTFjSCxrzqNYD1fgdzPs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4sk+XqtoppUyvYevBPsy5KjC8D8T5bE
	J5AsSZ+OIQXl0g13z/Iwu9pmRyZWY6riaOuk6InZhGh5tMhUyxnqGkQwYO5BO8wW
	FU09u+J+lvZCIejE3O2tgTTULi9mvHqX3UIff5dZW9/I2QQVH3KDRdbDqqeOrDy0
	0PdSJnG9zIk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D75E3328B;
	Fri, 22 Aug 2014 16:33:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50F0433283;
	Fri, 22 Aug 2014 16:33:49 -0400 (EDT)
In-Reply-To: <53F7A68D.2000109@gmail.com> (Stefan Beller's message of "Fri, 22
	Aug 2014 22:22:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F6247A2-2A3B-11E4-84BF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255720>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 22.08.2014 22:03, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@gmail.com> writes:
>> 
>>> So there would be tags like:
>>> 	master_2014_08_21
>>> 	master_2014_08_22
>>> 	...
>>> 	maint_2014_08_13
>>> 	maint_2014_08_21
>>> and so on. Whenever there is no tag at the tip of the branch, we'd
>>> know there is something wrong.
>> 
>> Who creates that tag?
>> 
>
>> My guess would be usability as tagging so many branches is cumbersome
> for a maintainer?

Did you answer my question?  Who creates these tags?
