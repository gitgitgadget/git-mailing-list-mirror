From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v8 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Fri, 20 Apr 2012 15:56:34 -0400
Message-ID: <20120420195634.GE15966@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-1-git-send-email-nhorman@tuxdriver.com>
 <1334932577-31232-3-git-send-email-nhorman@tuxdriver.com>
 <xmqqvckumcoq.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLJwo-0002Jh-8U
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 21:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab2DTT4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 15:56:45 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:44581 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab2DTT4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 15:56:44 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SLJwa-0003YS-46; Fri, 20 Apr 2012 15:56:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvckumcoq.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196015>

On Fri, Apr 20, 2012 at 12:21:41PM -0700, Junio C Hamano wrote:
> Looks good, modulo perhaps these fixes on top.
> 
>  - It would be better to say "dropped" to stress that we inspect and
>    actively discard, instead of saying "ignored".
> 
>  - There is no need to use "changeset", the term glossary even
>    discourages, to make sense of the sentence.
> 
>  - There was still a stray keep_if_made_empty.
> 
>  - s/Add keep/add keep/ on the title as well.
> 
> No need to resend, unless you have fixes other than the following does.
> 
Nope I'm good, if you can work those changes in.  Thanks!
Neil

> 
