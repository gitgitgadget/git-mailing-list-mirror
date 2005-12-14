From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-am support for naked email messages (take 2)
Date: Wed, 14 Dec 2005 21:38:54 +1300
Message-ID: <46a038f90512140038j606642d0x29633be4fa21829f@mail.gmail.com>
References: <439FBE1B.4050601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 09:40:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmSA7-0006cG-B5
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 09:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVLNIi4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 03:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVLNIi4
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 03:38:56 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:19911 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932131AbVLNIiz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 03:38:55 -0500
Received: by wproxy.gmail.com with SMTP id 57so56641wri
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 00:38:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DS7U3m91jIzR0O4ZWAzsbrldz/ZqWN4DsWcPARRXB4xoN2mBW8A/sgaQayXoqNd7KGuXiYF9TG1LhIOnPAFHeXQXA4mIRRJY8wBwErWoj9sF1VHJN3odGP+iOlGLLZQbs1Uwmb/RpV731xdAfAonLmh1FP3Ku9UA/ChhM7ejbhI=
Received: by 10.54.67.19 with SMTP id p19mr390674wra;
        Wed, 14 Dec 2005 00:38:54 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Wed, 14 Dec 2005 00:38:54 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <439FBE1B.4050601@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13622>

On 12/14/05, H. Peter Anvin <hpa@zytor.com> wrote:
> This allows git-am to accept single-message files as well as mboxes.
> Unlike the previous version, this one doesn't need to be explicitly told
> which one it is; rather, it looks to see if the first line is a From
> line and uses it to select mbox mode or not.

Yes, please. These changes to git-am/git-mailsplit are very welcome by
those that don't use mbox-based MUAs. The whole workflow if git-am is
really trying if you are IMAP or Gmail/webmail based.

BTW, I recently had a go at using a Perl Gmail library to fetch
messages with a particular label into an mbox, but the library didn't
work, and I don't want to be chasing the taillights of gmails internal
API. If the python Gmail library works better, I may have a go at
learning python ;-)

cheers,


martin
