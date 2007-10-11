From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Thu, 11 Oct 2007 23:40:39 +0200
Message-ID: <85tzoxqqi0.fsf@lola.goethe.zz>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv>
	<470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz>
	<470DCC76.7070809@viscovery.net>
	<81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv>
	<470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz>
	<63D5CE5B-51DD-4017-B2E2-2ADC5DCBE849@steelskies.com>
	<Pine.LNX.4.64.0710112227000.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:40:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5lW-0007yY-AY
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553AbXJKVjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756342AbXJKVjx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:39:53 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36629 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856AbXJKVjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:39:52 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Ig5l1-0002Dh-4g; Thu, 11 Oct 2007 17:39:51 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 97EAA1C1F3DC; Thu, 11 Oct 2007 23:40:39 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0710112227000.4174@racer.site> (Johannes Schindelin's message of "Thu\, 11 Oct 2007 22\:31\:05 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60642>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 11 Oct 2007, Jonathan del Strother wrote:
>
>> On 11 Oct 2007, at 21:53, David Kastrup wrote:
>> 
>> > Johannes Sixt <j.sixt@viscovery.net> writes:
>> > 
>> > > Jonathan del Strother schrieb:
>> > > > How are you going to test that git works on paths with spaces if the
>> > > > test suite doesn't run there?
>> > > 
>> > > By writing a specific test?
>> > 
>> > This is going to be much less thorough.  And it does no harm if the 
>> > test scripts demonstrate defensive programming.
>
> We do not have _extensive_ tests.  We want to do some coding in
> addition to waiting for our machines to finish the test.  D'oh.

A good reason for not requiring special tests just for spaces.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
