From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 16:36:34 -0500
Message-ID: <53558f6269f91_640076f2f08f@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcM3N-0006Ap-9B
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaDUVrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:47:01 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:59137 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbaDUVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:47:00 -0400
Received: by mail-yk0-f174.google.com with SMTP id 20so3895886yks.33
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=IjSz6V2oxemkcGD/OcOwK2fv7WUJf51taQHVhtUdXUA=;
        b=Ou2XnxjoFzAX2ffOKYqDvxiRddMRPLBwfxTCcs2ntJ/MXa7PxEcod0tOXH8TufeJMu
         UxTW9rgNVgRhouhkZV3GQ2Y/fuCk5hKeSji0207O0xlvzWC681ZAf4igcmGwb3yASaeS
         SL3biz1mPzFo8cdfwfBQajkzqQX2nc6P0xNFdLPKZWhjMz9awy7bO7cAq4cFnJVTVmgZ
         R/eHIidPW6m4VUWayun2YBkYe4sbkUdpMnfGwNnUfshS7DNnUJnrEcpcS0Z2SCbC6cwM
         2KPnTuQgMY9yFo1KsK84ROkD3F7bcwVX9vXaHSTqi2nC+kYrS/dAGEGmPOGq+gHQY1mb
         5Xig==
X-Received: by 10.236.140.16 with SMTP id d16mr55927384yhj.55.1398116819831;
        Mon, 21 Apr 2014 14:46:59 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t63sm74062339yhm.32.2014.04.21.14.46.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:46:58 -0700 (PDT)
In-Reply-To: <53559020.1050407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246653>

Ilya Bobyr wrote:
> On 4/21/2014 2:17 PM, Felipe Contreras wrote:
> > Ilya Bobyr wrote:
> >
> >> Also, most have names that start with either "pre-" or "post-".
> >> It seems reasonable for both "pre-update-branch" and
> >> "post-update-branch" to exist.
> > I don't see what would be the point in that.
> 
> Do you see the point in the other hooks doing that?

Yes, there a reason for the existance of those hooks. Now tell me why would
anybody use post-update-branch instead of pre-update-branch?

-- 
Felipe Contreras
