From: Sergey Organov <sorganov@gmail.com>
Subject: Re: Vendor-Branch setup
Date: Wed, 08 Oct 2014 18:46:37 +0400
Message-ID: <87vbnupqk2.fsf@osv.gnss.ru>
References: <CAOHZ5L4aAT0vYfJ4g=5NmED9=nWyHS1ATf+15Y060uiz=CtkRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian Stern <adrian.stern@unchained.ch>
X-From: git-owner@vger.kernel.org Wed Oct 08 16:46:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbsVp-0007ZW-Iv
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 16:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbaJHOqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 10:46:40 -0400
Received: from mail.javad.com ([54.86.164.124]:57854 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756510AbaJHOqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 10:46:40 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 19E9761880;
	Wed,  8 Oct 2014 14:46:39 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XbsVh-0006Kr-DA; Wed, 08 Oct 2014 18:46:37 +0400
In-Reply-To: <CAOHZ5L4aAT0vYfJ4g=5NmED9=nWyHS1ATf+15Y060uiz=CtkRQ@mail.gmail.com>
	(Adrian Stern's message of "Wed, 8 Oct 2014 16:07:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adrian Stern <adrian.stern@unchained.ch> writes:

> Hi
>
> I have a Vendro-Branch setup where i store the official code in my own
> repository. Next to that i have a Delta-Branch where i store only the
> changed files different to the Vendor-Branch.

This Delta-Branch is the cause of your problems, I think. Why do you
need it at all? If you checkout it, what could you do with the result?

Instead, why don't you simply create your own branch from the root of
the vendor branch and make your own changes on this branch? That's how
it's supposed to work. Git is very efficient at storing only deltas
internally so you shouldn't care about it.

-- 
Sergey.
