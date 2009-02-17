From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: First round of UGFWIINI results
Date: Tue, 17 Feb 2009 18:29:08 +0100
Message-ID: <bd6139dc0902170929g7215427clcf40348c01dfd10e@mail.gmail.com>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTmN-0005hE-VD
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbZBQR3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbZBQR3L
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:29:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:22780 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbZBQR3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:29:10 -0500
Received: by fg-out-1718.google.com with SMTP id 16so483351fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=YpAbHxSAC3M4ZQ2vXjxBRTkdFYxhC1b6E0mFibHAhlA=;
        b=PPn1ePUSDm7DrGhr7yxURO/kLEVtH4kieiXg/ZibvQeRdBbjvMY3uNaVtJZRchBcKF
         Pzit8aC3vHyR1+VxZhO4jCFNG/dwA+M7OpBkHyo6eJo4d5SZJ7txJm3rmroIuTfV0Z/P
         hRZ3vsrgjRzvutXjB+1hDeF5Vl7Z83LBDK0+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=frRe98SKOjCjIjfdpSnxBGpl+M4jy9FaiRQ+/uoQadlFRPz9RaYqgpGelvNlA7++54
         GDsJ1+A9DV2SwFpYapo4zlOtkHBv2tNhauFU+FPt8gXusBVS0LiBE3/IOXhvU4An8yBN
         GqOrnfpVZjHuAAw6rgncIljg3sMv+9ISpz5vA=
Received: by 10.86.92.7 with SMTP id p7mr2199724fgb.54.1234891748226; Tue, 17 
	Feb 2009 09:29:08 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302>
X-Google-Sender-Auth: 94504967de83a173
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110417>

Heya,

On Tue, Feb 17, 2009 at 17:47, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I managed to collect 10 candidates already, and since I did all the hard
> work of collating them, I took the liberty of ordering them into a very
> subjective order of ugfwiininess (pronounced "You-gah-wee-knee-ness").

How about using git to do a temporary 'svn stash'?
If you have changes in your svn working copy that you cannot commit
just yet, but you want to check out an earlier revision for whatever
reason, the current only solution in svn to that is to have a second
working copy. But no longer!
$ cd path/to/svn/repo
$ git init && git add . && git commit -m "save svn state"
$ svn revert -R *
$ svn update -r 42
$ # do whatever you need to do here
$ git reset --hard && rm .git

Does that qualify? ;)


-- 
Cheers,

Sverre Rabbelier
