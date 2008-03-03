From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: How are the same file modified on different brances stored physically?
Date: Mon, 3 Mar 2008 09:36:46 +0000
Message-ID: <e2b179460803030136s16d9c54by7c7a4c58682e0fea@mail.gmail.com>
References: <15799383.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: amishera <amishera2007@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 10:37:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW77E-0008VP-P5
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 10:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbYCCJgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 04:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbYCCJgx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 04:36:53 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:50342 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbYCCJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 04:36:52 -0500
Received: by el-out-1112.google.com with SMTP id v27so1790221ele.17
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kuMGEOOts/+LSDCRdTxJvKLEZcDTHMCpQdUi2450ZYo=;
        b=VinzoPRxOLJSmGDcmQRPehEIkmutW0p4/PSuwoS0FXIXDTJselasGN+WmsW0NvCRm2ikQr2z9KUCsWavB9cSh6i9sksEelFb56Wbxzasp313qzMTHz8eMIsiEdHF02Tky+gQHsmbA0y2viclUQWWHucttHcqzuRSpFECZsyLwKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QhvKCDRN11ctGy7KtBMFglBnx4mEVNdJi1reGcMRTc7pRhAkeu1OaEE4k++ctJZu5ysjzoR8DBuTwAteR1lggAkmMVZrYiIThqChnKDtvCIlahX5ESxolvIL0uIta1uP9gKyCwGJBos6Dnkr5oYvSHwbBz6+DjDBhdLG9am9d1s=
Received: by 10.140.177.15 with SMTP id z15mr7585036rve.128.1204537006312;
        Mon, 03 Mar 2008 01:36:46 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Mon, 3 Mar 2008 01:36:46 -0800 (PST)
In-Reply-To: <15799383.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75911>

On 03/03/2008, amishera <amishera2007@gmail.com> wrote:
>  I am trying to figure out how stuffs work behind the scene. We know that we
>  can switch branches freely and then work on the switched branch. If the same
>  file is modified on two branches then how are the two copies of the two
>  branches saved?

http://eagain.net/articles/git-for-computer-scientists/

May help explain the inner workings.
