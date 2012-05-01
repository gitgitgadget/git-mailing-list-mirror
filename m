From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 18:20:56 +0000
Message-ID: <CAMOZ1Bue4r7aP75xaeKkFC08WfOqD8O41pkSQGx7RSbW5xWcdg@mail.gmail.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
 <4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 20:21:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPHhc-00029y-IC
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 20:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab2EASV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 14:21:28 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36592 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab2EASV1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 14:21:27 -0400
Received: by qcro28 with SMTP id o28so2062174qcr.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eRfMQxkbpqJq2W6jR7ZECCEq9yrJYcg0VfX6Tr2qoPQ=;
        b=oaFjlokcQpx4xH7JkftdU22dWz3WNFlykc+TZDcoZEJ3l3+EhccYquFjqxCwvd0vCR
         PHe34MbvxG+gr99ACOB9NEIwLPX3BdzRdtZjhb7Kl9Wuho5dq9t84+0y2MqfARkkxN9j
         OO1r95MfByp47R+wt2Scm8ETjuEzt2PqdY9QK4QP5GCszLFEe7DzOOUQCkgf6hIA1eYp
         EyXSp/fD0CO54jY7Jof6Dg5y2LtqsSungimDCNFC9PsXf6apCTiSlkrcUI4BMV7YJTnU
         Yfudfzb+jWXw2iL1ppbb09USIOHw2JMyc1T+KVbc72VsFWrdF3g4dPBt0TqAL07tUh7O
         Ry3A==
Received: by 10.224.102.7 with SMTP id e7mr5496822qao.15.1335896486588; Tue,
 01 May 2012 11:21:26 -0700 (PDT)
Received: by 10.229.122.13 with HTTP; Tue, 1 May 2012 11:20:56 -0700 (PDT)
In-Reply-To: <4FA02830.3040407@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196722>

On Tue, May 1, 2012 at 18:15, Rich Pixley <rich.pixley@palm.com> wrote:

> I want pull to work even without merging. =C2=A0I want to be able to =
share a
> branch between different repositories and different users while the s=
ource
> code control system tracks this for me

I believe you are missing the point that a `pull' in git is a `fetch'
followed by a `merge'. You should read about the `fetch' command by
reading (`git help fetch'), and make sure you understand how to use
refspecs; you will probably find it very instructive to play around
by specifying explicit refspecs to `git fetch' rather than relying
on the implicit rules (which can be somewhat confusing).
