From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Tue, 9 Apr 2013 01:24:18 +0530
Message-ID: <CALkWK0npHgsf_TyjrMRJdcT-twg_jRXOHtoNpmX+2XNeLq=ZAQ@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
 <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
 <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
 <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
 <7v1ual12pj.fsf@alter.siamese.dyndns.org> <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
 <7va9p8yjuf.fsf@alter.siamese.dyndns.org> <CALkWK0m4o=F=bh_mt9NGDfXKExgVtLhaZ7uxA_XFhpF5AN5-Fg@mail.gmail.com>
 <7vk3ocx0qq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPI9j-0008NX-7b
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935848Ab3DHTzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:55:00 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:34535 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935802Ab3DHTy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:54:59 -0400
Received: by mail-ia0-f174.google.com with SMTP id b35so5638517iac.33
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=L9s6mQIKw0bz9n6N9EvBwLt8uBo1qo6QDFJtaOe5QJ0=;
        b=qMazqxd5zuCpYzWL6ZO48Pf2d/PyLy654tbB2YnfJDA0Saloxzgchxcu9dNUIUkIn6
         Isx+P69i8ny3Y6qA6K3NhQGwxYlEC30hj9wFIE+iJ63EJ+2afsEpp7IVU0rnCMK5sNG9
         kMXXbtowB1EI0JUZVrtD7wLxlPPPZT6mSYyh2GKYfxXY+57tK+SCcp+OcOVPK4yVuxpu
         FJieCF+PLCb4mTu6ns+yl2uV3gaTw2222ACRXd4gBTuDINX0kIQvtBCxz0io8zgCWx6q
         5Ywq9y/dn56fu32eTFcqlXa8i+2hhdpbNPtS/7IRqCeYGcA2zgi/Sl6oXr3VZ1XMlzlC
         JvUQ==
X-Received: by 10.50.17.166 with SMTP id p6mr8151956igd.12.1365450898331; Mon,
 08 Apr 2013 12:54:58 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 12:54:18 -0700 (PDT)
In-Reply-To: <7vk3ocx0qq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220505>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Does git diff/ commit/ add/ rm or any other command you can think of
>> rely on a special file in the worktree (aka .gitmodules) to be checked
>> out?
>
> Try "git add foo~" with usual suspect in .gitignore ;-)

First, it's not a hard requirement: in the worst case, git add will
add the file even without a -f.  Second, I've already argued about how
I think this is the right design: What part of that do you disagree
with?  What alternate design do you propose?
