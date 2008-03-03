From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [RFC] git-submodule: multiple-level modules definition
Date: Mon, 3 Mar 2008 19:02:26 +0800
Message-ID: <46dff0320803030302t286c33a5h3555200c9e8840e3@mail.gmail.com>
References: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
	 <8c5c35580803021018v7590ad76kbbab2b1113e27666@mail.gmail.com>
	 <46dff0320803021747y6e334903pf8b5a77168bc7882@mail.gmail.com>
	 <8c5c35580803022257n7ff0cdc3i1e72a0034d254aa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 12:03:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW8Ro-0000AM-EW
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 12:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYCCLC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 06:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbYCCLC3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 06:02:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:57727 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYCCLC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 06:02:28 -0500
Received: by wr-out-0506.google.com with SMTP id c49so9909807wra.21
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dbFGB38xroptyWGBsBubV/sZ+urCUbWAJzo6MzqyvfU=;
        b=I9dFN+Ag+it4cyN7q4uWoLlkSBL0184c4CXziVDZtq0AlC0wpnlwvIA7Jpf2Iy3claFUpMK8aaPdUvWKePsMuOemlojhgoxFIhCYmUsmDHmJ3utoJJSMpF7QxlKPyu6HebaIh31a0zTTIEwisAcI12oz4oOq8kRFHg1xQLjazu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l2hSU9C32zBpRBWa8gWXq7avZdKLa3DbC3FbVysrQ8D+1gcofIBc3xkKpdLhEEfU1+8vUO+e/5LvhltZ3WUz99B+aOZ0jE9w5EB/l8LcXvYercSNoQlgsq55XbuhAwh4aj369m/rXrw/U0BM8lwdFyrjRx7+w+uOVf2EMWByefA=
Received: by 10.100.165.13 with SMTP id n13mr29324100ane.77.1204542146945;
        Mon, 03 Mar 2008 03:02:26 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Mon, 3 Mar 2008 03:02:26 -0800 (PST)
In-Reply-To: <8c5c35580803022257n7ff0cdc3i1e72a0034d254aa4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75914>

On Mon, Mar 3, 2008 at 2:57 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Mon, Mar 3, 2008 at 2:47 AM, Ping Yin <pkufranky@gmail.com> wrote:
>  >  But why always
>  >  use git init even when we don't have the local configuration
>  >  requirement?
>
>  We need a way to tell git which of those submodules we are interested
>  in, i.e. which submodules to clone/fetch during 'git submodule
>  update'.
>
Now that's easy with the multiple level module definition. We can now
group our modules by hierachy and designate modules we are interested
by logical names such as crawler or search as my proposal has
mentioned.

And if there are not a logical module name satisfying our requirement,
we can define one by ourself in .git/config (if it's a special or
temporary requirement) or  in .gitmodules (if it's a common
requirement).

Now .git/config and .gitmodules will play the same as
.git/info/exclude and .gitignore.
>  --
>  larsh
>



-- 
Ping Yin
