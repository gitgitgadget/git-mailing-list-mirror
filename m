From: David Kastrup <dak@gnu.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 21:52:34 +0200
Message-ID: <85wstlecxp.fsf@lola.goethe.zz>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	<471476B7.5050105@users.sourceforge.net>
	<8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	<47148F72.1090602@users.sourceforge.net>
	<1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <"B2F6DB0C-4EFE-4?=
	C56-8E7A-31820320CA02"@mit.edu> <3awb7zw6.fsf@blue.sea.net>
	<alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	<1192565900.6430.16.camel@athena>
	<alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	<alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	<3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	<86sl49g1w1.fsf@lola.quinscape.zz>
	<alpine.LFD.0.9999.0710171337330.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiF3Z-0003y5-Mc
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbXJQT7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758872AbXJQT7m
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:59:42 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:36612 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064AbXJQT7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:59:42 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IiF3M-000102-Im; Wed, 17 Oct 2007 15:59:40 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4B7F61C4D4B3; Wed, 17 Oct 2007 21:52:34 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.9999.0710171337330.19446@xanadu.home> (Nicolas Pitre's message of "Wed\, 17 Oct 2007 13\:44\:39 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61422>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 17 Oct 2007, David Kastrup wrote:
>
>> Luke Lu <git@vicaya.com> writes:
>> 
>> > But I still haven't seen any compelling arguments against the "all
>> > space" case, other than "people will screw it up into mixed spaces",
>> > which is really a straw man, as many multi-platform projects
>> > enforced the all-space policy easily by using a pre-commit hook in
>> > maintainers' repository.
>> 
>> All-space indentation renders the binary delta algorithm git uses for
>> compression of packs slow and partly inoperative (all sequences of 16
>> spaces share the same finger print, and the number of identical finger
>> prints for which the file information is kept is reduced to 64).
>
> But sequences of 16 spaces are unlikely to land on 16-byte boundaries 
> all the time in the file so adjacent data to those 16-space blocks will 
> still provide good hashing.

Half of the three-tab equivalents and all of the four-tab equivalents
contain a 16-byte space sequence on the tested boundary.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
