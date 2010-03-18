From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: cc/cherry-pick-ff (Re: What's cooking in git.git (Mar 2010, #04; 
	Tue, 16))
Date: Thu, 18 Mar 2010 08:14:14 +0100
Message-ID: <f865508f1003180014q3add26d1p8d213994df1961c3@mail.gmail.com>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org> <20100317095218.GA6961@progeny.tock> 
	<7vwrxaubjy.fsf@alter.siamese.dyndns.org> <201003180138.56529.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 08:14:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns9wH-0002Mi-WC
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 08:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0CRHOh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 03:14:37 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:38344 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0CRHOg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 03:14:36 -0400
Received: by fxm19 with SMTP id 19so1816991fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 00:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=J1EAj3opo6AB3bMHOiSnSYwpVaCoQByWwUYmeK8i0DQ=;
        b=ic/f8+0yWQuh0aq4mEKpgzKDg6EVg/uk3P+A+fztp63eF45RO0CCr8wCfaBOVuXrTZ
         ScGFfbEmLn3m96Jxj6o8suUKlHLcxuSlOOHggpzzZO8vCmdMXy6raZ6KG2/hwfd7557X
         1/Ok/R7XSJCrRed830RlAlmWUpuSYVCvFNfwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=cNAkB0ozEtSsvozI1wkwmA7ybERzB207GV4rAK7Rfvb2Tdg1Yi5gg84W7yeVGzPGMR
         o8dtynUEsBRYnXcxFrDW9cfei9QFx0CxybOR92lbqnYcfB1dFpnefGEF/mQNNNxPvPO7
         nse23Kn5SgKIcWOXJ3sJ5/i6l2sXVJ05MF9uw=
Received: by 10.223.6.150 with SMTP id 22mr8615818faz.12.1268896474180; Thu, 
	18 Mar 2010 00:14:34 -0700 (PDT)
In-Reply-To: <201003180138.56529.chriscool@tuxfamily.org>
X-Google-Sender-Auth: 1a282dce784a8a0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142452>

On Thu, Mar 18, 2010 at 01:38, Christian Couder <chriscool@tuxfamily.or=
g> wrote:
> On Wednesday 17 March 2010 18:01:53 Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> > For what it=92s worth, I am not convinced about the --no-ff option=
=2E =A0I do
>> > not think --ff ever will be the default: for an operation that amo=
unts
>> > to applying a patch and making a new commit, it just feels wrong.
>>
>> Same here ;-) and because of that, --no-ff as an undocumented featur=
e
>> feels doubly wrong to me.
>
> My opinion is that if we implement "git cherry-pick A..B", and if man=
y people
> start to use it, then perhaps it will make sense for --ff to become t=
he
> default. Because people may not want to have to remember using --ff t=
o avoid
> many spurious commits to be created.

=46WIW, I had a use-case for git cherry-pick yesterday.  I had submitte=
d
many unrelated patches to a project where I am committer (but I still
need reviews before pushing) and placed them on a single branch for
testing.

Almost always the reviews would happen in the order that I sent, but I
wasn't sure so my workflow would be necessarily cherry-pick + test +
push + rebase.  Having the possibility to do an optional fast forward
would limit the need to rebase and thus the time spent for each
cherry-pick+push+rebase.

Paolo
