From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 0/3] fix "diff --raw" on the work tree side
Date: Mon, 3 Mar 2008 01:15:55 +0800
Message-ID: <46dff0320803020915u565ce50eraa663f9e5a795b81@mail.gmail.com>
References: <1204451012-17487-1-git-send-email-gitster@pobox.com>
	 <46dff0320803020241l29277bd4m1a711ff0a863e7f8@mail.gmail.com>
	 <7v7igloxtu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrnj-0007uL-AH
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbYCBRP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756788AbYCBRP6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:15:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:31346 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735AbYCBRP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:15:57 -0500
Received: by wr-out-0506.google.com with SMTP id c49so8374891wra.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 09:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=U0aDqYyauS71b7Iejwv8v8ynVIstCreuyoKCVFcXTTg=;
        b=EBAXCgS4y5/1MdLLfB+XsL/+ZQUP8F4loVYjWhevQcav8XDcehPzVdZnNRQN+Js53l2KjSH4rI1YKybiFBSl2zTK4MxfiGWp8g0a2ENi+8HEk78LnYBiuk3ItD+4Tv9gF0cZ7TnCDsyqlb0Pvym8bWBD7enRNOETX7NpXUFPeFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tEJEhnro9TWZGpO/g0/RM5Z2UQkk987MMZN6xfVjw08Klnuwxhp7aUo/QCHC09P9Wg/12bUnc+6EXocbAkjadykUGz1WAmtDeSCoSdphyYkHh3TH7TN1au/B5HEMJdVRwtp30JfZ/sBYGpbjGoxsMRIJwEDO2xm7JNCkjjHpde4=
Received: by 10.100.38.3 with SMTP id l3mr20829804anl.45.1204478155493;
        Sun, 02 Mar 2008 09:15:55 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sun, 2 Mar 2008 09:15:55 -0800 (PST)
In-Reply-To: <7v7igloxtu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75814>

On 3/3/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
> > On Sun, Mar 2, 2008 at 5:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> The second patch fixes the inconsistency between "git-diff --raw" and
> >>  "git-diff-{index,files} --raw" when they are used for submodules.
> >>
> >>  The third one is a bit controversial and changes the semantics and
> >>  existing callers and won't be considered for 1.5.5.
> >>
> > Unfortunately, my submodule summary patch series will depend on
> > git-diff or git-diff-index. So should i resend my improved patch only
> > after the thrid one is applied?
>
> I do not think re-introducing the inconsistency like the third one does is
> a palatable option.
>
> Wouldn't grabbing (cd $submodule && git rev-parse HEAD) yourself be more
> portable across git before and after the bugfix of "git diff --raw"?
>

OK, i will parse it myself


-- 
Ping Yin
