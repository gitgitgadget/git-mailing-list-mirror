From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [Attn - repository browser authors] diff-tree combined format.
Date: Sat, 4 Feb 2006 13:03:34 +0100
Message-ID: <e5bfff550602040403k293b02e5sce17eecbf41c008e@mail.gmail.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	 <Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	 <Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	 <7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	 <7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	 <7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
	 <7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
	 <e5bfff550602030417w290c12b6yc4406f890acadc73@mail.gmail.com>
	 <7v1wykceic.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:03:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5M8h-0008JC-3Q
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 13:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWBDMDf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 07:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWBDMDf
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 07:03:35 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:11312 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932231AbWBDMDf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 07:03:35 -0500
Received: by wproxy.gmail.com with SMTP id i23so780446wra
        for <git@vger.kernel.org>; Sat, 04 Feb 2006 04:03:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r0vxkWTESB9Tm5D2znDW6M0j9mHHNDJNEatrzIP05G6d09geKSMVzGRW0Yrhp81Fs7eVp+bwZHCHj2gLj4gwY/Rpmrl6iakPgxUnLTWcRKW9bfyMI2hY+Z8rE5tzQiEo5UiP3b8mmTcEW2VKMkeawBpwhGsccU1SjjBrnjk/VlQ=
Received: by 10.64.153.4 with SMTP id a4mr12625qbe;
        Sat, 04 Feb 2006 04:03:34 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sat, 4 Feb 2006 04:03:34 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wykceic.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15588>

On 2/3/06, Junio C Hamano <junkio@cox.net> wrote:
> Marco Costalba <mcostalba@gmail.com> writes:
>
> This reminds me of one thing.  One thing I did not like about
> the colouring of gitk on an Octopus was that it repeats the same
> parents in different colors, wasting lines.  From diff-tree -c
> output, one thing coloured diff browsers _could_ do is to let
> the user pick one parent and paint the lines to make the
> differences from that parent alone stand out.
>

Both qgit and gitk have the 'diff to selected rev' feature.

What about integrate combined output with exsisting 'diff to selected'
functionality to reach what you are proposing?

Put in other words, an user selects the parent (CTRL + right click in
qgit) and only the
corresponding interesting diffs is shown.

For this to work it is necessary (at least in qgit) something like

   git-diff-tree -c -r -m -p <sha1> <sha2>


Marco
