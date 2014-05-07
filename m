From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Beginner question on "Pull is mostly evil"
Date: Wed, 07 May 2014 13:51:04 -0700
Message-ID: <xmqqeh058g93.fsf@gitster.dls.corp.google.com>
References: <0C723FEB5B4E5642B25B451BA57E2730751C2642@S1P5DAG3C.EXCHPROD.USA.NET>
	<xmqq4n119wgk.fsf@gitster.dls.corp.google.com>
	<0C723FEB5B4E5642B25B451BA57E2730751C2AB2@S1P5DAG3C.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jim Garrison <jim.garrison@nwea.org>
X-From: git-owner@vger.kernel.org Wed May 07 22:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8oA-0004sD-ER
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaEGUvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:51:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55666 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbaEGUvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:51:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 144F91647C;
	Wed,  7 May 2014 16:51:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=enhbR8FU/kYsgMdwIEQ6ReifKRU=; b=gke9MA
	ZPZj/6sYDQNbUiXqYSdjGCEeickuKkkv2CCV/Kx5UJRyNO6m/7E4qUtuVFhinbrC
	Ht5TABPeAhsnK98zrzVremDR/lGlLKGwmDVKEizyt2IvavZg5+25HPVuHY9Pw3iO
	h+pvYNOnRwej4VVm287myaae6/NqLnCvu8R2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fPhGQU0Uxyai7MAyCmx+3V9+yYOoeIQ8
	fqkvHdXlQOeY6l0sPXn982BifiBdhR10UhXCgbQ9/xbBxANA2gsFYNGCbfJ8rc8Z
	LAzl8xMV7bGbnwVBopF1q22nSrEbnqXF+dRUPXLso74YsfOtARx+ajrm8pa6XZSw
	IokoaJOURSU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 075211647B;
	Wed,  7 May 2014 16:51:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 851AF16477;
	Wed,  7 May 2014 16:51:05 -0400 (EDT)
In-Reply-To: <0C723FEB5B4E5642B25B451BA57E2730751C2AB2@S1P5DAG3C.EXCHPROD.USA.NET>
	(Jim Garrison's message of "Wed, 7 May 2014 20:30:32 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4ED109EC-D629-11E3-BA98-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248370>

Jim Garrison <jim.garrison@nwea.org> writes:

>> -----Original Message-----
>> From: Junio C Hamano
>> Sent: Wednesday, May 07, 2014 1:16 PM
>> Subject: Re: Beginner question on "Pull is mostly evil"
>> 
>> No.  This is most often true for people who use a single repository as a
>> place for everybody to meet, in the same way as SVN.
> [snip lots of excellent detail]
>> HTH.
>
> Wow.  That helps tremendously, and should be incorporated somewhere in the
> Git documentation.  Thank you for your immensely detailed response.

We used to collect useful list postings in Documentation/howto/;
perhaps somebody wants to do the minimum copyediting of the message
and send a patch?
