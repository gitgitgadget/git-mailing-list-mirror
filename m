From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] git-submodule: Make update verbose for up to date path
Date: Wed, 5 Mar 2008 00:03:12 +0800
Message-ID: <46dff0320803040803v2f93d749t6b45fc8e47e66d21@mail.gmail.com>
References: <1204642691-3220-1-git-send-email-pkufranky@gmail.com>
	 <alpine.LSU.1.00.0803041503360.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZcP-0005L9-Bv
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758544AbYCDQDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757098AbYCDQDQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:03:16 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:46418 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbYCDQDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:03:15 -0500
Received: by an-out-0708.google.com with SMTP id d31so170145and.103
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bZs2WKqd5dbnEsjeZpfUT/y7TfiKej36Gzg5H08mUBo=;
        b=mamQ7ZqofY2aO/Cc4Xf0rbCTzfNW4LV0JX93lwua3NO49RTZD5ruy9v9IWAgmK+R5pcuCZuDSlF3Rri9LyxCUbFF+ZXhVUOQpJzSfWpQm55OQzi+dszb6K5hgb+ad9xdneKhFobut4bk0G5h9SzekMqqjG7lJT9+4kzBwjnh1ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BhxhJRO+57dbQvxWOAgiHg8XWXmj32JlO5ElOroEzvLEsj8cYcXg8mvdsgx1x7tJosG7LF2nGCKsaxxz8wL4TKF0QvATBwmKuugwXyY/jMEq3rQUMhUPP5kH/TX/e5WEAGYHt1mXHo17D2a0yqzQ9OOvIDnMfsNfXRUp39k4NhM=
Received: by 10.100.93.19 with SMTP id q19mr3311227anb.13.1204646592395;
        Tue, 04 Mar 2008 08:03:12 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Tue, 4 Mar 2008 08:03:12 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803041503360.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76106>

On Tue, Mar 4, 2008 at 11:04 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Tue, 4 Mar 2008, Ping Yin wrote:
>
>  > When 'git submodule update' runs for multiple modules, give 'up to date'
>  > info for up to date modules should be a good idea to show the progress.
>
>  Does this not go contrary to our efforts to make Git less chatty?  See
>  e.g. the output of push and fetch...
>
When i run 'git submodule update' in a repository whose submodules are
all clean, there is not any output which makes me not know whether
this command are successful. I think this is not friendly.
>  Ciao,
>  Dscho
>



-- 
Ping Yin
