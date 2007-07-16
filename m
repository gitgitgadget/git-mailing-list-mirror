From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Mon, 16 Jul 2007 11:37:22 +0200
Message-ID: <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bradford Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 11:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAN1H-0007yF-HO
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 11:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756441AbXGPJh2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756393AbXGPJh2
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 05:37:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:49883 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbXGPJh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 05:37:27 -0400
Received: by nz-out-0506.google.com with SMTP id s18so783004nze
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 02:37:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dD+82Aa/NhHsjvae335iTOe6G2x0EivaSK6Hhywb/G2h5PfBGN7IwiMvJSXkgc0VRjIGcMeQHZGhMJNLyzteDg5bmCRTkX078f4blRbh506u3OK/z9xZCB2psJDhNl102GD/unW4/6lSf8zExLcrlC68Gf5EL0LWY1uzbQK2bK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=o7/83OLGMyEEpr+a6dg2aGChejrsjL6lTBixFuL3nPDJ0WdRb0SLQ3SLplyrDdcCU1wysZZ53NC7HZ6bsJ3/Wcf98gJC3qnAiPU1ATK20JjR6y6k8VkZjzAq+Kvc3BUWNm7jwMRwCv3mQVVec/7//g6rZCbwhxweecXm7c0ocnk=
Received: by 10.114.37.1 with SMTP id k1mr4000294wak.1184578647068;
        Mon, 16 Jul 2007 02:37:27 -0700 (PDT)
Received: by 10.114.196.16 with HTTP; Mon, 16 Jul 2007 02:37:22 -0700 (PDT)
In-Reply-To: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e4829e09c2f4d176
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52653>

On 7/15/07, Bradford Smith <bradford.carl.smith@gmail.com> wrote:
> Since the number of dot-files and dot-directories that I have in my
> home directory these days is somewhat overwhelming, I like to keep
> those I directly edit all together in an ~/etc directory so I can
> easily back them up and/or copy them in bulk to new accounts.  So,
> several of my home dot-files are just symlinks to something in ~/etc,
> including ~/.gitconfig.

How about adding an environment variable telling Git where to find
user-global .gitconfig instead?

  nikolai
