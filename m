From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Tue, 17 Aug 2010 18:32:06 -0500
Message-ID: <AANLkTim77g+z3KXyCOy4G-caCncyFa0FfqPMFatZnwLN@mail.gmail.com>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
 <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
 <AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com> <20100817232838.GH2221@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:32:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVdx-0000rY-9Q
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab0HQXc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:32:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53156 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0HQXc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:32:26 -0400
Received: by gyd8 with SMTP id 8so337652gyd.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=lBqJWWTWwRnvkrYSLiI6vLp0mfE2Za80Vn6f1blO178=;
        b=WmYMb8ip0ip6BA+obxa/cXIcZUiWZnVjeYPDkAS6gSG0QvqYM7UCFB/jyhZyLDNA+W
         ki6SkxouAFSk8k6j29//qIoUTpEYhmvRdTvBZkUuVT9/qYyJFAOSFVC6PPgswFGvNd/w
         NpAIylgPCVlWJgMf77DFU15MFZ83qBvUY/KAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rIv9zMun1R+Sp1Mz66EppwuN0eOLNMv6McLZX6sXBUCVYpAi9W7ngLqJkw6c+iFRcG
         GtdpkAGxgYkQo69zpzuJ1bUeYg5jSQ7xmmtSZ+G+5Y1IrimysFjxBzzA73PVE86dDWWZ
         CBhzoQsGr+N3wKEobcpkBeCX+6TnzuipTqXmQ=
Received: by 10.150.178.14 with SMTP id a14mr8121110ybf.131.1282087946133;
 Tue, 17 Aug 2010 16:32:26 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 16:32:06 -0700 (PDT)
In-Reply-To: <20100817232838.GH2221@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153790>

Heya,

On Tue, Aug 17, 2010 at 18:28, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hmm, what does your GIT-BUILD-OPTIONS say?

sverre@laptop-sverre:~/code/git$ cat GIT-BUILD-OPTIONS
SHELL_PATH='/bin/sh'
PERL_PATH='/usr/bin/perl'
TAR='tar'
NO_CURL=''
NO_PERL=''
NO_PYTHON=''

-- 
Cheers,

Sverre Rabbelier
