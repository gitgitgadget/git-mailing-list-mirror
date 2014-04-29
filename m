From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 04:25:55 -0500
Message-ID: <535f702352d21_3aee3b2f0b9@nysa.notmuch>
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
 <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
 <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
 <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
 <535f62c1e740a_45e485b30887@nysa.notmuch>
 <87r44g33z4.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: James Denholm <nod.helm@gmail.com>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:36:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf4Sq-00058Q-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbaD2Jgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:36:31 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:40316 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851AbaD2Jga (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:36:30 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so8673929obc.31
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=zXc6azyREYNKvrHJeQuL9wrZjWt9xxTghA0aPtVUba8=;
        b=F9QM0b7w5DDmxYzg1kGfXJ0ZbbMiWELObiD+i3shzGSZsBqt1eV+wKMA1nCV0WT82U
         fDwVwfhhcyWsja6Vl00EZsg/ZQsh+Kfw3tJ2T8WV47yrQgYbi1We368EJE1jgx061BLV
         Tzh9DrwmePtWg+5JzclnQiJFkrFFhbbgCWWj/anGJqb3utSI2q4Hi5fur+nFOP/o5m7W
         A6PCGRSUzPMzwMls5QVcAwxRCBtcaSV48tRnar41OtkD1k+VMoSiCvBD4tQBailBGOx7
         fNGM1bOvJbVSyMN8Gf3rsmO8I1PLmkecnq2CS/JhBuT9jbJl9VnLX4ZfYMFFg517txB5
         NIbQ==
X-Received: by 10.182.118.169 with SMTP id kn9mr11946842obb.46.1398764189980;
        Tue, 29 Apr 2014 02:36:29 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id or12sm42910108obc.0.2014.04.29.02.36.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:36:28 -0700 (PDT)
In-Reply-To: <87r44g33z4.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247557>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Contributors don't have any responsibility to champion their
> > patches.  It is pro bono work.
> 
> No, that's just the appearance that should be upheld in the higher
> society.  It's ok to get paid for work on Git as long as you don't
> mention it in public.

The word "contribute" implies doing something that was not necessary.
If somebody is paying you to do something, then it's not a
contribution, it is simply your duty.

That's why I used the word "contributors", to separate the people that
don't have a responsability, and the ones that do.

> Even while the ones getting the benefits from your work will not
> feel an obligation to make it worth your while, there is a
> difference in satisfaction between getting your work trashed and
> getting it used.

I don't know why this keeps poping up in the thread, but it is
starting to seem to me that you are under the impression that I'm
somehow unable to get my patches merged.

Look at the list of contributors of the past year, see who is #2:

https://www.ohloh.net/p/git/contributors?query=&sort=commits_12_mo

I know what kind of patches can get in, and what patches can't (the
ones that do any kind of relevant change). I know that from
experience.

-- 
Felipe Contreras
