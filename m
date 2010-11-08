From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Mon, 8 Nov 2010 13:49:44 -0800
Message-ID: <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan> <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@free.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:49:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZb8-0003TV-0z
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab0KHVts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 16:49:48 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40900 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318Ab0KHVtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 16:49:47 -0500
Received: by pwj1 with SMTP id 1so92224pwj.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 13:49:47 -0800 (PST)
Received: by 10.143.14.21 with SMTP id r21mr5088269wfi.127.1289252987341;
        Mon, 08 Nov 2010 13:49:47 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm472044wfg.20.2010.11.08.13.49.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 13:49:46 -0800 (PST)
In-Reply-To: <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160994>

On Nov 8, 2010, at 10:31 AM, Junio C Hamano wrote:

> Yann Dirson <ydirson@free.fr> writes:
> 
>> #  e, edit = use commit (if specified) but pause to amend/examine/test
> 
> When an end user is given
> 
>    pick one
>    pick two
>    pick three
>    ...
> 
> and told the above, would it be crystal clear that, if he changed the insn
> sheet to
> 
>    pick one
>    edit
>    pick three
>    ...
> 
> then he will _lose_ the change made by foo, or will the user come back
> here and complain that a precious change "two" is lost and it is git's
> fault?

On the one hand, once someone understands what the todo list is actually
doing, then it should be instantly obvious that removing the reference to
a commit will remove that commit entirely. On the other hand, I agree it
may be confusing to new git users (or new rebase users). Do you have an
alternative solution in mind?

-Kevin Ballard
