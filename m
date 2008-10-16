From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH 1/7] gitk: Enhance UI popup and accelerator handling.
Date: Fri, 17 Oct 2008 02:08:15 +0400
Message-ID: <bb6f213e0810161508l68b0548bsbee5e81ef7830b4a@mail.gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	 <18679.47194.852924.385301@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 17 00:09:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqb2L-0002Kb-7M
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 00:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757558AbYJPWIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 18:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757553AbYJPWIW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 18:08:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:31049 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757229AbYJPWIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 18:08:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so163559nfc.21
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tdsdAC4ABSU5bej7orD/3VZpDN1kKCVxbO4hNq2hUSQ=;
        b=cOQv2RHxtDaoWR1A66yU75mijGF3DuyIcD5yeqZEbQLQEHUZ2yOs7YDk3tCJP/ReUL
         cCbkcXzMvZJuKdLHn9i9wqWfvQ6DQJYGQ6XWIlDiwfhf0eDIM/6yHg9QZKvWh/uHleoQ
         cwM9DMTgX/OGvcqx54hv6zgNXljsGvmwXpo/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AUnQVydjublDyxOyeoMGpqU2uInXxiJYnMbZ7OA9JGzW/4W1xMZZQ3+gJiuIVnAWtq
         znfff6bMvS75rq4CRPFvyAcGcMbnjCyPK/1pwDTRtsuGGRMeKswMtPdAWEEHfRzcxFhp
         60DBYplbH5IqekY1hm5hUfR18Ysb3RV6jNEn8=
Received: by 10.103.22.16 with SMTP id z16mr1762192mui.78.1224194895229;
        Thu, 16 Oct 2008 15:08:15 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 16 Oct 2008 15:08:15 -0700 (PDT)
In-Reply-To: <18679.47194.852924.385301@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98428>

On Fri, Oct 17, 2008 at 1:55 AM, Paul Mackerras <paulus@samba.org> wrote:
> Alexander Gavrilov writes:
>> - Popups are supposed to be marked transient, otherwise
>>   the WM creates them in strange places. Besides, at
>>   least under kwin, transients are automatically kept
>>   above their parent.
>
> I agree with most of the places where you add wm transient commands,
> but in the case of the list of references (showrefs), I think of that
> as a long-lived window that one would normally place beside the main
> window.  (In fact, it should be a pane in the main window, but I
> couldn't think of a place for it.  Maybe I should split the
> bottom-right pane in two.)
>
> So I don't think the wm transient in showrefs is what we want.
> Comments?

On the other hand, wm transient makes it always stay on top of the
main window. If the main window is maximized, it is useful.

Btw, gitk probably should not save its geometry if the window is
maximized, because when it is started again the window is too large.

Alexander
