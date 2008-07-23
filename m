From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:06:57 +0200
Message-ID: <8aa486160807230706o20c391f2v60b78973dce62762@mail.gmail.com>
References: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:08:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLf0Y-0005PC-T5
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYGWOG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbYGWOG7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:06:59 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:47607 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYGWOG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:06:58 -0400
Received: by yx-out-2324.google.com with SMTP id 8so409206yxm.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=caJAKXZZGA/LGjEpzvhlGrSgX4nWoCE/ezW8/NEvUGY=;
        b=ZlOgMXYp3m8yWiglEGPVZNcUixC6FiTHOathKIBt5QqTnuMguH0IgpReNGjNRzuPce
         inwTueMk1dWDKF6KkPABmFCTHaxOvCnBvDCK9SdliKMxu6/JoYSlTN3VnsO3J6h9kbUY
         BudziwsWlddhkEBRlXQHVdaQBjoZ2zisgn8DE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U/SAyY9x1XxZCkxF+Zu5MlOElhLfNHXdRel6m+PV/bhhzbZJOEVLtvE3+OIWBYrv71
         rUQaiMis5/u7Z153p3rcQmyIyXbD5k8Mc8w0Yn7M3kuNvgqWsLb/Ht2Zy3byuj6dLX1K
         WVu2Au3UN6kosHqG46yys++lCntO8ZkBjQ3Ps=
Received: by 10.150.228.2 with SMTP id a2mr134217ybh.245.1216822017877;
        Wed, 23 Jul 2008 07:06:57 -0700 (PDT)
Received: by 10.150.95.21 with HTTP; Wed, 23 Jul 2008 07:06:57 -0700 (PDT)
In-Reply-To: <20080723130518.GA17462@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89659>

On Wed, Jul 23, 2008 at 15:05, Ingo Molnar <mingo@elte.hu> wrote:
>
> I've got the following, possibly stupid question: is there a way to
> merge a healthy number of topic branches into the master branch in a
> quicker way, when most of the branches are already merged up?

You could filter upfront the branches that are already merged up with:

git show-branch --independent <commits>

but it has a limit of 25 refs.

Santi
