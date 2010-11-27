From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Patchbombing or not, that is the question
Date: Sat, 27 Nov 2010 19:39:58 +0100
Message-ID: <AANLkTinGNURJVdnQjw5BvR1tkoOdCRdgY2poYb8PFH2R@mail.gmail.com>
References: <AANLkTi=C4opog2SfU9R_=dSOGY_5+0WYtFL8BNqcOwUw@mail.gmail.com>
 <20101127172757.GA1858@burratino> <AANLkTimKdwrsYQHGL=KaoQEmv3FLJzS+M=5xdQi+A5Ny@mail.gmail.com>
 <AANLkTik2WXj3kN2859_iSLQWarkR9ugJQiL2TwiNj109@mail.gmail.com> <20101127183421.GA2131@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thiago Farina <tfransosi@gmail.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 19:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMPhD-0004Z8-OV
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 19:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab0K0SkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 13:40:21 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42365 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab0K0SkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 13:40:19 -0500
Received: by iwn5 with SMTP id 5so146423iwn.19
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=m9I7ALRim+gF2o6emG5BVb21e/tTD8mYQ233C4/Omyg=;
        b=kUudcE1btGxb87dlBTS+nz1Il4c/DfGMD4kRzowvpkyPnAQbcN93Apje7LxVhpeFwb
         JRAjCZiPIF5XW0u3kl8Pwe7Q9AScUlauLxUXoFMXCPpqIsMuoek0h7En8L2rnmYrUgai
         fOC//JfOpEWso1ZKE5az37dwo3QUfXZkdVhBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rCvqqdLSi4MxmeoA84bz4h9hgkc2Ju55ftQU5bzKXS/dyiautEL9PLRD6HtXXp6fnr
         o3qYOy7Xjbzt6xXk1MyPuF+6lnygLJPWLe/C3Va0H5TXOb+oFphxzi4WLyxVCM6FrIb3
         lQnM7LA9jr7SjNmYFnERJC5uo7a60FW2EoK68=
Received: by 10.231.31.1 with SMTP id w1mr3265506ibc.7.1290883218424; Sat, 27
 Nov 2010 10:40:18 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Sat, 27 Nov 2010 10:39:58 -0800 (PST)
In-Reply-To: <20101127183421.GA2131@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162323>

On Sat, Nov 27, 2010 at 7:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Giuseppe Bilotta wrote:
>
>> Actually I think that in this case the 'chromimu' configuration should
>> look for chromium-browser if chromium is not found.
>
> Even better might be to go straight for chromium-browser, to avoid
> confusion with ancient versions of chromium-bsu.

More precisely, we should look for chromium-browser first, and if not
found then use chromium. The fall-back to chromium is, I think, needed
because I suspect the binary was renamed in Debian only. Can somebody
with some other distribution confirm that chromium is called chromium
there?

-- 
Giuseppe "Oblomov" Bilotta
