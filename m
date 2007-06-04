From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] cvsimport: add support for new style remote layout
Date: Mon, 04 Jun 2007 09:58:18 +0100
Message-ID: <4663D42A.7090201@shadowen.org>
References: <3a477a76f6c5396feee452678fb8110c@pinky> <7vvee4n1et.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv8OC-0003sT-Ga
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbXFDI6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXFDI6F
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:58:05 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:4159 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXFDI6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 04:58:04 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1Hv8g6-0007Sy-JM; Mon, 04 Jun 2007 10:16:42 +0100
User-Agent: Icedove 1.5.0.9 (X11/20061220)
In-Reply-To: <7vvee4n1et.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49087>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> cvsimport creates any branches found in the remote CVS repository
>> in the refs/heads namespace.  This makes sense for a repository
>> conversion.  When using git as a sane interface to a remote CVS
>> repository, that repository may well remain as the 'master'
>> respository.  In this model it makes sense to import the CVS
>> repository into the refs/remotes namespace.
>>
>> Add a new option '-r <remote>' to set the remote name for
>> this import.  When this option is specified branches are named
>> refs/remotes/<remote>/branch, with HEAD named as master matching
>> git-clone separate remotes layout.  Without branches are placed
>> ion refs/heads, with HEAD named origin as before.
> 
> Sounds good.  Docs?

Heh, yep if its something wanted then it needs docs.  Will drop a couple
of patches following this email.  The first is the documentation
updates.  The second adds a HEAD link matching git-clone behaviour, and
handily calling cvs HEAD remotes/<remote>/HEAD which seems appropriate.

-apw
