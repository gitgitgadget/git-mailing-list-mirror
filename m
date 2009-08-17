From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Tue, 18 Aug 2009 00:17:04 +0200
Message-ID: <4A89D6E0.3010300@gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com> <1250525103-5184-3-git-send-email-lznuaa@gmail.com> <1250525103-5184-4-git-send-email-lznuaa@gmail.com> <1250525103-5184-5-git-send-email-lznuaa@gmail.com> <4A899495.8050902@gnu.org> <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com> <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com> <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com> <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com> <3f4fd2640908171405g46aa1d09t5169a3c8bcb1c49c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAW8-0000WQ-1b
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbZHQWRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757913AbZHQWRU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:17:20 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:56402 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZHQWRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 18:17:07 -0400
Received: by ey-out-2122.google.com with SMTP id 22so758326eye.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=fGJ1Qx3nZwFC0AsegAHvttM8zkuTNvBQqZWz9iKspSk=;
        b=mA4+5lH5mJlF1b+hnqRvp6OIIZYEwpMQOcGa7ajVTC4qbS0NGSgi3CsD+vRt3zH4qq
         uqmvuT7NrC0MrNmyK51oyfUPOKNNPSOpNKCKWVpUshMw1Bj4MK4Fz2JTeWChHfFdqvLR
         6IoQ1n6BrTxuElfTmMl/m5Qi85jdy9CcBmijE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=rP9dEUNWNP20WsGFSjCj/0SFaJxpftKDmU4FFi0D8fgr66tkDPwiTcdGBCcf/yHhkh
         zNpTn9x02MK6Q/0tbj67Zsaxg3vc++bJWR5k3WNUYlg+CHtyGaCfe70kNW41rbzy47UC
         wfeaGuNAevnEVITWIkzQHlPNFcqYVRoBIBDcQ=
Received: by 10.211.199.11 with SMTP id b11mr3869057ebq.57.1250547428274;
        Mon, 17 Aug 2009 15:17:08 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 5sm1176053eyh.56.2009.08.17.15.17.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 15:17:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Newsgroups: gmane.comp.version-control.msysgit,gmane.comp.version-control.git
In-Reply-To: <3f4fd2640908171405g46aa1d09t5169a3c8bcb1c49c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126299>

Reece Dunn schreef:

> Note that I said that people who use Visual Studio are more likely to
> build and develop things through the Visual Studio IDE. Unless there
> is IDE integration for it, they are not likely to use it.

CMake generates a .vcproj file for visual studio, so users who want to 
use the IDE let CMake generate the .vcproj file and then use the IDE to 
debug git.
There could be a batchfile like /vc_build/make_vs_files.bat or something 
to make it easy for VS users using the IDE.
