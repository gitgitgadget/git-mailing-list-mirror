From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Mon, 20 Mar 2006 07:31:03 +0100
Message-ID: <e5bfff550603192231k7843a741xbf14394bc5e4c57@mail.gmail.com>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	 <4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
	 <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
	 <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550603191340u466d3551t8a95c3808eb977c1@mail.gmail.com>
	 <7vmzfmm35t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 07:31:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLDv3-0002oA-IE
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 07:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCTGbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 01:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWCTGbF
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 01:31:05 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:38588 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbWCTGbE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 01:31:04 -0500
Received: by wproxy.gmail.com with SMTP id i11so895342wra
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 22:31:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FKfH3Dp/zExmrcsL5SwzurSR8Hvj2+TMv2ZiGyzDsY+eQIrrqz8964TwFiaoiyjU78ye2Xeu1pygmnF99X1aIdrw6dfhqZmklcPCpkwWJTb4FtSF6J/+8mOR5tAiUOZFDb5CJ2UxyL3k5pa0MGKpqajMGzn/2sJrwWN7wXG+y3w=
Received: by 10.65.20.2 with SMTP id x2mr142328qbi;
        Sun, 19 Mar 2006 22:31:03 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 22:31:03 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vmzfmm35t.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17742>

On 3/20/06, Junio C Hamano <junkio@cox.net> wrote:
>
> Your inability to produce 404 is a different matter -- often the
> hosting server is not under your control.  But that does not
> change the fact that the repository observed by your clients is
> "broken".  That is why a workaround flag like I suggested may be
> needed for such a setup.
>
> This is totally untested, but maybe something like this?
>

It works for me. Just some trailing white space warning when applying.

I didn't found a way to pass '--unreliable-404' flag from git-clone,
perhaps my bad,
I have tested forcing the flag in sources.


Marco
