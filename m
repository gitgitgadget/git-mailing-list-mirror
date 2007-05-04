From: "marc zonzon" <marc.zonzon@gmail.com>
Subject: Re: how to filter a pull
Date: Fri, 4 May 2007 15:13:22 +0200
Message-ID: <71295b5a0705040613m74215667w72db82e0bc2c1a58@mail.gmail.com>
References: <20070503131704.GA7036@kernoel.kernoel.fr>
	 <20070503150752.GB6500@xp.machine.xx>
	 <7vwszpzs33.fsf@assigned-by-dhcp.cox.net>
	 <20070504101329.GA16446@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Peter Baumann" <waste.manager@gmx.de>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 04 15:13:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjxbE-0001M0-K2
	for gcvg-git@gmane.org; Fri, 04 May 2007 15:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbXEDNNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 09:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbXEDNNZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 09:13:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:33737 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbXEDNNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2007 09:13:24 -0400
Received: by wr-out-0506.google.com with SMTP id 76so888630wra
        for <git@vger.kernel.org>; Fri, 04 May 2007 06:13:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQDnFmrJNiuw2ZSDiWuOjdhmM38nDEnmru6EP5VIqhOUxk1f3qeQQIC+NWTRCbJVtxfdSXe7lTK5jG4gYKqcZmvmv0308DBEJqi45htPjWIEjfII3Ls4whPU37koo2vP6c7/xZADlNmjLnhilGPtc/mcCArZ5lIzoAdvlMBtZ/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OmS9G3zSgL5VIqtQj2InADeH7o6QYLmXMwk0sztEvTrJPVRAa2s04YfxjHHO223b68iLXfhWAAOqXp8QrGyONK1a12ANkCmloQDANocY7izZSYITJw1zPYXZDVhTaoSbdgHgle6GxkaijLycJdis7FpS+xoD9xVWrof769Som3U=
Received: by 10.78.138.6 with SMTP id l6mr1528596hud.1178284402585;
        Fri, 04 May 2007 06:13:22 -0700 (PDT)
Received: by 10.78.33.10 with HTTP; Fri, 4 May 2007 06:13:22 -0700 (PDT)
In-Reply-To: <20070504101329.GA16446@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46178>

On 5/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:

> It should be straightforward (and efficient) to make a script that
> takes an existing branch and makes a parallel branch that contains
> only one subtree of the first branch. This derived branch can then be
> used as a subproject or whatever.
>
> Or is there some obvious reason why this wouldn't work, or would be
> inconvenient?

This was my initial idea,  pull and filter!, but of course it is
somewhat a hack, you pull inside git, and filter outside git, I don't
know how to keep history, it seems that once filtered the origin of
the subtree is lost. But I lack of git proficiency, I have no
experience wich git core and mainly have used it at the user
'porcelain' level.
I have had some hope that there is some mean to forward the internal
state recording of the database state.
The solution proposed by alex does not seem to be an option, if you
draw from many projects, you cannot host the whole trees because some
nodes are duplicates, and if they are outside your field you don't
bother of merging them.
Moreover I don't know how you mark what belongs to your small project
island, among this big ocean.

So if I have no further advice I think the wiser is to try the raw
script option, at least for the next 6 months the time to git, and my
own proficiency to ripen..

Marc
