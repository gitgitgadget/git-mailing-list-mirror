From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/6] Fix misuses of "nor"
Date: Sun, 16 Mar 2014 06:45:30 +0700
Message-ID: <CACsJy8DrJQvNJUW6Ztjnj71NSPaTz6_A9B=UX3mnhGg7q0a=tQ@mail.gmail.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
 <CACsJy8C2Qainuix2CXy7P71BxE1ajrzfxYMmNAyVa04mfSJJ-A@mail.gmail.com> <CAMuNMfri8Sd5pWccnfkE4b1Fdp3i-Cbo6vTk1QVN3SZcOnKvTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 00:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOyHq-0000Gj-2t
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 00:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592AbaCOXqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 19:46:03 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:33367 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564AbaCOXqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 19:46:01 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so4532836qcx.27
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 16:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nfrF5wcXWgSYsSd/CMOZ34l4qn3g7Ke1PFQbTq4c2+U=;
        b=FZsXshujWQGy0zZTWAnpBBeeVqmNL7FNRx6GkInmZ7Yb3jxx1ESDDY0XYWq+On4dSM
         +4vfragLwFuAIwrfTPVAGRH44cmPNAbCdD9tw7weHRzyWJ3CgI56Zvf9U5q87Ho4SuDL
         JCdnV10lA0K4kYlqh9Ss3+ayvC3RPM5pfroAtJPqT62aZdC+ZKnKl4aXw8td4D15UOoN
         4DcuZ1S2Hd6TcY1iljVSWGtUws7oSAK+hkd8K6FDmFbB0KRD06FRoY9D2k2PNM7P3ham
         eJhyXcFLVTYEEJyT48FW7EAtjEWsV2+kAOD4vZKaugx9tAG6uoyCW5i7LmOCEOjWSrqZ
         Rtgg==
X-Received: by 10.224.4.5 with SMTP id 5mr19097672qap.61.1394927160913; Sat,
 15 Mar 2014 16:46:00 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Sat, 15 Mar 2014 16:45:30 -0700 (PDT)
In-Reply-To: <CAMuNMfri8Sd5pWccnfkE4b1Fdp3i-Cbo6vTk1QVN3SZcOnKvTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244176>

On Sat, Mar 15, 2014 at 11:56 PM, Justin Lebar <jlebar@google.com> wrote:
> There's a similar incompatibility with the l10n change and "Fix
> misuses of "nor" outside comments": The former references strings
> changed in the latter.  Should I merge these, or should I enforce a
> particular ordering between these patches?  (Right now the l10n patch
> comes before the string changes in the code, but that's probably wrong
> now that I think about it.)

I think you can drop the l10n patch. After the source code is updated,
new .pot will be generated (probably by Jiang) and .po also
automatically updated. Updated strings in .po are most likely marked
"fuzzy" so translators can double check. So you changes in the source
code will be propagated to .po eventually.
-- 
Duy
