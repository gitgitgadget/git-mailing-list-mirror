From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory leaks
Date: Fri, 26 May 2006 12:42:09 +1200
Message-ID: <46a038f90605251742p2435ae23k8bfbb98409a30c1c@mail.gmail.com>
References: <11482978883713-git-send-email-martin@catalyst.net.nz>
	 <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Martin Langhoff" <martin@catalyst.net.nz>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Fri May 26 02:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjQP8-0007hd-DO
	for gcvg-git@gmane.org; Fri, 26 May 2006 02:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWEZAmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 20:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWEZAmL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 20:42:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:39090 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965220AbWEZAmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 20:42:10 -0400
Received: by wr-out-0506.google.com with SMTP id i7so276807wra
        for <git@vger.kernel.org>; Thu, 25 May 2006 17:42:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8A7mRapdSDechBqAgMIbTwcBu/HRad1djP2JQP0YH6id5oJma1uX7zxv2paHac2dBRWuJZ+n3yodoGjX5QojapmDyWXvykUsrnjvmBmO6g7zwOymgGaqS7endCwefzJ1KB3bLlxaSQKw7FSw8y+TDzMMAIIEdTBHL53DOXuzoQ=
Received: by 10.54.116.15 with SMTP id o15mr194wrc;
        Thu, 25 May 2006 17:42:09 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 25 May 2006 17:42:09 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20774>

On 5/23/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> This stupid patch on top of yours seems to make git happier. It's
> disgusting, I know, but it just repacks things every kilo-commit.

Call me slow, but I am still running and rerunning that gentoo import. ;-)

The current import has reached ~200K commits, and .git is 450MB, while
the checked out tree is 230MB (680MB with .git). At this stage, git
repack -a -d is too memory hungry. I just had to kill it after it took
2GB and was still growing fast. So I have dropped the -a in my test
import for the time being.

Other than that, we are doing ~6K commits per hour on a 2GB 2GHz Opteron.

cheers,


martin
