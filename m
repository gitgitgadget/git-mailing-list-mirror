From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible --remove-empty bug
Date: Sat, 18 Mar 2006 08:36:44 +0100
Message-ID: <e5bfff550603172336s58156db7wb547817c74ceb456@mail.gmail.com>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
	 <7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
	 <7vlkvfw3px.fsf@assigned-by-dhcp.cox.net>
	 <7v4q22ucio.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0603131058270.3618@g5.osdl.org>
	 <e5bfff550603170257u21ee6583jabe5a6409cc40766@mail.gmail.com>
	 <7vbqw4z25v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Mar 18 08:37:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKVzd-0003yM-T6
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 08:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWCRHgq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 02:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWCRHgq
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 02:36:46 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:30287 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932275AbWCRHgp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 02:36:45 -0500
Received: by pproxy.gmail.com with SMTP id z74so1235939pyg
        for <git@vger.kernel.org>; Fri, 17 Mar 2006 23:36:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vanmb5KoS2Rwwdb1kW25DFFcsb6AlhD33qdF7zde2nXiVrMybGpyO8/FKpHLqmJC7d3q1nbiKFrGszUiZzefamW3tOiKm/14SUpM4gN3IDaLFKEKFylGEGlqHRS5FfRRBRYMr4Rfybe4nefTQQrIRsBUTLPSl4wvbqy10xvUbGQ=
Received: by 10.64.193.9 with SMTP id q9mr990081qbf;
        Fri, 17 Mar 2006 23:36:44 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Fri, 17 Mar 2006 23:36:44 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vbqw4z25v.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17690>

On 3/18/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> >
> > In case of a rather recent file --remove-empty option gives a good
> > speed up in history loading with git-rev-list. So qgit uses that
> > option.
>
> So you _do_ use it, and I think I still have that remove-empty
> stuff held back in "next" branch.  Should I unleash it?
>
>

Yes please.
