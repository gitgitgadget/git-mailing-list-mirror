From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: a few beginner git questions
Date: Sat, 6 Mar 2010 20:23:18 -0600
Message-ID: <15b345f1003061823u2d7edeeo25229f0a32456f45@mail.gmail.com>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
	 <20100306070533.GL2480@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No69M-0001i7-W4
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab0CGCXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 21:23:20 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39278 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246Ab0CGCXT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 21:23:19 -0500
Received: by pwj8 with SMTP id 8so3120809pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 18:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ONIGlxhJLqyfKQhyTUt6hd7GFHgIO6C7ktgo/Lo6Xi8=;
        b=bTT8g99USEJGk8KUqzpF+/bEB5V8f8QTyDjCZBthuqjPWB+WnhnwqKH2uJYblvvXtV
         VMeHLSEL5RZS/JXcpXWPrDPQ5+FFs5naY+hJPk4Fw+IA5mV+DGFs1m1OMSQ/xW06tMPd
         KVJDnwDaKM5cDXPkzRPfwTCBYrQ8owRskwUjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F81Z5ONlImNG1Suvv1IVuZBThNfAGrrG417rdCMsxbRRhKMlFeIJeCXU5uLKBzc2PN
         XCoYzg2Y68T7QtIey05JpHefhcxuoOWycR2o9QlhWRvlGCUlz5/IEBhh4ONS0PbCcIwh
         u+PLXgW9LD0yCuyONn9k4TBMUYat1rNsXoV+Y=
Received: by 10.142.55.5 with SMTP id d5mr1985093wfa.98.1267928598817; Sat, 06 
	Mar 2010 18:23:18 -0800 (PST)
In-Reply-To: <20100306070533.GL2480@ece.pdx.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141634>

On Sat, Mar 6, 2010 at 1:05 AM, Tait <git.git@t41t.com> wrote:
>> 1. When do you commit changes and when do you stage changes? =A0Or m=
aybe
>> more to the point, what's the difference between doing "stage, commi=
t,
>> stage, commit" and "stage, stage, commit"?
>
> Staging changes is a prerequisite to committing them. With stage, com=
mit,
> stage, commit you will have two commits in history. With stage, stage=
,
> commit you will have only one commit in history. What you stage (or
> neglect to stage) is not part of recorded history in the repository. =
What
> you commit, is.

What's the difference, then, between doing "stage, stage, commit" as
opposed to "stage, commit"?  Why not just make all commits stage
automatically?
