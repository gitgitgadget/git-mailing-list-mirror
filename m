From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: close the edit for propedits even with no
 mods
Date: Mon, 05 Dec 2011 21:03:56 -0800
Message-ID: <7v4nxei94z.fsf@alter.siamese.dyndns.org>
References: <1322707047-24227-1-git-send-email-stevenrwalter@gmail.com>
 <20111206011036.GA26704@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 06:04:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXnCF-0001gP-FN
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 06:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831Ab1LFFD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 00:03:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab1LFFD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 00:03:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7611A7461;
	Tue,  6 Dec 2011 00:03:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KBucg9tPe/TGff7vE3a/lP13jSo=; b=JAbqx7
	Tkr9DCC71t6LVhhr09dlcDQUIEYf1Ve3p+QLbIuEL0XLoIrDMMhb+SP4aISuWrqT
	my1yMzXLTzP83M+Ia391SKM3WlcMQ7h/ZW0XO2IrZ/TFaq5ht9tN5VYYRnOWemm3
	O0OxDzrfHjitL5DDPb6SWk+dRf/dz9xI4PlLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yhHdTFhO5MP9hpSxRAfOXDSil1aDyNhX
	+Br/GO6R0QDwG7NC80quR8z0WNczcqgRCvW1UjTGwmsvUHvtswEwArojHxOcZow+
	AvTC99ZNSXjoNJct+b2aqHY5u3f/w6cLra74olMHYAWzhJ9BnD9P9p1xFUmfh2cK
	BzbnuiVGCXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D73F7460;
	Tue,  6 Dec 2011 00:03:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD135745F; Tue,  6 Dec 2011
 00:03:57 -0500 (EST)
In-Reply-To: <20111206011036.GA26704@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 5 Dec 2011 17:10:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B425EAE4-1FC7-11E1-ACC7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186314>

Eric Wong <normalperson@yhbt.net> writes:

> Steven Walter <stevenrwalter@gmail.com> wrote:
>> It's legitimate to update the mergeinfo property without
>> actually changing any files.  This can happen when changes are
>> backported to a branch, and then that branch is merged back
>> into mainline.  We still want to record the updated mergeinfo
>> for book-keeping.
>> 
>> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
> Pushed to "master" of git://bogomips.org/git-svn.git
>
> (Btw, you got my email address wrong in the Cc:)

Pulled. Thanks.
