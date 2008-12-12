From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 12 Dec 2008 23:54:43 +0700
Message-ID: <fcaeb9bf0812120854k1c366327o9bc696184ea4f02e@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
	 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
	 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
	 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
	 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
	 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
	 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0812120813m2949e36ar7905d5688b8f6ecb@mail.gmail.com>
	 <4942952E.1060706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBBJ6-00067h-7w
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757807AbYLLQyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758240AbYLLQyq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:54:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:9506 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133AbYLLQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:54:45 -0500
Received: by fg-out-1718.google.com with SMTP id 19so741954fgg.17
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 08:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TBpVkO4dR5v14r2+y8NFURFgiqxG3v1+EDUSwSB4Jz0=;
        b=eu5kZbJknj6LgVbHHt7RKT8XiQhw0c1xrxleayUJnjz3566RxArQuG7IQMvxjiGCg8
         WJEsoc/XwmFkEtmC2sw1os/MmwTXebDY3olA4CQjil57vMgsbQX0F0k0R315uUCY1czp
         FBhElVKaf3Hs8VW3x7nNtG3BEhJXEyeB7PkPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nfwKrjwI6ylViK/grgwzpM+DkDdJxjMLd8JhfQSChPpOCgqMBtH+TIYApQc/h5aAG0
         vhd1ybhSmTXnt0a9h1FXI8qT5mW7qCsRqDl11I8xZsiNCmP7pgCp8stb0iZEbcNns48F
         1+UJ7hdaDPlBWuRXHFMMaTh8fFKLMtdg/b1ew=
Received: by 10.86.59.2 with SMTP id h2mr2120465fga.73.1229100883801;
        Fri, 12 Dec 2008 08:54:43 -0800 (PST)
Received: by 10.86.87.14 with HTTP; Fri, 12 Dec 2008 08:54:43 -0800 (PST)
In-Reply-To: <4942952E.1060706@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102917>

On 12/12/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nguyen Thai Ngoc Duy schrieb:
>
> > On 12/12/08, Junio C Hamano <gitster@pobox.com> wrote:
>  >>  So "git grep -e frotz Documentation/", whether you only check out
>  >>  Documentation or the whole tree, should grep only in Documentation area,
>  >>  and "git grep -e frotz" should grep in the whole tree, even if you happen
>  >>  to have a sparse checkout.  By definition, a sparse checkout has no
>  >>  modifications outside the checkout area, so whenever grep wants to look
>  >>  for strings outside the checkout area it should pretend as if the same
>  >>  content as what the index records is in the work tree.  This is consistent
>  >>  with the way how "git diff" in a sparsely checked out work tree should
>  >>  behave.
>  >
>  > Assume someone is using sparse checkout with KDE git repository. They
>  > sparse-checkout kdeutils module and do "git grep -e foo". I would
>  > expect that the command only searches in kdeutils only (and is the
>  > current behavior).
>
>
> But what if the same persion notices a #define in a kdeutils header file
>  and want's to know whether it is unused in order to remove it:
>
>     $ git grep FOO
>     kdeutils/foo.h:#define FOO bar

"git grep --cached FOO" ?

>  Conclusion from this output: "It's only defined, but not used anywhere."
>  But this conclusion is not necessarily correct because FOO could be used
>  outside kdeutils.
>
>  So, no, "git grep" should disregard the checkout area.
>
>  -- Hannes
>


-- 
Duy
