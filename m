From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking extra
Date: Wed, 19 May 2010 19:06:56 +0200
Message-ID: <20100519170656.GA30161@pvv.org>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 19 19:07:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEmjc-0006zL-SX
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 19:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab0ESRHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 13:07:01 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:44072 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab0ESRHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 13:07:01 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OEmjQ-0003Sj-UT; Wed, 19 May 2010 19:06:56 +0200
Content-Disposition: inline
In-Reply-To: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147335>

On Wed, May 19, 2010 at 07:33:32AM -0700, Junio C Hamano wrote:

>  * (Eyvind Bernhardsen and Linus) Fixing the behaviour of crlf attribute;
>    ignoring them when core.autocrlf is not in effect was a wrong design
>    decision.
> 
>    I agree with what Linus said in the thread; I haven't yet looked at the
>    discussion in the past few days.  Also I don't know where '[PATCH v2]
>    Add "core.eol" config variable' fits in the picture.

I think this one is pretty much discussed by now, with the latest
changes this should do pretty much what Linus wanted.  Together with
the autocrlf patch, this should make CRLF handling on Windows and
mixed Linux/Windows setups a lot better!

- Finn Arne
