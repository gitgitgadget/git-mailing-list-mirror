From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Add path-limiting to git-add--interactive
Date: Thu, 22 Nov 2007 12:35:57 +0100
Message-ID: <41577A45-4DF7-4A49-9AD1-1FCBDA1D6A6E@wincent.com>
References: <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <1195695384-41329-1-git-send-email-win@wincent.com> <7vpry27id0.fsf@gitster.siamese.dyndns.org> <7vd4u27gvn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAMK-00049y-94
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbXKVLgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 06:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXKVLgM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:36:12 -0500
Received: from wincent.com ([72.3.236.74]:57357 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbXKVLgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:36:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMBZwwx012495;
	Thu, 22 Nov 2007 05:35:59 -0600
In-Reply-To: <7vd4u27gvn.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65803>

El 22/11/2007, a las 10:45, Junio C Hamano escribi=F3:

> the attached patch teaches [p]atch subcommand to take multiple
> selections.  With these, you can do:
>
> 	$ git add -i 'u*.h'
> 	What now> p
>                   staged     unstaged path
>          1:    unchanged        +1/-0 unpack-trees.h
>          2:    unchanged        +1/-0 utf8.h
>        Patch update>> *
>        diff --git a/unpack-trees.h b/unpack-trees.h
> 	...
>        Stage this hunk [y/n/a/d/?]? y
>        ...
> 	diff --git a/utf8.h b/utf8.h
>        ...
>
> -- >8 --

Nice usability improvement.

Cheers,
Wincent
