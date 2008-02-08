From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Make use of the $git_dir variable at sub git_get_project_url_list
Date: Thu, 07 Feb 2008 22:21:04 -0800
Message-ID: <7vbq6sm0j3.fsf@gitster.siamese.dyndns.org>
References: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br>
	<m3ve51511t.fsf@localhost.localdomain>
	<20080208041542.GA28336@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNMcj-0005wL-Is
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 07:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbYBHGVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 01:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYBHGVU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 01:21:20 -0500
Received: from rune.pobox.com ([208.210.124.79]:53606 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYBHGVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 01:21:19 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 31127195494;
	Fri,  8 Feb 2008 01:21:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id F40C1194EC8;
	Fri,  8 Feb 2008 01:21:33 -0500 (EST)
In-Reply-To: <20080208041542.GA28336@c3sl.ufpr.br> (Bruno Cesar Ribas's
	message of "Fri, 8 Feb 2008 02:15:42 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73042>

Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:

> Just Remembering
>
> On Wed, Feb 06, 2008 at 11:37:51AM -0800, Jakub Narebski wrote:
>> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
>><snip> 
>> Good catch (although it wasn't actually a bug).
>
> Not a bug but makes the code cleaner =)

I think I saw very similar 's|projectroot/$path|$git_dir|' patch
recently.  If there are more of the same, I'd rather see all of
them in a single patch.
