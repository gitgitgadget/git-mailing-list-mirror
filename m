From: "Duncan Mak" <duncan@a-chinaman.com>
Subject: Re: [PATCH] fix vc git
Date: Fri, 22 Dec 2006 10:17:55 -0500
Message-ID: <8e745ecf0612220717v5c7b3a02v55b36f865278ea9c@mail.gmail.com>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	 <emdr6v$9ma$1@sea.gmane.org>
	 <8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
	 <7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
	 <8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
	 <87ejqsumu3.fsf@wine.dyndns.org>
	 <8e745ecf0612220451v367479dq13af2d829a9547c2@mail.gmail.com>
	 <87ac1guj9c.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 16:18:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxm9o-0003eu-FN
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 16:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWLVPR5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945908AbWLVPR5
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 10:17:57 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:41313 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945906AbWLVPR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 10:17:56 -0500
Received: by wr-out-0506.google.com with SMTP id 71so33541wri
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 07:17:55 -0800 (PST)
Received: by 10.78.160.2 with SMTP id i2mr1274730hue.1166800675278;
        Fri, 22 Dec 2006 07:17:55 -0800 (PST)
Received: by 10.78.172.10 with HTTP; Fri, 22 Dec 2006 07:17:55 -0800 (PST)
To: "Alexandre Julliard" <julliard@winehq.org>
In-Reply-To: <87ac1guj9c.fsf@wine.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35180>

On 12/22/06, Alexandre Julliard <julliard@winehq.org> wrote:
>
> OK, but in that case vc-git-registered needs to return failure, you
> cannot call git-ls-files as it may find the file in the wrong
> directory. I'd suggest something like this:
>

Ah, okay. I agree, that is a better patch.

Would you be committing it  soon?

Thanks,

Duncan.
