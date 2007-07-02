From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Tue, 03 Jul 2007 09:32:34 +1200
Message-ID: <46896EF2.70006@vilain.net>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:32:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5TVt-00077z-JQ
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbXGBVcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbXGBVcm
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:32:42 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39150 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbXGBVcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 17:32:42 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 07DFB13A4EA; Tue,  3 Jul 2007 09:32:39 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 64ED913A3E1;
	Tue,  3 Jul 2007 09:32:36 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <20070702020401.GD28917@thunk.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51410>

Theodore Tso wrote:
> After looking at ediff, it is definitely the more polished and
> featureful compared to emerge --- except in one critical area, which
> is calling as a mergeing tool from a shell script or command line.
  [...]
> 	emacs --eval "(ediff-merge-files-with-ancestor \"$LOCAL\" \"$REMOTE\" \"$BASE\" nil \"$path\")"
> 
> Unfortunately, it's not enough.  Ediff doesn't have an "abort" command
> which returns a non-zero exit status, and when you use the "quit"
> command, it asks you a series of obnoxious questions:
> 
> Quit this Ediff session? (y or n)
> File /usr/projects/git/test/testfile.c exists, overwrite? (y or n)
> Merge buffer saved in /usr/projects/git/test/testfile.c
> <delay for 3 annoying seconds>
> Merge buffer saved.  Now kill the buffer? (y or n)

Yeah, I normally just save the merged buffer and quit.  This skips all that.

But I will add your little snippet to my .emacs :)

Sam.
