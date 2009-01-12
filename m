From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Sun, 11 Jan 2009 20:03:05 -0800
Message-ID: <7viqolkw7a.fsf@gitster.siamese.dyndns.org>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
 <A40F4753-A81B-43FD-B1A5-B28B627F8BBD@marzelpan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcel Koeppen <lists@marzelpan.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 05:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LME2V-0000VU-Eu
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 05:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbZALEDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 23:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbZALEDM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 23:03:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbZALEDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 23:03:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 16ED08F726;
	Sun, 11 Jan 2009 23:03:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 41D768F724; Sun,
 11 Jan 2009 23:03:07 -0500 (EST)
In-Reply-To: <A40F4753-A81B-43FD-B1A5-B28B627F8BBD@marzelpan.de> (Marcel
 Koeppen's message of "Mon, 12 Jan 2009 02:58:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ECD2FADC-E05D-11DD-A3AA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105287>

Marcel Koeppen <lists@marzelpan.de> writes:

> Hi,
>
> Am 11.01.2009 um 10:51 schrieb Junio C Hamano:
>
>> ----------------------------------------------------------------
>> [Will merge to "master" soon]
>
>> * mc/cd-p-pwd (Tue Dec 30 07:10:24 2008 -0800) 1 commit
>> + git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on
>>   OS X
>
> I think this belongs into maint - without it the testsuite fails on OSX.

One step at a time.

I did fork the topic at v1.6.1 so that after it proves itself in next and
then in master it can go to maint.
