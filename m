From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: read the dcommit url from the config file on a
 per remote basis
Date: Mon, 23 Feb 2009 15:06:58 -0800
Message-ID: <7vbpssu50t.fsf@gitster.siamese.dyndns.org>
References: <200902191930.10139.kumbayo84@arcor.de>
 <200902222241.56223.kumbayo84@arcor.de>
 <20090223020545.GE26706@dcvr.yhbt.net>
 <200902231202.54054.kumbayo84@arcor.de>
 <20090223224516.GB32193@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 00:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbjue-00022e-7L
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 00:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbZBWXHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 18:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbZBWXHI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 18:07:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZBWXHG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 18:07:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 92E492B497;
	Mon, 23 Feb 2009 18:07:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 738E82BC70; Mon,
 23 Feb 2009 18:07:00 -0500 (EST)
In-Reply-To: <20090223224516.GB32193@dcvr.yhbt.net> (Eric Wong's message of
 "Mon, 23 Feb 2009 14:45:16 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF79B56E-01FE-11DE-842B-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111178>

Eric Wong <normalperson@yhbt.net> writes:

> Peter Oberndorfer <kumbayo84@arcor.de> wrote:
>> The commit url for dcommit is determined in the following order:
>> commandline option --commit-url
>> svn.commiturl
>> svn-remote.<name>.commiturl
>> svn-remote.<name>.url
>> 
>> Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
>
>> ---
>> Now with a short documentation for svn.commiturl.
>> I hope the wording is OK.
>
> Thanks Peter, the wording is fine.
>
> Acked and pushed out to git://git.bogomips.org/git-svn

Will pull before I'll go into the integration mode tonight for 1.6.2-rc2.
Thanks.
