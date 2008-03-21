From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit PATCH] Add ability to commit --amend
Date: Fri, 21 Mar 2008 03:11:50 +0100
Message-ID: <e5bfff550803201911xf2250d2w2064a23a84b2480f@mail.gmail.com>
References: <20080320193957.GA12119@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Mar 21 03:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcWkG-0000XC-GI
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 03:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYCUCLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 22:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbYCUCLy
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 22:11:54 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:11298 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYCUCLx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 22:11:53 -0400
Received: by rv-out-0910.google.com with SMTP id k20so635039rvb.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 19:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4TSsh/7dDEhd+W3gT8mc48vevXuaeM6WoWa2LjzNCRA=;
        b=QcgDnZ9mwZWwA4Sz2z43YlHBrwNTAdqgikGQMGfUPfqlCZ9itGyoC5hH0IdV3VRdCS79sn9/3Zu00cZHKGgnshH58Juhhm6bc8ZbkAGTA3JyMm5XWvUrkNrcth/eryfkdLfeh/vdF3aPhq9cn/Y7AkAXLAvudU2j+ky2bA0oAOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UYMgdn4CBopzrdG8GtuxqTIzKDdj3178293y2HfbRzlm50+I3gfeyuPtXf+kRNEzhbSnsUaq3S5ffon3s/V7kPDEz6+BV7gRW9BXufYT6eTjZdY0v+Ju+XwXyZ7q+Ah0KbI2qL98bT4OYao9xkhZ04f2ArSSzePQNDSRUImsJ40=
Received: by 10.141.129.14 with SMTP id g14mr1173722rvn.274.1206065510493;
        Thu, 20 Mar 2008 19:11:50 -0700 (PDT)
Received: by 10.141.76.1 with HTTP; Thu, 20 Mar 2008 19:11:50 -0700 (PDT)
In-Reply-To: <20080320193957.GA12119@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77696>

On Thu, Mar 20, 2008 at 8:39 PM, Jan Hudec <bulb@ucw.cz> wrote:
>
>  It seems to work for me. I didn't try any particularly nasty cases, but on
>  the other hand I didn't change the commit logic itself, so it should not have
>  effect on this. Please review and apply if it looks OK.
>

Patch reviewed (It seems very good) applied and pushed.

>
>  So what I'd like to look into now is introducing two classes, one for plain
>  git core branches and one for stgit repositories. They will create the
>  actions that depend on repository type (so they would no longer be designed,
>  but QActions are quite simple, so I don't think it's critical). They will
>  share code as appropriate via inheritance or delegation to current Git class.
>  This should make the code a little more modular and make it possible if some
>  day someone decides to add support for guilt or other git extension.
>

This does not seem an easy task (especially for the git part), of
course you are more then welcomed ;-)

>
>  PS: Is this the right way to submit QGit patches, or should I be using some
>  other channel (like sf.net patch tracker or something)?
>

Yes it is (if people on the list does not complain), I don't expect a
lot of bandwidth used for qgit patches and we (possible contributors)
commonly read git list, not sourceforge one.


Thanks
Marco
