From: Aubrey <aubreylee@gmail.com>
Subject: Re: Quick question: how to generate a patch?
Date: Tue, 28 Feb 2006 09:55:40 +0800
Message-ID: <6d6a94c50602271755v41e0d31ch25892192547003a9@mail.gmail.com>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
	 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
	 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
	 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
	 <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
	 <44033241.6070001@op5.se>
	 <Pine.LNX.4.64.0602270923120.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 02:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDu5Y-0001PH-KR
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 02:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWB1Bzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 20:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbWB1Bzl
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 20:55:41 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:2763 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751607AbWB1Bzl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 20:55:41 -0500
Received: by zproxy.gmail.com with SMTP id 18so1121060nzp
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 17:55:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cSIFSwExOH446YatY0L7KIX1YVtrQI8oSxrN7p6ATI7Ehb0bTlN4rfl3p4I8w0EFsxdhGdAHHUH7i2ZoYzOHzqtAzZE0NgoAiDsVGI3GHvVqwIJ04M2uM9OUd3uYweA8aGWeExvZfoQPIEBhue/n6L8ML0WMnWJpZs+Zr+7JBBs=
Received: by 10.65.97.16 with SMTP id z16mr202984qbl;
        Mon, 27 Feb 2006 17:55:40 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Mon, 27 Feb 2006 17:55:40 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602270923120.22647@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16906>

On 2/28/06, Linus Torvalds <torvalds@osdl.org> wrote:
> I could well imagine that we still have some bug like that (ctime in
> particular is much less used than mtime, and thus more likely to have not
> been noticed). And it could be much worse on some less-commonly-used and
> less-unixy networked filesystem like smb, which is why I was wondering
> what OS version and filesystem Aubrey might be using.

I'm using suse9.3. The filesystem is EXT3.
I think I forgot one thing last night. When I changed the file, I
compiled the package to verify my modification. It should be the
reason. But should it really affect the result of "git diff"?

Thanks,
-Aubrey
