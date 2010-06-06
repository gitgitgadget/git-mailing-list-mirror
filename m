From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sun, 6 Jun 2010 09:59:08 -0700
Message-ID: <AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com>
References: <20100605110930.GA10526@localhost> <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com> 
	<20100605135811.GA14862@localhost> <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com> 
	<20100606161805.GA6239@coredump.intra.peff.net> <20100606165554.GB10104@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jun 06 18:59:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLJCB-00036r-Ru
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 18:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0FFQ7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 12:59:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58596 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab0FFQ73 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 12:59:29 -0400
Received: by vws5 with SMTP id 5so2245722vws.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=umf2vekcje6MxUbAV6v5WLrY817ztpkc8lLPn2Bkv7w=;
        b=KB05nSl2wl0UsokrfJ66CYjRl1A97czpgB2UoK/83LnGi/YLwtFKLcGZoi2Sn4BlTV
         LanINX1u6bRDu9HUwiNmb4/alp1iPowEOkHWcyzEHbtVM2tFBoC7NVgIWzUvv1Xzyn35
         1UgnislQy2xkd4r0S1WYa+wR8jQko2t0XIDtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AcOZju//rni/Sqrj3QHvqllHcHtrMI3//Dm/kO6Dz6SRxQpSx/u99k3u1u95ediVV4
         h6cwDvSphSNtz3X/M5V+bWjhWy264RBkt3mik/QrLa3jPPBhwWR4CWjjL37prk1mPbBC
         BT86VJRXHYSN7bX690MWPxhxtiKXDdzjpEyGg=
Received: by 10.224.65.147 with SMTP id j19mr114712qai.252.1275843568402; Sun, 
	06 Jun 2010 09:59:28 -0700 (PDT)
Received: by 10.229.24.3 with HTTP; Sun, 6 Jun 2010 09:59:08 -0700 (PDT)
In-Reply-To: <20100606165554.GB10104@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148527>

On Sun, Jun 6, 2010 at 09:55, Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Jun 06, 2010 at 12:18:05PM -0400, Jeff King wrote:
>
>> Moreover, the burden for arguing against it is a little higher. It is no
>> longer "I think this is a bad idea" but "I think this is a bad idea, and
>> it is so bad that it is worth changing behavior that users may have
>> become accustomed to".
>
> I argue that people are more likely to be surprised and confused by
> this feature rather than being accustomed to it already. I am also
> waiting to hear from someone who actively uses this feature.
>

I am someone that "actively" uses this feature.  I will often have
repositories that I use on multiple machines, and will forget which
remote branches I have local tracking branches for, on which machines.
 I'll end up just doing `git checkout $random-branch`, thinking I'm on
one of the machines where I've already setup the local branch, and
find it quite handy that Git _does_ DWIM.
