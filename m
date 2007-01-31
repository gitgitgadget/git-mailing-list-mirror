From: "Mike Coleman" <tutufan@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Wed, 31 Jan 2007 01:11:37 -0600
Message-ID: <3c6c07c20701302311w38b3dbdfs553c089505516fd0@mail.gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	 <7v8xfkz8oj.fsf@assigned-by-dhcp.cox.net>
	 <3c6c07c20701301938u4d1503a2m3e0af51121b8e6db@mail.gmail.com>
	 <Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 08:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC9d8-0007SH-S8
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 08:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbXAaHLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 02:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbXAaHLk
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 02:11:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:51035 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932806AbXAaHLj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 02:11:39 -0500
Received: by nf-out-0910.google.com with SMTP id o25so460417nfa
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 23:11:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=krlocAsdaVj2qzy9fCnChLQcC5MDPncFt/3Zs7kFSaqyOdlWRUebvyNf87C/wsBlhIf+MNx9tZkKSrjoLkt7AgKKMjdF3fmZZxIk6sKpMiq4jFVEYp0D8U4qqF9SMCCmugjFFluL+/NL/zpMGB7jpFYNdHj4rcrFWiRp3pysicA=
Received: by 10.49.8.16 with SMTP id l16mr1944808nfi.1170227497240;
        Tue, 30 Jan 2007 23:11:37 -0800 (PST)
Received: by 10.48.246.15 with HTTP; Tue, 30 Jan 2007 23:11:37 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701302029460.3611@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38231>

On 1/30/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> But I'll admit - my main reason going with C is (a) it's what I know and
> (b) I absolutely _hate_ being constrained by the language. The great thing
> about C (still) is that you can do *anything* in it. You're literally
> limited by hardware, and by your own abilities. Nothing else.

I have a lot of sympathy for this way of thinking, and maybe even a
little envy of people who've found worthy things to do at this level.

But I'm also very lazy (and probably not that talented).  So, I count
myself lucky that I've found a niche in the age of Python/Ruby/etc and
Moore's Law.  I turn programs around quickly, telling users "come back
if you need it to go faster", at which point I would profile and drop
to C, or even assembler.  But they never do--they just want the next
program.

Mike
