From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Tue, 8 Jan 2008 13:16:01 -0500
Message-ID: <31e9dd080801081016h70bacab0mf89bb625dec587f@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 19:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCJ0M-00044T-76
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 19:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYAHSQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 13:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbYAHSQK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 13:16:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:22239 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYAHSQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 13:16:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so7544025rvb.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kq6wq+7FhvxgKWoJPpw6HfYagF6i6WpgLaUXhbtQ1NQ=;
        b=CCxZZXJm1kDMcHHn5hdvbqMDgxu1a+QXpTc/XZ8V1ge1BF1hrFIrwX/zrXsQmk/8r2wKQl0umjjjmTApQIGo+YTuRGKJXeTfSqww3drX7ISGkEwaP8+VxuALCs5mK3wqUSlT3TjfDRCUjgF6d1EYINuN0Sj/te3axJw9nBLC2oI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sK2QZHHkvPYcrcvhHm/Wo/rNZFxn8QVBRKGtPSTv86tMvzSjmTy1Hs1oUJk0qOL+EfQfYUBPgV/yC7a3pe52n7min/YADvP363AXDlK411NDvShmVCi0Y1uyN/SqnmlDHpTibbzZrnDagvvzu/+vIJXAkps0y3AoRLTxP8Q4jz8=
Received: by 10.140.251.1 with SMTP id y1mr600720rvh.195.1199816166618;
        Tue, 08 Jan 2008 10:16:06 -0800 (PST)
Received: by 10.140.144.12 with HTTP; Tue, 8 Jan 2008 10:16:01 -0800 (PST)
In-Reply-To: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69902>

I've had luck with msmtp: http://msmtp.sourceforge.net/; it's
basically a drop-in replacement for sendmail that supports the
authentication gmail requires.

A quick prayer to the Gods of Google portended this blog entry, which
spells out how to configure it for gmail pretty plainly:
http://typo.onxen.info/articles/2006/06/27/activemailer-sending-via-gmail

Then you just need to specify --smtp-serve /path/to/msmtp to
send-email and you're all set.

Jason

On Jan 8, 2008 11:58 AM, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> Hi all,
> as I previously wrote I would like to use git-send-email to send out a series
> of patches.
> While I was looking for documentation I saw the following statement in the
> git wiki:
>
> " Mailing off a set of patches to a mailing list can be quite neatly
> done by git-send-email.
> One of the problems you may encounter there is figuring out which machine
> is going to send your mail.
> I tried smtp.gmail.com, but that one requires tls and a password,
> and git-send-email could not handle that "
>
> From http://git.or.cz/gitwiki/GitTips.
>
> Is this statemant still correct ?
> Is msmtp the only solution for using git-send-mail with gmail? (tls +
> autentication).
>
> Thanks.
>
> regards,
> --
> Paolo
> http://paolo.ciarrocchi.googlepages.com/
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
