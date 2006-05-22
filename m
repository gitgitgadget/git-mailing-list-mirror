From: Junio C Hamano <junkio@cox.net>
Subject: Re: don't accept bogus N in `HEAD~N'
Date: Mon, 22 May 2006 01:25:16 -0700
Message-ID: <7vmzdaeaab.fsf@assigned-by-dhcp.cox.net>
References: <87mzdcjqey.fsf@rho.meyering.net>
	<7v3bf3jl15.fsf@assigned-by-dhcp.cox.net>
	<87d5e7hxhl.fsf_-_@rho.meyering.net> <e4qmsn$3mv$1@sea.gmane.org>
	<87psi6h5kv.fsf@rho.meyering.net>
	<7vr72meapg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 10:25:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi5j7-0003vp-Nw
	for gcvg-git@gmane.org; Mon, 22 May 2006 10:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEVIZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 04:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWEVIZT
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 04:25:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:33992 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750701AbWEVIZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 04:25:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522082517.MXDV19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 04:25:17 -0400
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <7vr72meapg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 22 May 2006 01:16:11 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20489>

Junio C Hamano <junkio@cox.net> writes:

> Jim Meyering <jim@meyering.net> writes:
>
>> Jakub Narebski <jnareb@gmail.com> wrote:
>>
>>> Jim Meyering wrote:
>>>
>>>> It'd be better to produce a diagnostic and fail:
>
> I agree with you that we are loose in integer overlaps.  Some of

Oops; I meant overflow or wraparound.. Late night typo/thinko X-<. 
