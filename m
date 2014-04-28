From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 18:50:55 -0500
Message-ID: <535ee95fc17d5_5a07e812f018@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <xmqqk3a9m3ah.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: James Denholm <nod.helm@gmail.com>, David Kastrup <dak@gnu.org>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:01:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WevUR-0003qc-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 02:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbaD2ABe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 20:01:34 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35471 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbaD2AB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 20:01:29 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so8020163obc.25
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=LFpy1aBofRq5RUIV+8AsMEehZJZgEMYq8n5f8cYofig=;
        b=SNBDr87lW8U38fPLkXJjVza2qzaHJbyOBA7fKWzJDbOMLuKgIBAG8zUgWyRj5aJf7U
         tlbnI4VpGncr4KUNAr0iZyGLiQxOjtRCPp3Sk35mJZc5arrvZ/eHju2Imxf0/B7BdPjB
         8FX4pjFEtA/FaRdEAplgwByq/7N+f/sQPdcNV1zbwdzEqWHaeXg7USxMo59AzjyOORUE
         Orfz0U1sEZnUSstYmL3UmpZmYTePWLGxs4aQrzwCVleoYlWnlPA52HZBAqWC1I6T/hVy
         jHBdgEaGOb6CNinU90TY8VYETBtZQCcI746LnJXt6MhQhF3Ig6ChzCZzcccO7HyMRC47
         nGhw==
X-Received: by 10.182.165.134 with SMTP id yy6mr24550720obb.5.1398729689202;
        Mon, 28 Apr 2014 17:01:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm40097880obm.2.2014.04.28.17.01.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 17:01:28 -0700 (PDT)
In-Reply-To: <xmqqk3a9m3ah.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247499>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Except that in this case virtually everyone agreed the default was wrong. I
> > already said that.
> >
> > Clarly you didn't read the relevant discussions where everyone, including Linus
> > Torvalds, agreed. Did you?
> 
> My recollection is that everybody agreed that the default was
> wrong.  I do not think I saw everybody agreed the patch you are
> championing is the right solution to solve that problem.

I'm going to add the quote you removed:

> > James Denholm wrote:
> > > You neglect the possibility that your personal view of what git should be
> > > differs from other people's.

In this context James was talking about what Git should be. But the vast
majority agree on this issue, so that's not what's preventing change.

-- 
Felipe Contreras
