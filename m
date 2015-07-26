From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: FeatureRequest: Build improvements for Windows
Date: Sun, 26 Jul 2015 00:15:10 -0700
Message-ID: <CA+P7+xpcXAck4HVFGLa4c9JquBTHaD-yZuuO4s0sAfJ50c+NxA@mail.gmail.com>
References: <BAY169-W8210AC5C69796A61AD2236A78F0@phx.gbl> <BAY169-W30CD27F2F7606F4DF52944A78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dangling Pointer <danglingpointer@outlook.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 09:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJG9x-0004Gl-Ix
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 09:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbbGZHPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 03:15:31 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35572 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbbGZHPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2015 03:15:30 -0400
Received: by iecri3 with SMTP id ri3so44835470iec.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2015 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3I6Cb675qpn7V0f/bR3fme5EqQTxDjioGyYA3+dUiB0=;
        b=S21XIlSdyJbqN0YDeopAhwJ8c4nOvMHJsdIrvCV6YhqQ4ZAruc+9SpUrIEvPzRW7CM
         mkRA18VKDITSCHvnP+9X068ijpngtjgxd0eIKCvzBTnNISdvJLMzmJyrBqSYKCjqQfiB
         b/bU2+Jlk7daasP7Gk6JwpC3gVGTdWZl/hiWR+zcScHTaBa4zh5Tt0cat+8oLkwp1k34
         KlBtk8jSPZ9rkql6RejTVetDXotLy2KzeRArK+IYlZJPo7jg2ZY2594DuMrv53ty7oGF
         siIRWo4+n1vMqK4u9N3TPl72jL+PepM6az1xVv1Nl9Jte9fAKv6j7VJqiBgW+YvoPeS4
         Sd+A==
X-Received: by 10.50.23.98 with SMTP id l2mr8466175igf.25.1437894929876; Sun,
 26 Jul 2015 00:15:29 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sun, 26 Jul 2015 00:15:10 -0700 (PDT)
In-Reply-To: <BAY169-W30CD27F2F7606F4DF52944A78F0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274640>

On Sat, Jul 25, 2015 at 11:23 PM, Dangling Pointer
<danglingpointer@outlook.com> wrote:
> Hello,
>
> In my understanding, the ratio between the mere consumers of git on Windows vs. people who compile git for Windows is 100,000 : 1. If there is a breaking change in the workflow of the latter set, who use Visual Studio to build git from source, I assume that is doable given a good reason, hence this post.
>
> With VS 2015, C99 support is "finally" added with some C11 features as well. See this blog: http://blogs.msdn.com/b/vcblog/archive/2015/06/19/c-11-14-17-features-in-vs-2015-rtm.aspx. One of the edition of new VS is Community edition, which is like professional edition but is free (also much superior than Express edition) and meant for open source projects. VS2015 also has the ability to target compiler for Wind-XP.
>

I think the big issue is whether it has support for the various unix
interfaces and unix shell commands we use. MinGW/MSYS comes with
support for the unix interface, which I don't believe is that actually
supported via MSYS and I don't know if VS2015 is supported? I don't
think it's due to the C99 but due to need of posix interface which is
not normally (fully) provided by Windows.

Regards,
Jake
