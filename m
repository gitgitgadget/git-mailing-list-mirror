From: sean <seanlkml@sympatico.ca>
Subject: Re: [RFC] Reverting "git push logic change"?
Date: Sun, 22 Jan 2006 16:42:50 -0500
Message-ID: <BAYC1-PASMTP0532B701820FA4ADB3C640AE110@CEZ.ICE>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
	<7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601221311530.25300@iabervon.org>
	<7vr770c8db.fsf@assigned-by-dhcp.cox.net>
	<7vu0bw9ch7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 22:48:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0n4m-000862-H1
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 22:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWAVVrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 16:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWAVVrz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 16:47:55 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:53774 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751333AbWAVVry (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 16:47:54 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 22 Jan 2006 13:47:47 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4E8EE644C23;
	Sun, 22 Jan 2006 16:47:46 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060122164250.2c7ec979.seanlkml@sympatico.ca>
In-Reply-To: <7vu0bw9ch7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 Jan 2006 21:47:47.0752 (UTC) FILETIME=[7C02C280:01C61F9D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Jan 2006 13:31:00 -0800
Junio C Hamano <junkio@cox.net> wrote:


> +If you created your shared repository by cloning from somewhere
> +else, you may have the `origin` branch.  Your developers
> +typically do not use that branch; remove it.  Otherwise, that
> +would be pushed back by the `git push origin` because your
> +developers' repository would surely have `origin` branch to keep
> +track of the shared repository, and would be counted as "exist
> +on both ends".


What about just always excluding the origin branch from being 
implicitly pushed; even if it does exist in both repositories?
In the rare cases where it is actually desired to be pushed,
it can be done explicitly.

Sean
