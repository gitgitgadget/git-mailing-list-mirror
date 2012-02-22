From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: how do you review auto-resolved files
Date: Wed, 22 Feb 2012 16:24:58 +0100
Message-ID: <4F4508CA.9050707@in.waw.pl>
References: <ji0vik$e48$1@dough.gmane.org> <7vhayjga0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 16:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0E48-0007Yx-2w
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 16:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab2BVPZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 10:25:07 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55022 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259Ab2BVPZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 10:25:06 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S0E40-0008U6-B7; Wed, 22 Feb 2012 16:25:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vhayjga0a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191260>

On 02/21/2012 10:19 PM, Junio C Hamano wrote:
> Imagine that you are the maintainer of the mainline and are reviewing the
> work made on a side branch that you just merged, but pretend that the
> contribution came as a patch instead.  How would you assess the damage to
> your mainline?
>
> You would use "git show --first-parent $commit" for that.
Hi,
it seems that git show --first-parent is not documented in the man page.
This option is only documented for rev-list and log. I think that
- this example should land in Examples in git-show.txt
- --first-parent should be documented in git-show.txt because it (at 
least to me, but I guess that for other people also) it isn't 
immediately obvious that it means to _diff_ with the first parent.

--
Zbyszek
