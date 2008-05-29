From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: Confused about recovering from a merge conflict
Date: Thu, 29 May 2008 11:49:14 -0500
Message-ID: <c0f2d4110805290949m18822c3x15675bed83c7fa5@mail.gmail.com>
References: <482B0C52.4030206@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: stuart.freeman@et.gatech.edu, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1lKc-0001It-4n
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 18:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbYE2Qte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 12:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYE2Qte
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 12:49:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:59600 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbYE2Qtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 12:49:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2304527ywe.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Tbu8X/veXjQCpscIlBq+th+ihb0tr60d9911L2S7T0A=;
        b=mVMlKBVH7vDyiZmncie2BIcs50UIJP3dlu5NKuipPAnBIPosXXxBKPc4evNUN9vvxenTL2pX8qdyLIkA5uDlm4eg0JPs//B23uJOqJXeSMOBv7SumXdC9n2Sj+MhxzkLrTVaZPCDgG5ScBdVVb3TokSnAIrA2PKQZCMHja06y8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sQ006wF78Ewp2mR78SIfBrsP4cRuBwwYxQsdw4W+R5zgO63H2fgMr7zVYBm1DesHG7jvTTruBiX6AZcxQep11ECOxu5oQtMmbW7TIaBDxSHTL1jnxA5rxacTUXNdRsj6W4bqIZ379uXuNWufENlcKx3D5h4/Kh0yF9d4Wt5EClQ=
Received: by 10.115.15.5 with SMTP id s5mr4659649wai.6.1212079754906;
        Thu, 29 May 2008 09:49:14 -0700 (PDT)
Received: by 10.115.76.12 with HTTP; Thu, 29 May 2008 09:49:14 -0700 (PDT)
In-Reply-To: <482B0C52.4030206@et.gatech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83217>

I am also running into this problem.
Are you running windows+cygwin or git on linux?
I am on XPSP2 and cygwin

On Wed, May 14, 2008 at 10:59 AM, D. Stuart Freeman
<stuart.freeman@et.gatech.edu> wrote:
> I've made some local modifications and want to 'git svn dcommit' them so
> I 'git svn rebase' first:
>
>  $ git svn rebase
>  First, rewinding head to replay your work on top of it...
>  HEAD is now at cdef7ac Cleanup of new assignment screens
>  Applying Cleanup new assignment screens
>  error: tool/src/webapp/content/css/thickbox.css: does not match index
>  error: patch failed:
> tool/src/webapp/content/templates/newassignment1.html:6
>  error: tool/src/webapp/content/templates/newassignment1.html: patch
> does not apply
>  Using index info to reconstruct a base tree...
>  Falling back to patching base and 3-way merge...
>  error: Entry 'tool/src/webapp/content/css/thickbox.css' not uptodate.
> Cannot merge.
>  fatal: merging of trees aa2dad90c89e9063f2a8002e4b5a11f6b1583955 and
> 6535ebaaebf
>  fdaadd44a93bc1fc4a66a5ec4dcf4 failed
>  Failed to merge in the changes.
>  Patch failed at 0001.
>
>  When you have resolved this problem run "git rebase --continue".
>  If you would prefer to skip this patch, instead run "git rebase --skip".
>  To restore the original branch and stop rebasing run "git rebase --abort".
>
>  rebase refs/remotes/iteration_5: command returned error: 1
>
> Uh-oh, now I appear to be on 'no branch' and the contents of
> thickbox.css aren't marked up with the conflict markers, it appears to
> just be the old file without my revisions.  Did I do something wrong?
> How do I recover from this state?
>
> --
> D. Stuart Freeman
> Georgia Institute of Technology
>
