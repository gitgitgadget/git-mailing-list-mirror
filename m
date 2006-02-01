From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 15:55:58 +0100
Message-ID: <81b0412b0602010655i7b538bdck2baa216203279bce@mail.gmail.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	 <1138446030.9919.112.camel@evo.keithp.com>
	 <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	 <1138529385.9919.185.camel@evo.keithp.com>
	 <43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	 <Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	 <20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	 <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ray Lehtiniemi <rayl@mail.com>, Linus Torvalds <torvalds@osdl.org>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	Keith Packard <keithp@keithp.com>,
	Junio C Hamano <junkio@cox.net>, cworth@cworth.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 15:56:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4JOx-00051m-Ex
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 15:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWBAO4E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 09:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161073AbWBAO4E
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 09:56:04 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:39847 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161072AbWBAO4B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 09:56:01 -0500
Received: by uproxy.gmail.com with SMTP id s2so256903uge
        for <git@vger.kernel.org>; Wed, 01 Feb 2006 06:56:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkeWN9lf7NJ5GZoCh3UJxWbpKqPzE/KBX+48769hvnxD0nCfZaYDlZsIV2Vn5x63wzxFP2BdqlDJQ2Zlrjw5BW+i0IRYt8A6IfeZecs8t0yga8Xg8Qffu4w0U3zwbkTZN3FFxVaphlANB0PgKYLDAcyI3zSwgPF5Z9VrWWAgSak=
Received: by 10.48.250.5 with SMTP id x5mr1699259nfh;
        Wed, 01 Feb 2006 06:55:59 -0800 (PST)
Received: by 10.49.23.15 with HTTP; Wed, 1 Feb 2006 06:55:58 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601311852ie8cfac0rbe92779edea4da1b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15416>

On 2/1/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Perhaps a local git/cygwin on NTFS  would be more reasonable to benchmark?

$ time git update-index --refresh

real    0m21.500s
user    0m0.358s
sys     0m1.406s

WinNT, NTFS, 13k files, hot cache.
