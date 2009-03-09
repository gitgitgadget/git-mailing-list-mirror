From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: make show_line more portable
Date: Sun, 08 Mar 2009 20:52:58 -0700
Message-ID: <7vbpsbic85.fsf@gitster.siamese.dyndns.org>
References: <1236561326-1231-1-git-send-email-benji@silverinsanity.com>
 <76718490903081922p105ebf79vb0bf06989413887c@mail.gmail.com>
 <5ACAF49A-84B5-4F55-A8B8-0FC711708810@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 04:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgWaS-0000UM-R4
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 04:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbZCIDxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 23:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZCIDxJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 23:53:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZCIDxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 23:53:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57CD3A0383;
	Sun,  8 Mar 2009 23:53:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 13A60A0382; Sun,
  8 Mar 2009 23:53:00 -0400 (EDT)
In-Reply-To: <5ACAF49A-84B5-4F55-A8B8-0FC711708810@silverinsanity.com> (Brian
 Gernhardt's message of "Sun, 8 Mar 2009 22:44:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CB805434-0C5D-11DE-AE52-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112676>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Mar 8, 2009, at 10:22 PM, Jay Soffian wrote:
>
>> On Sun, Mar 8, 2009 at 9:15 PM, Brian Gernhardt
>> <benji@silverinsanity.com> wrote:
>>> On OS X the printf specifier "%.0s" outputs the entire string instead
>>> of 0 characters as POSIX states.
>>
>> Does not reproduce for me:
>
> Nor for me, as I noted on the other thread...  And looking again, I
> was reading the man page for printf(1), not printf(3).  Ouch.
> *grumble, grumble*  I'm crawling back under my rock now.

Heh, people make mistakes and others are here to help spot them.
Collectively we all win.

Thanks for a breakage report, initial fix and a confirmation.
