From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: Re: help with git usage
Date: Wed, 30 Apr 2008 10:22:29 +0200
Message-ID: <cac9e4380804300122v4f23251cqbc36640a07379c8@mail.gmail.com>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Quinlan" <danq@brtt.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 10:23:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr7b4-00038B-3C
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 10:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbYD3IWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 04:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbYD3IWh
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 04:22:37 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:7659 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbYD3IWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 04:22:35 -0400
Received: by hu-out-0506.google.com with SMTP id 19so479655hue.21
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 01:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rmKA3aU8W4Ozs967ck0ubSTy6zNexxfZ9xghaDr+Q8M=;
        b=kygcl4LI8aMY9b0WIqVqYnC5v73atmOdiGcVr6OTequoVRlw14R2bWpXFHsu++wh4GQmdO/kVgeQTFp1SkJ/DGqHgvRsgH1nwBfaJWqks3RgVqABxa2eA8vpDqX8B3zZKuFQauHKlM2mdzpGraAM1GFTiMGBJ4FPgXeoPY2ZDto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bb5Z9+DTJwLCzZcfBcdFl0IusUrQ3R5xHrXmeRfVIOV2LOVPukP2M7e3iDu8UxbdXGXj22RrH+uQ94p3SGki0vau5LqnWAxHDp0xZg2orjCJd1KhSR81dHG7kn0on4lApF0Ez5SYGvZdKjEbxLjIZ8E+OwjyZE5wDoll/C6jPw0=
Received: by 10.70.8.2 with SMTP id 2mr640106wxh.69.1209543750014;
        Wed, 30 Apr 2008 01:22:30 -0700 (PDT)
Received: by 10.70.23.17 with HTTP; Wed, 30 Apr 2008 01:22:29 -0700 (PDT)
In-Reply-To: <200804291738.m3THc2hC030601@rs40.luxsci.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80807>

On Tue, Apr 29, 2008 at 7:37 PM, Daniel Quinlan <danq@brtt.com> wrote:

>  3) Similarly, I can't use the little context diffs I can see in git-gui  --
> I need to see side by side comparisons;
>  I've become accustomed to tkdiff.  It seems like git mergetool knows how to
> do that in some restricted
>  circumstances, but I want to do it outside the context of a merge.

If you use Vim, I'd recommend the vcscommand plugin - see
http://code.google.com/p/vcscommand/ - which has fairly recently added
git support. Once installed :VCSVimDiff shows the diff side by side
between working copy and HEAD (by default, or whatever revision you
tell it) like a regular vimdiff between files.
