From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 13:11:16 +0200
Message-ID: <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	 <20070611064203.GG6073@spearce.org>
	 <alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	 <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	 <20070612135303.GT6073@spearce.org>
	 <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 13:11:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyQl4-0004Oq-3D
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 13:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543AbXFMLLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 07:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755315AbXFMLLS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 07:11:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:22248 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbXFMLLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 07:11:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so188365wah
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 04:11:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DC2EdENvGYVRK3PaqN345LcGjEzCQYFJmKwX6qZkndtZFOwNViss7bUiEqqlJahp/J065q/N9+q4xOTfKKV4O65nS1CgwZIav08nCFoe6aQ5p7zSX+agL8QDghn8QSHDogpIjxhWc9sHl/hMn4/Dvw1pVBp9j86feKvR+mUtZT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tlCPRtk6a+YFOVS5mdQJ7KBNWoKe/ajaALtcx9l+ZdUHINsWzNK/iXMO/pQpG+SU8+Jje327sO5LFPH1b1BDQ1QS5b7ZJxXQx+/cJw6SqqPi3rSLNx4ilXrBB4BstCBFOrwWuPiRQvzeoC5hqILh46yW+DCvMOLasFAL+G/sDH0=
Received: by 10.115.22.1 with SMTP id z1mr233538wai.1181733077116;
        Wed, 13 Jun 2007 04:11:17 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 13 Jun 2007 04:11:16 -0700 (PDT)
In-Reply-To: <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50045>

On 6/12/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> However, adding a new option to "git log" so that you can say
> 'git log --single-follow=$this_file_at_the_tip $branch' is a
> separate matter.  I think it is a sensible thing to do.  But
> even if we do that, I think --single-follow should limit itself
> to the rename following of "diff -M/-C" style.  It is insane to
> include another path only because the result did copy&paste only
> a handful lines out of during its history.
>

Some weeks ago I've started to experiment with git-log as a
replacement for git-rev-list (as suggested by Linus in a thread).

I found some problems and so I stopped, but I think it's time to give
it another look.

Maybe this week-end I'll do some testing.


Marco
