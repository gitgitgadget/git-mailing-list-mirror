From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v2 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 21:40:36 +0100
Message-ID: <1360788036.22870.4.camel@mas>
References: <1360753138.25490.10.camel@mas>
	 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
	 <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
	 <7vy5es9o0g.fsf@alter.siamese.dyndns.org> <1360777065.13768.17.camel@mas>
	 <7vmwv86le8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trsten@science-computing.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 21:41:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5j8c-0001g3-2F
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 21:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760522Ab3BMUkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 15:40:42 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:39138 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab3BMUkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 15:40:41 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so1607641lab.29
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding;
        bh=35KGSiocsTBRcKKlMXhtYIzyPDPhXkA41RQiH1bCNS8=;
        b=lXqLYypyN3sTEMtcpiTCLjEYIbY+43LB3a5hdm4ppHzvu0M7QKcO8t/4W+gZnSuWIl
         haYmRPiXKVWFsGI1yAuztWxK6EiJe0UjaD5DxC5eoSdW+EYDeOfT6KPUO8KGsq1JrmCN
         NeJn3F5/iSHgcbGmXAL3Lph+x3QQ8vNW4eFXmpDqg3yQELNkM3tZYOi6OQncYonXI6/D
         i0zYUaWs9mPMH6c046rau1OCoDHoQ7HNFhfu/OdgZ6K8AadkXTUGWiGTr6eHEQiFwfU5
         cyRwCxyFpenB08lLyk/U207xd35OvJzBPF8Ly2eSAD11zG6MgKosPD1wsp0pnvgm+pL7
         +xxw==
X-Received: by 10.152.131.233 with SMTP id op9mr1511525lab.3.1360788039780;
        Wed, 13 Feb 2013 12:40:39 -0800 (PST)
Received: from [192.168.1.2] (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id xw14sm10897860lab.6.2013.02.13.12.40.37
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 12:40:38 -0800 (PST)
In-Reply-To: <7vmwv86le8.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216285>

On Wed, 2013-02-13 at 11:53 -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> >> Strictly speaking, you have 6 not 4 combinations (shell variable
> >> set/unset * config missing/set to false/set to true).  I think these
> >> additional tests cover should all 6 because "config missing" case
> >> should already have had tests before bash.showDirtyState was added.
> >> 
> >
> > Indeed, I only mentioned 4 since the other ones existed already, and I
> > didn't change them, but maybe it should be mentioned as "combined with
> > previous tests (...) cover all 6 combinations (...)" then?
> 
> It should be sufficient to change the third line of your original to
> say "the config option being missing/enabled/disabled, given a dirty
> file." and nothing else, I think.
> 
> >> Sign-off?
> >
> > Ah, just forgot the -s flag on that commit, yes it should be Signed-off
> > by me.
> 
> OK, I'll locally amend the patch.  Thanks.

Ok, so I shouldn't reroll them with s/unset -v/sane_unset/ and reworded
commits + sign-off then, I can if you prefer that?

-- 
Martin Erik Werner <martinerikwerner@gmail.com>
