From: Bill Yoder <byoder@cs.utexas.edu>
Subject: Re: 1.3.2 git-clone segfaults
Date: Wed, 17 May 2006 14:27:09 -0500
Message-ID: <1871789F-06D0-423F-A87D-1BFF9E0FC8E1@cs.utexas.edu>
References: <879BAFDD-87DB-4041-8753-5D63630076B5@cs.utexas.edu> <7vwtckcwve.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Wolfgang Denk <wd@denx.de>
X-From: git-owner@vger.kernel.org Wed May 17 21:27:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRfw-0004A1-2F
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWEQT1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWEQT1N
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:27:13 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:963 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751022AbWEQT1M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:27:12 -0400
Received: from [128.83.122.182] (helo=[128.83.122.182])
	by elasmtp-banded.atl.sa.earthlink.net with asmtp (Exim 4.34)
	id 1FgRfr-0003Gf-Ga; Wed, 17 May 2006 15:27:11 -0400
In-Reply-To: <7vwtckcwve.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.750)
X-ELNK-Trace: 9592836211a6d0db1058e01f90253df340683398e744b8a4222fdd9b867a9d3d5a93c5825aac4637a7ce0e8f8d31aa3f350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 128.83.122.182
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20230>

Dear Junio (and Fernando):

> Could you try 1.3.3?

Here are the last few lines of output from 1.3.3, cooked with gcc 3.2.3:

Getting alternates list for http://www.denx.de/git/linux-2.6-denx.git/
got b603ba9e9b5482d3e80fc8e0fa96bb9a943502ff
got 1635ee25918fc19ea613d1e8dbcb672075220efb
got dd7d627bf66f306b4ee9401f06ed4fb574896a85
got c771a7db9871bfa3f3c76b78c1369111c4be767b
got 374e20ad8b0d02f15fbcaa5315e272eabd6c4f76
got a8bef1d1371cc999ce6882d355c7554ca7738173
got ab08f35cbc355f4b2058d88ff289552f202ea5b4
Getting pack list for http://www.denx.de/git/linux-2.6-denx.git/
got 92297ff24e8525de2617dff728b3420a4649f66a
got 93dcbe1abb4c83b65cc6af59fb84c3c5e16effbb
got 41ecbb847f32f301a7ecd30b6438fea702886a33
got 94f557fa46369ec94ec718d25616ceb0b73fd2d2
got 09e00433c78e267b37b3f485c0d877de780a0674
got da7c09e4ede6e83198bf1ab5f16c571b0cc214ee
got 85533ec5aaa17f4146452a16ef61ca40fc601c80
got 50e338d2ffda9cb5a835d67849e38ae0ceba1647
/usr/local/downloads/git-1.3.3/git-clone: line 323:  1124  
Segmentation fault      git-http-fetch -v -a -w "$tname" "$name" "$1/"

Regards,
Bill
