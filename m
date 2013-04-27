From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.8.3-rc0
Date: Fri, 26 Apr 2013 22:24:07 -0400
Message-ID: <CAH_OBievcf-_z_AX9UrmWL_HVFT2vSQTu+wXAjAFeQBM8iFSGw@mail.gmail.com>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 04:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVuon-0003KN-JK
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 04:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab3D0CY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 22:24:29 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:33068 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab3D0CY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 22:24:28 -0400
Received: by mail-ve0-f174.google.com with SMTP id b10so2162831vea.33
        for <multiple recipients>; Fri, 26 Apr 2013 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=g+BGSowf2+1GoXOmx9O1ofjN+BRbkg72TcnEeReXNp8=;
        b=jgMssaWDp5sSKziifb9PUb3Ghxx04S4gIQtyFLQVSTZbNPwVMm022rRcBB/JMoV4FJ
         DtP3s9QzL/ONBi6OSG5OXABH4JVfJe8fWv9vafZRwBm6TroJPrxd1Z+S0sWH533JCfsM
         a+ZRkbbLaUVF3OwZ0ig4sLIBRneFa/hpX4pm05YHmmRNMBpECww1vJMpylfPGT13N/Mg
         vh46W1hupZVDV95BtbL64MRukThbDoh2+mOOELMVZvu7bS5UGCZpusYHpwUXJ7m0fJoV
         hsSIFIXVx9ROJwX6XszYayzMZUJrSmOJQ9S7QvYoo+/P/CFbkAN2xbmanJHGZmcD1YoG
         AkMg==
X-Received: by 10.52.76.41 with SMTP id h9mr1101953vdw.12.1367029467916; Fri,
 26 Apr 2013 19:24:27 -0700 (PDT)
Received: by 10.52.103.14 with HTTP; Fri, 26 Apr 2013 19:24:07 -0700 (PDT)
In-Reply-To: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222615>

On Fri, Apr 26, 2013 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:

>  * There was no good way to ask "I have a random string that came from
>    outside world. I want to turn it into a 40-hex object name while
>    making sure such an object exists".  A new peeling suffix ^{object}
>    can be used for that purpose, together with "rev-parse --verify".
>

What does this mean / what is the reason behind this? I can only think
it might be useful in a test suite to make sure git isn't doing
anything stupid with hashes...?
