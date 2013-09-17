From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Issue with sparse checkout
Date: Tue, 17 Sep 2013 18:27:05 +0700
Message-ID: <CACsJy8A5hxr-oSiLTmY2iA-LrmnCk3PW9SxLcvYdJgfDV7Qppg@mail.gmail.com>
References: <SDZPSjFXUiRJMCkwPVQvMjk3OTAwMzE@IBMLT4> <loom.20130917T004445-713@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Gregory <martin.gregory@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Tue Sep 17 13:27:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLtRX-0000w6-GE
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 13:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3IQL1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 07:27:39 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50427 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3IQL1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 07:27:39 -0400
Received: by mail-ob0-f171.google.com with SMTP id wm4so5250621obc.30
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QVhXc0gv9MlDaGHdmYvnIpL5MW60bRrb3r1Xl2ttQ7I=;
        b=rnvUdYZPBS76cSGIMg9M0z0jcWglXw36e7Vq+5HfA7lOqZ/1RSpUq6UnGKg2QF+N0l
         bff6clr5O4m1KMNOakbiGsVH5enKKAsI+i0kKHfX7puE+vRFqTpPrEj5dKjWVA8tNIzs
         EabgvmI5xW94vAwEJ6qDO0+VHOrO1Dr4zC3eFMTMjNpHboDuVQefw1evXaBFhhroQ7MM
         5ErAAXgJmRZNrVZXT4laAdv31hC2nQIrvKovUBFqv1hiDExAS5uXN9aZDVtp/AP+YlXY
         pAFopxIoTFcT9GUYyfNWiFvDVDB4l3Ws/l0ndxWJbcccdaYw5Xw+wjD0W545hEchoQQd
         4Oog==
X-Received: by 10.60.68.135 with SMTP id w7mr30472749oet.9.1379417256684; Tue,
 17 Sep 2013 04:27:36 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Tue, 17 Sep 2013 04:27:05 -0700 (PDT)
In-Reply-To: <loom.20130917T004445-713@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234871>

On Tue, Sep 17, 2013 at 5:46 AM, Martin Gregory
<martin.gregory@adelaideinterim.com.au> wrote:
> An additional note.  I did
>
> git ls-files -v | grep ^S
>
> and I can see that the files that remain in the working version have the ^S
> bit set.
>
> So it does feel like a bug to me: why are files with ^S set remaining in the
> working version after
>
> git read-tree -mu HEAD
>
> ?

I don't know. Maybe the bits are set, but then the remove operation
fails (silently). I tried to reproduce on Linux without success. It
seemed to work ok. Can you copy the (stripped down if necessary)
repository somewhere? Pack the whole thing including worktree and
config file, just in case.
-- 
Duy
