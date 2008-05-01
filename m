From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: Files need updating following a clone?
Date: Wed, 30 Apr 2008 20:32:03 -0400
Message-ID: <1c5969370804301732i282064f7r55858d54a6796791@mail.gmail.com>
References: <65e5553a-a630-4b1a-9c81-f0ed7d9d7361@c19g2000prf.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: edpark <edpark@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 02:32:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrMjF-0000QP-OZ
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 02:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbYEAAcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 20:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbYEAAcF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 20:32:05 -0400
Received: from rv-out-0708.google.com ([209.85.198.241]:31618 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751202AbYEAAcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 20:32:04 -0400
Received: by rv-out-0506.google.com with SMTP id k29so405049rvb.1
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LAEoPMnlTG/mFe25km13W1pYF6JTwabku8RZUqAIwaQ=;
        b=gtE7QKuAxp0FAmnebAAKhLvk4eazBtYUP10g/IZPw25H7o9MAyG6c2ZVJ3LluV06z7CFFBaVmfqmT4kPSeSnHMi8XeOP+Ju2mNCQlSrdCVfB1GSlN1TqkMLmpTJxkFwYZP0FbIb4TRuMMnXCjGTvphdWzOZbbZw7Gi8nppF/3Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pop9EqAbAAK5LV3o5NtqoQ5D59apVftuZcnOEt2APczeA+Cr9gLlq2ibGkyg2yvKw40Fm+SlqF8osvuCrKV5sGFPkTIfjUcLCGXsTEDo0WljambC8KPR9xgxflSgPlXc6M707zJAO8lLVxX/2coVGygLRJJ3GTecANpi6M+uzPY=
Received: by 10.141.197.8 with SMTP id z8mr575394rvp.285.1209601923420;
        Wed, 30 Apr 2008 17:32:03 -0700 (PDT)
Received: by 10.141.3.15 with HTTP; Wed, 30 Apr 2008 17:32:03 -0700 (PDT)
In-Reply-To: <65e5553a-a630-4b1a-9c81-f0ed7d9d7361@c19g2000prf.googlegroups.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80883>

On Wed, Apr 30, 2008 at 7:12 PM, edpark <edpark@gmail.com> wrote:
> This is really strange and I'm wondering if anyone here can help me
>  out.
>
>  I just cloned a remote repository and when I execute a 'git status'
>  right after it says that some files need to be updated:
>
>  utsd.txt:   needs update
>
>  If I just cloned a remote repo how did these files get modified?  How
>  can I make git realize that these files aren't modified?
>  Further, if I clone to a different machine then the git on that
>  machine doesn't indicate that any files were modified (??).

What systems are you using?  Someone recently posted a probably
unrelated issue when mixing macs and windows.
http://article.gmane.org/gmane.comp.version-control.git/80548/match=mac+modified
