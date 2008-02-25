From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin-fsck: reports missing parent commits
Date: Sun, 24 Feb 2008 23:24:55 -0800
Message-ID: <7v7igto5vc.fsf@gitster.siamese.dyndns.org>
References: <12038867362489-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7vlk59pwaj.fsf@gitster.siamese.dyndns.org>
 <20080225071642.GA15761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Feb 25 08:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTXif-0001t4-WE
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYBYHZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 02:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbYBYHZN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:25:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYBYHZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:25:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AD0F13DF;
	Mon, 25 Feb 2008 02:25:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2E97C13DE; Mon, 25 Feb 2008 02:25:03 -0500 (EST)
In-Reply-To: <20080225071642.GA15761@auto.tuwien.ac.at> (Martin Koegler's
 message of "Mon, 25 Feb 2008 08:16:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74999>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Sun, Feb 24, 2008 at 07:08:52PM -0800, Junio C Hamano wrote:
> ...
>> So I am not sure what problems in the repository objects these
>> new checks are designed to catch.
>> 
>> This needs a lot of explanation than what's in your commit log
>> message.
>
> If we have already parsed a non-commit object and parse_commit_buffer
> hits such a sha1 in a parent line, it simply drops it (same for grafts).
>
> I hope that you agree with me, that fsck should catch such an error.

See?  That's exactly my point.

You would need to _explain that_ in your commit log message.
Who on the list other than you noticed that it is what you are
checking?
