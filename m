From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] convert object type handling from a string to a number
Date: Tue, 27 Feb 2007 02:53:54 -0800
Message-ID: <7v8xejhnwd.fsf@assigned-by-dhcp.cox.net>
References: <11725197603476-git-send-email-nico@cam.org>
	<1172519760216-git-send-email-nico@cam.org>
	<11725197613482-git-send-email-nico@cam.org>
	<11725197622423-git-send-email-nico@cam.org>
	<11725197633144-git-send-email-nico@cam.org>
	<11725197632516-git-send-email-nico@cam.org>
	<7vejobhor2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 11:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLzy3-0007SX-Se
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 11:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030584AbXB0Kx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 05:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbXB0Kx4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 05:53:56 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47756 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012AbXB0Kx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 05:53:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227105354.JCFQ233.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 05:53:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Uatv1W0041kojtg0000000; Tue, 27 Feb 2007 05:53:55 -0500
In-Reply-To: <7vejobhor2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 27 Feb 2007 02:35:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40708>

Junio C Hamano <junkio@cox.net> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> We currently have two parallel notation for dealing with object types
>> in the code: a string and a numerical value.  One of them is obviously
>> redundent, and the most used one requires more stack space and a bunch
>> of strcmp() all over the place.
>>
>> This is an initial step for the removal of the version using a char array
>> found in object reading code paths.  The patch is unfortunately large but
>> there is no sane way to split it in smaller parts without breaking the
>> system.

Will your next step be to convert write_sha1_file() and friends?
