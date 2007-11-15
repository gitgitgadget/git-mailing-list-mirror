From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend cat-file to take multiple arguments or read input from stdin.
Date: Wed, 14 Nov 2007 22:09:33 -0800
Message-ID: <7vd4uc82g2.fsf@gitster.siamese.dyndns.org>
References: <fhghqv$98a$1@ger.gmane.org>
	<Pine.LNX.4.64.0711150432420.4362@racer.site>
	<fhgitt$b8d$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Nov 15 07:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsXvS-0003rU-Qr
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbXKOGJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbXKOGJu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:09:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59414 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbXKOGJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:09:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CF7572F0;
	Thu, 15 Nov 2007 01:10:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5110C93E0C;
	Thu, 15 Nov 2007 01:10:07 -0500 (EST)
In-Reply-To: <fhgitt$b8d$1@ger.gmane.org> (Han-Wen Nienhuys's message of "Thu,
	15 Nov 2007 02:41:02 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65063>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> I know, and that's what I was thinking. However, I was hoping someone else 
> would pick up the hint :-)
>
> I suppose fast-export would just be cat-file with a different name and  
> slightly saner interface.  How about
>
>   type <sha1> <newline>
>   size <sha1> <newline>
>   dump <type> <sha1> <newline>

I wondered why that looked so familiar ;-)

	http://thread.gmane.org/gmane.comp.version-control.git/62295/focus=62441

Adam Roben CC'ed.
