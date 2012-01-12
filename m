From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 22:05:21 +0530
Message-ID: <CALkWK0kTog-rPLPj3fcFDEzDSVt1USZqnVdakW=+DK3C6gADoA@mail.gmail.com>
References: <20120111173101.GQ30469@goldbirke> <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 17:35:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlNcy-00014g-8y
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 17:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab2ALQfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 11:35:43 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44509 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2ALQfn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 11:35:43 -0500
Received: by wgbds12 with SMTP id ds12so1993560wgb.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yJOgTyIwuM6YQVzirQdufdx4t/osv8A0986mVYiNc2A=;
        b=X5ZS2wk5nJh0eENVpYCD0Cb5/nrSh/I3uI13rCaxPRvF8V7NeHSS271uFVf3yQTbUx
         /kTH9ivN73xPmY0nNxykM+Un/0sWUf6e6Bf5RJJI1CXieKLB523YIpUlMBGumyz8PJfj
         g9Bw1z6XRs/Pmv3tENIjVTJiqWczCPF7D/HVY=
Received: by 10.180.104.5 with SMTP id ga5mr1549594wib.21.1326386142231; Thu,
 12 Jan 2012 08:35:42 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 12 Jan 2012 08:35:21 -0800 (PST)
In-Reply-To: <20120112144409.GV30469@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188452>

Hi G=C3=A1bor,

SZEDER G=C3=A1bor wrote:
> I don't think that any commit reordering, whether it's based on
> committer date, topology, or whatever, is acceptable. =C2=A0Commits m=
ust be
> picked in the exact order they are specified on the command line.

Thanks for the excellent report.  I'm trying to figure out how to get
the revision API to do no ordering.

-- Ram
