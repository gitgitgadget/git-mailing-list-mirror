From: Matt Di Pasquale <pasquale@fas.harvard.edu>
Subject: Re: git for pushing local subdir to website
Date: Mon, 3 Aug 2009 14:09:26 -0400
Message-ID: <13f0168a0908031109h10c02424l91938918639c6a57@mail.gmail.com>
References: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com> 
	<200908031201.41039.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:09:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY1yu-00014q-5G
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbZHCSJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZHCSJr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:09:47 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:50567 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbZHCSJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:09:46 -0400
Received: by fxm28 with SMTP id 28so2667221fxm.17
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=8fJPLi0ncfd42Dvl2xA+bIQqr8mnsynsZ/+QtxYGpGI=;
        b=kAIaRonZ1uBhDZ5FSM6tmvPSfSewXaMRxQww98lhsU24jYzQzKPJo6IO3EWN/GLJ4C
         Gh5jHwErPkzEqM1iyTz+NuBBnXpdxqy1iUnL/TCYUTZbuknsMh+zv8of2uL/1xSsQsJr
         nN9Qkg0GVK+AJj67unej5OmfXOnNrdHqUJXVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=xMuCFoj9Rn8nRaVXqN4aURGV7euJDfcWtOe/Sy1/WtKG9fCc5pIB630hFGCl6+mIuT
         OXXiIcYCAzmRgXPlVGbcFIDAhny2E+PUXXuVuSuXPeWjPrrSAf0Aa1HGrqCEIri38CVx
         uHKBncT/4JQdtHWmiwaPFWBHGmK4TWlKX+/YY=
Received: by 10.103.182.3 with SMTP id j3mr3703221mup.54.1249322986039; Mon, 
	03 Aug 2009 11:09:46 -0700 (PDT)
In-Reply-To: <200908031201.41039.wjl@icecavern.net>
X-Google-Sender-Auth: 6e29019afe0e3f73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124711>

yes... i've thought of that. that's a good idea. i just love git and
i've never really used rsync. how do i do that?
i'll go google it..
i guess it would also be nice to use git though incase i decide i want
a collaborator, right?
how would u set it up?
-matt

On Mon, Aug 3, 2009 at 2:01 PM, Wesley J. Landaker<wjl@icecavern.net> wrote:
> On Monday 03 August 2009 11:11:13 Matt Di Pasquale wrote:
>> now... how do i just push example.com and not extra and example.com?
> [...]
>> that doesn't really make sense conceptually because example is one big
>> project. extra is like extra files and example.com is like what i
>> really want to go on web server...
>
> There are several ways to do this with git, but since you are not going to
> make commits on the server itself, have you considered simply pushing the
> production files you want with e.g. rsync?
>
