From: "Duncan Mak" <duncan@a-chinaman.com>
Subject: Re: [PATCH] fix vc git
Date: Fri, 22 Dec 2006 07:51:45 -0500
Message-ID: <8e745ecf0612220451v367479dq13af2d829a9547c2@mail.gmail.com>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	 <emdr6v$9ma$1@sea.gmane.org>
	 <8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
	 <7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
	 <8e745ecf0612212011q26f81d91uce143b4212fc5e8b@mail.gmail.com>
	 <87ejqsumu3.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 13:51:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjsN-000378-Ry
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbWLVMvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbWLVMvs
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:51:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:6132 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbWLVMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:51:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2968798uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 04:51:46 -0800 (PST)
Received: by 10.78.201.15 with SMTP id y15mr234274huf.1166791906012;
        Fri, 22 Dec 2006 04:51:46 -0800 (PST)
Received: by 10.78.172.10 with HTTP; Fri, 22 Dec 2006 04:51:45 -0800 (PST)
To: "Alexandre Julliard" <julliard@winehq.org>
In-Reply-To: <87ejqsumu3.fsf@wine.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35170>

On 12/22/06, Alexandre Julliard <julliard@winehq.org> wrote:
>
> Well, if it's a real file I'd expect the directory to exist, and if it
> doesn't, I'm not sure there's much point in calling git-ls-files at
> all. In which case do you get a non-existent directory here?
>

Yeah, but the issue is that, as you know, to create a new file in
emacs, you give find-file  a non-existent file and emacs will open up
a buffer for you and let you save it when you're done.

Once I installed the git vc backend, that feature stopped working for
me - that's the reason why I made this patch.

Duncan.
