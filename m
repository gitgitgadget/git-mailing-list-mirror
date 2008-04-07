From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in git-apply
Date: Mon, 07 Apr 2008 00:12:46 -0700
Message-ID: <7vzls6qgsx.fsf@gitster.siamese.dyndns.org>
References: <20080406235334.GA8483@diana.vm.bytemark.co.uk>
 <7vej9isc3y.fsf@gitster.siamese.dyndns.org>
 <20080407070449.GA13171@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 09:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JilY4-0003Cw-5S
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 09:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYDGHNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2008 03:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYDGHND
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 03:13:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbYDGHND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 03:13:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77318977F;
	Mon,  7 Apr 2008 03:12:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E5487977E; Mon,  7 Apr 2008 03:12:55 -0400 (EDT)
In-Reply-To: <20080407070449.GA13171@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Mon, 7 Apr 2008 09:04:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78951>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-04-06 18:11:13 -0700, Junio C Hamano wrote:
>
>> How about doing this?
>
> Well, it does fix the stgit test suite failure, so I'm all for it!
> (Though I see you've already pushed it to master.) Thanks.

This actually is a fix for maint; even though your test case does not
let you observe the breakage directly, only because must-match-at-end
check prevents the single-liner test hunk from applying cleanly.
