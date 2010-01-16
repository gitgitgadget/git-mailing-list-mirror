From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3] Add push --set-upstream
Date: Sun, 17 Jan 2010 02:12:36 +0800
Message-ID: <be6fef0d1001161012w7ad12730p7cda2d74db732db1@mail.gmail.com>
References: <1263633827-23720-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <20100116203557.95340c00.rctay89@gmail.com>
	 <20100116134656.GA4504@Knoppix>
	 <20100116233043.26a5636d.rctay89@gmail.com>
	 <20100116155612.GA8383@Knoppix>
	 <be6fef0d1001160813o674ed93dn33843813be6f45be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sat Jan 16 19:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWD8k-0004FB-B4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 19:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab0APSMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 13:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755957Ab0APSMi
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 13:12:38 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:40205 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab0APSMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 13:12:37 -0500
Received: by iwn32 with SMTP id 32so1288827iwn.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 10:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=xtUmXjK8N04L3WiE1OLJJguZh93pTufggQb930WYXqo=;
        b=KxV/q3AaXzRRJl2MxY0Oc24MkK7g0ORKCmKNbvnDEI6h36vNOHP5axOBBx5bXFnH+h
         n31jGH04+vkfIAha8VUEQSiKAabxpjrneeK+mc2yaGY5MVyKyyiGm1SsArn6kDefj1HK
         NTm0ei3AoGz2tn+RdwrfyKCSEjZsvGtL3p1yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sGqyoBRI3111BvtYcy6a5erB6pmsPUNvd4MAb+s1NUUvFXv0gL6MMljbRMNT+Oxw+5
         iUgDrODbSzvabynEDS9v8LrBO5haWhL9v8hQB3P4Tfap59T6sIl28pRsxYIVVFC45vtI
         01gGBT95xN+1X1pYsU3qaaOJMvfX02gMUVi7E=
Received: by 10.231.147.78 with SMTP id k14mr502373ibv.11.1263665556752; Sat, 
	16 Jan 2010 10:12:36 -0800 (PST)
In-Reply-To: <be6fef0d1001160813o674ed93dn33843813be6f45be@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137244>

Hi,

On Sun, Jan 17, 2010 at 12:13 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Sat, Jan 16, 2010 at 11:56 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
>> Hmm... In what conditions ref->status is 'none' after push operation
>> has completed?
>
> when a match between a local and remote ref is not found.
>
> For example, the local ref 'master' will match the remote ref
> 'master', but not 'retsam' ('master' spelled in reverse).

I'd like to add that in this case ('none'), no data is pushed to the
remote repo.

This is true for 'uptodate' too, and shouldn't be taken as an error.

-- 
Cheers,
Ray Chuan
