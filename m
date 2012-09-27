From: Junio C Hamano <gitster@pobox.com>
Subject: Re: DWIM .git repository discovery
Date: Thu, 27 Sep 2012 11:20:30 -0700
Message-ID: <7v7grfqqdt.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com>
 <7v7grhv2fu.fsf@alter.siamese.dyndns.org>
 <CACsJy8B5xXSrqoYX_5BW34Sq0QpP6U=E6e+prJRe_0FWf4Bz0w@mail.gmail.com>
 <CAM9Z-nkCos979Kte+k+wYKZMzo625JhWjmye2zraPKk0BgTHmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIhY-0006EJ-R6
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab2I0SUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:20:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180Ab2I0SUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:20:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FC65876B;
	Thu, 27 Sep 2012 14:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ihdWuDSenfjjhs7bYE3i3ZxCYNE=; b=MieQ1n
	zVl0bw1OsUDdv9EyxwnLRQaj5mqgzfzsQG2AZeuHUrhkfmht/R6yCtu/iW50etsG
	eN+mqDuk8zJKvVYPlXp+5HXotfgznmXpZJxqdnjQRH0ZK4ikfT8ANhqq+NPCvJQT
	UsV3qwo+EC/WkQ605PZlj31FlnnAc7U1zCynM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gv1VX8JQQ3nBGCWd6yOVTsjS6Tcp16gR
	NCTyDKdaeYq1yyXCJ3AwxV1n+NoPPlAqklVyhQhUTG1mX+J/r6Awy/dbo2TlfQM9
	KNPstYgbK5I29y8FLUJnbV5RPgwFC34wQ9UaUnxrH92k4OHwp2rZgsKi1nIL39gj
	FnUCB+18XeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DB42876A;
	Thu, 27 Sep 2012 14:20:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2D108769; Thu, 27 Sep 2012
 14:20:31 -0400 (EDT)
In-Reply-To: <CAM9Z-nkCos979Kte+k+wYKZMzo625JhWjmye2zraPKk0BgTHmw@mail.gmail.com> (Drew
 Northup's message of "Thu, 27 Sep 2012 08:22:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05B89EB4-08D0-11E2-A1FB-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206503>

Drew Northup <n1xim.email@gmail.com> writes:

>>> I think that this is a road to insanity; anybody who thinks along
>>> this line is already on the other side of the line, I would have to
>>> say ;-).
>>
>> We could go slowly and stop before being diagnosed insane. I mean the
>> trick can be opted in for a command subset where it makes sense to do
>> so.
>
> I would recommend stopping now then.

Likewise.  Didn't I already diagnose it as insane? ;-)
