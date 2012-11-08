From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 8 Nov 2012 17:37:32 +0100
Message-ID: <CACBZZX75tytc=SMY6Y6TuaR3AQ5VL73NmjCT3dd3BRCrGkjpxA@mail.gmail.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
 <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com>
 <509B7E6B.1030407@alum.mit.edu> <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com>
 <509BA2E7.4080102@alum.mit.edu> <509BDCC3.1050107@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Thu Nov 08 17:38:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWV7H-0000rq-9y
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab2KHQhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 11:37:53 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45489 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334Ab2KHQhx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:37:53 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3044140oag.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KMtUqYDcGB64ng+LwqDAh+k5s5YdFlLk+m43wB9J1Y0=;
        b=TmX0r33MAMq4p34AdPbuReznYRTqQN+PSWwJqcZvyFb27bVr7I3gjWLFpS0ZusUnpI
         ZiXLuMGIv63IQsJf2YRABSt7oAaazOCNIY21nKJKmuV3rUcth/XBIZuBimkLjEUMMgir
         4IOLCWkIBhjVrc1+VXiJJwGudso900BHmMVIhW9IgXGG7BRQQv0Jf3ZHQmDV9tsEssQW
         q5/HBrZXqFVaQHRzfEcWnJqB8dufA3YZiUHckCP5DkLczTH0Uryh4EqQNEUURzIft42J
         aVPRul/sHLG+zQ7YkPCyuB9vimtt+FrBY4Sr3U2R1Mz7UFFAez5m1078z+EVEaRF0Zpg
         nzTw==
Received: by 10.60.169.38 with SMTP id ab6mr5548482oec.139.1352392672496; Thu,
 08 Nov 2012 08:37:52 -0800 (PST)
Received: by 10.60.93.225 with HTTP; Thu, 8 Nov 2012 08:37:32 -0800 (PST)
In-Reply-To: <509BDCC3.1050107@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209170>

On Thu, Nov 8, 2012 at 5:24 PM, Marc Branchaud <mbranchaud@xiplink.com> wrote:
> I'd like there to be one list that always gets everything, and the other
> lists should get subsets of the everything list.

Since it supports multiple mailing lists per category you can always
do (I can't remember the specific config keys, but it's not
important):

    commits = all-git-activity@example.com,git-commits@example.com
    tags        = all-git-activity@example.com,git-tags@example.com

etc.
