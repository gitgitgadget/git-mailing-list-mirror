From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 18:05:38 -0500
Message-ID: <53603042d6e18_c48df1308b9@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
 <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
 <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
 <535f62c1e740a_45e485b30887@nysa.notmuch>
 <87r44g33z4.fsf@fencepost.gnu.org>
 <535f702352d21_3aee3b2f0b9@nysa.notmuch>
 <87mwf431t3.fsf@fencepost.gnu.org>
 <535f76db38a34_6f23159b31099@nysa.notmuch>
 <87eh0g30it.fsf@fencepost.gnu.org>
 <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
 <752e9542-7450-4928-a9cb-79b9c3b69bcd@email.android.com>
 <535f915e3ed89_2719108f30817@nysa.notmuch>
 <514ff3d6-aea5-4b1d-8ff4-14e779876fb1@email.android.com>
 <535fa9b15a495_6d5dff2f0e0@nysa.notmuch>
 <e31d0160-c7e1-4e80-93bb-d1da590eb8b5@email.android.com>
 <53601d818409d_2f8c107d31055@nysa.notmuch>
 <e904f1b8-56eb-4584-9f2e-5a842c870aa0@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: James Denholm <nod.helm@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:16:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfHGC-0001zs-CW
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 01:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbaD2XQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 19:16:16 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:58965 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaD2XQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 19:16:15 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so831272ykb.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=f9bzIBwoa3iO3PGDiUB8kuetKEMNY8rfuvNmcHmK0aE=;
        b=Fa7R0WK4c8NscmbYd9Tzxx+/tC1rBBEvOZt3ZM/wrM+89XjHJXOtq67QVINI6qvUoh
         L55ObRuflG/zPVuU3kr9pzcgHi7WT9h4OzwZJpg5dt/6ripSHdqVsnN4h7qdRM/INgGr
         X7KF9pL1TAuEZHvm9mKsdrzsV9YAIzsvute0yI2aiziR9LqL8TXxcffe+PKsC+nkEQNZ
         2Nj1g/mUFisYIGMu4V87xh1AEDK77xY8a0eivBrc6leIcKwERaKLqy2kbdaFjxmIMu0j
         EgbObsFXCANLdA5xN8IUcFzD5sj2iGCbifK7Ie21KFovQZH0jQ1sKHELB9Yc9eeMvNSC
         Ko2Q==
X-Received: by 10.236.230.41 with SMTP id i39mr1208894yhq.14.1398813374419;
        Tue, 29 Apr 2014 16:16:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id u5sm39445146yhg.25.2014.04.29.16.16.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 16:16:13 -0700 (PDT)
In-Reply-To: <e904f1b8-56eb-4584-9f2e-5a842c870aa0@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247664>

James Denholm wrote:
> > Either way your analogy is completely wrong as I already explained
> > multiple times. I'm not trying to convince vegetarians to go
> > hunting, I'm saying they should eat something, bread, meat,
> > vegetables, anything. Instead they choose to starve to death.
> 
> I'm the meantime, the community decides that some of your proposals
> aren't good ideas, and decide to consider others in due course.

Wrong. The problems are ackowledged, no other proposals are put forward,
nothing gets done.

-- 
Felipe Contreras
