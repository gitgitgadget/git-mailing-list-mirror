From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] new test from the submodule chapter of the user manual
Date: Thu, 20 Sep 2007 14:35:20 -0700
Message-ID: <7vd4wdkokn.fsf@gitster.siamese.dyndns.org>
References: <20070920003413.GJ16235@genesis.frugalware.org>
	<7v1wcum0ox.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709201133590.28395@racer.site>
	<20070920170831.GQ16235@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTgR-0000Yp-34
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbXITVfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbXITVfc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:35:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49671 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbXITVfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:35:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F37FE138DB2;
	Thu, 20 Sep 2007 17:35:47 -0400 (EDT)
In-Reply-To: <20070920170831.GQ16235@genesis.frugalware.org> (Miklos Vajna's
	message of "Thu, 20 Sep 2007 19:08:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58806>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Thu, Sep 20, 2007 at 11:34:25AM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 19 Sep 2007, Junio C Hamano wrote:
>> > Looks Ok to me, although I didn't verify the examples by
>> > actually running them myself this time (last round I did).
>>
>> So maybe we should do the same as with the tutorial: stick the examples
>> into a test script?
>
> what about this?

Far too inadequate.  You test if "commit" reports success, but
do not check if what is committed is what you wanted to commit,
for example.
