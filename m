From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn should default to --repack
Date: Fri, 18 Jan 2008 12:44:08 -0800
Message-ID: <7vfxwudftz.fsf@gitster.siamese.dyndns.org>
References: <96C7A3A5-D750-43AB-A8A6-8A3A6D09AF4E@sb.org>
	<20080118155607.GA21236@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFy5V-00065x-C5
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 21:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763536AbYARUoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 15:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759664AbYARUoY
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:44:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759988AbYARUoX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2008 15:44:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E157B5B;
	Fri, 18 Jan 2008 15:44:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 856E37B5A;
	Fri, 18 Jan 2008 15:44:15 -0500 (EST)
In-Reply-To: <20080118155607.GA21236@diana.vm.bytemark.co.uk> (Karl
	=?utf-8?Q?Hasselstr=C3=B6m's?= message of "Fri, 18 Jan 2008 16:56:07
 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71060>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-01-18 07:17:55 -0500, Kevin Ballard wrote:
>
>> I was very surprised to find that git-svn does not in fact default
>> to --repack. I firmly believe it should.
>
> I believe so too. And nowadays there's "git gc --auto", which was mad=
e
> for occasions such as this, so it should be a breeze to implement. Th=
e
> overhead might be low enough that it can be called after _every_
> imported revision.

Careful.  I made the same mistake and it had to be corrected
with e0cd252eb0ba6453acd64762625b004aa4cc162b.

"gc --auto" after every 1000 or so feels like a good default and
I would agree that would be a real fix to a real usability bug.

Patches?
