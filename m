From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Mon, 2 Jun 2008 09:18:09 +0100
Message-ID: <1096648c0806020118i1d990affn17af29651e60b13b@mail.gmail.com>
References: <1096648c0806010828yf4f07ebt3f758f41cab5cdfd@mail.gmail.com>
	 <20080601220410.GD29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 10:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K35GC-0001NA-9i
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 10:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbYFBISP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 04:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758530AbYFBISN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 04:18:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:62314 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbYFBISL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 04:18:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so677586fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 01:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gOLtivDlWxUmAQfVSJalQmTKLcTLEAgOJkyQNHtxBMU=;
        b=qmcngm7rz0rjglbCE/nqVbVA/5aAzxX6Lx9GrDbLajP9d/xP6fSpVqcObV21OKGeL3QCRR9nTXlaeQHefMlUyKtVHbyP1A9LfU7jTNW/DUbPJ+KQ7Uh0pIgVMujR0pswgIujgFaEC7f7no8J/F58Mohm28XIey0r61i2vY7UXEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B/cV38EDJLCGdrNOxrRoYSJNzCuSVQZnSgVEiZBizbiHJ8EuM0kGM8fPlrSmgkV4UjT3wkEH9ILjq7Wj9WdxNuiENxIv9dd54/DwqMesFKaEEM/NOPJ5CGdTVlcGatQ7JWUBTd9hgzV/Tv2rAsEhOvp/sgwLQhk5Nrs/IruGm/4=
Received: by 10.82.175.17 with SMTP id x17mr104518bue.0.1212394689414;
        Mon, 02 Jun 2008 01:18:09 -0700 (PDT)
Received: by 10.82.159.3 with HTTP; Mon, 2 Jun 2008 01:18:09 -0700 (PDT)
In-Reply-To: <20080601220410.GD29404@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83502>

2008/6/1 Miklos Vajna <vmiklos@frugalware.org>:
> On Sun, Jun 01, 2008 at 04:28:44PM +0100, Rob Shearman <robertshearman@gmail.com> wrote:
>> +     setup_git_directory_gently( NULL );
>>       git_config(git_imap_config, NULL);
>
> I know this is just about cosmetics, but the style of the rest of the
> code would suggest using
>
>        setup_git_directory_gently(NULL);
>
> not
>
>        setup_git_directory_gently( NULL );

This isn't my normal coding style - I was trying to match the coding
style to the rest of the file. Only the subsequent line to my added
line uses the "func(arg)" style instead of the "func( arg )" style and
that line was changed to the former very recently.

A patch to fix the style of the call to git_config could be done
separately to this one.

-- 
Rob Shearman
