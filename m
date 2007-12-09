From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] don't mention index refreshing side effect in git-status docs
Date: Sun, 9 Dec 2007 16:16:13 +0000
Message-ID: <57518fd10712090816pa43cf97mbc1b8f5fbe81c66f@mail.gmail.com>
References: <20071209082133.GA2257@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 17:16:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1OpY-0001tZ-No
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 17:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXLIQQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 11:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbXLIQQP
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 11:16:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:15739 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXLIQQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 11:16:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1311337rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=fENsBWWI90ugAiWK+2Ypdgq72BGIkmeaoniYIyQ86NM=;
        b=G/tCsUd3LuXbzDMVdX2EpR36rQDbfgf4pbmFGsGm9F5D3DhBXgEuK6K7Ixtmfp04v5+5yo9NoatSUurLWDHPiwZvOMcofbmVd+wXIrRLqN+jeFD05VFcVYKFUzUJSsDboGQWHfBYruXm4ywFc8j+a0HuWicQm3ZWZhoaQgT716A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UZb4vLxSoipzToqc26cC5nB8kWlkAtVMG8VzNy/jTVvwCbafNOrqsPOIJ8qFl819Egdm/wn8qmH8GH4xE3u6mYMS9mqlKDKU6TN2Y9zvszlJ8VnJHR/xQKpG2u7nz3rm9Gyuq8yRm/HWoumFqyv5cHnT4AuM7tcvxZC4/4J/nKs=
Received: by 10.140.192.9 with SMTP id p9mr3704339rvf.1197216973862;
        Sun, 09 Dec 2007 08:16:13 -0800 (PST)
Received: by 10.141.211.1 with HTTP; Sun, 9 Dec 2007 08:16:13 -0800 (PST)
In-Reply-To: <20071209082133.GA2257@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 9ed85562be72b540
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67628>

On Dec 9, 2007 8:21 AM, Jeff King <peff@peff.net> wrote:
> The tip about speeding up subsequent operations is now
> obsolete; since aecbf914, git-diff now squelches empty diffs
> and performs an automatic refresh.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is on top of my other patches to the git-status docs.
>
> I don't see any reason to mention this side effect at all. Those who
> know enough to set diff.autorefreshindex presumably know what they are
> doing, and the removed paragraph is a bit confusing to those who don't.
>


...   I wasn't aware the index needed refreshing.  This might be
totally unrelated to the present conversation, but the GIT-VERSION-GEN
script occasionally gives me spurious 'dirty' results (eg when a file
timestamp changes despite the content having changed).  Should it
perhaps be running "git update-index --refresh" before it runs "git
diff-index --name-only HEAD" ?
