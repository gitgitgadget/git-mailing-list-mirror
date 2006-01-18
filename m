From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Cogito wishlist: ability to set merge strategy
Date: Thu, 19 Jan 2006 09:14:24 +1300
Message-ID: <46a038f90601181214m54318d89we505c130e4f397e2@mail.gmail.com>
References: <43CE5666.90502@itaapy.com> <43CE75F0.4060009@op5.se>
	 <7vlkxdwhs6.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90601181006u40a1f8e1n47c27651a4cab3d@mail.gmail.com>
	 <43CC64AD.30606@zytor.com> <20060118193201.GV28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 18 21:15:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzJhe-0006w2-2l
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 21:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWARUO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 15:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWARUO2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 15:14:28 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:55468 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030410AbWARUO1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 15:14:27 -0500
Received: by wproxy.gmail.com with SMTP id 70so28839wra
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 12:14:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dSB/Za+n9ePdt6/SMS8UL43QCzk7+NtGf92qUlJIuhTaoCBMrfylznsWYPRUmwo5tbW8HexHwpIQSg7wcCoMCZR+fSOBSKeXDTTM8qGRTqKAvTXFIy5LguxqlaJvU1LIiEP6AQvF1NbxaiyBaZWFS1AHjDxsyOSCPSkpfRt8iAY=
Received: by 10.54.98.15 with SMTP id v15mr9711577wrb;
        Wed, 18 Jan 2006 12:14:25 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Wed, 18 Jan 2006 12:14:24 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060118193201.GV28365@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14865>

On 1/19/06, Petr Baudis <pasky@suse.cz> wrote:
> though. From the Git merge strategies, I guess only recursive is
> useful for Cogito...

I haven't had time to figure out where the problem is, I do have some
cases where git-merge does the right thing, and cg-merge gets it
wrong. And without renames.

An example from yesterday:
http://locke.catalyst.net.nz/gitweb?p=moodle.git;a=commit;h=b69d60a5141dfe22a073dd9931e6c8ff5dded0b9

(the repo is accessble via http://locke.catalyst.net.nz/git/moodle.org
if anyone is interested)

> Patches welcome.  ;-)

I know I promised patches in that direction, but I haven't had the
time to look into it. Sorry! (and, as a user, I just cheat and fall
back to git-merge)

cheers,


martin
