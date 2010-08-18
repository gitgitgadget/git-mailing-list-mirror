From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 21:49:59 +0200
Message-ID: <AANLkTik9yJjCEqPTB4K=FG8gBau7ADK3BGW-A7TaWFS2@mail.gmail.com>
References: <1282135226.24584.92.camel@wpalmer.simply-domain>
	<2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com>
	<1282140854.24584.112.camel@wpalmer.simply-domain>
	<AANLkTik8RGR4OTeZYsttyBtiywGU7Wtz3gQsTjoqAQPD@mail.gmail.com>
	<200088BC-F39D-407B-97ED-A771AA05E89D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 21:50:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OloeG-0002zH-1n
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 21:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0HRTuC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 15:50:02 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46044 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0HRTuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 15:50:00 -0400
Received: by qwh6 with SMTP id 6so884919qwh.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wn50YAsrk2Ts8JuQ1c8EJFA+hyV/q2wgvm0fY9E6ITQ=;
        b=AT5+Elv7R1DEgyacqFwqmMSoigThzhzDCW/oRxfI2p0YVm5McqylZYQxNxfLs58xvx
         P3f0j7v097piuYlMwIvwbmXLFcWqDgoDP95/lYVoGGZQpRMkni16aBcrXPhbIgi+3KpT
         9spK3jZFgSR4Oxyo4NaEbrzNj6pCxia2Mzo3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I3GeJrG5/ubXsYYOpxV3rxFj8wM6Z3UnkG3P3HTRoL/6ueH9yiSpmjA/nqJS9jfEtU
         sktql2UUHLubyyH0cjh3km0O7WMPz7A6J78od5cb1JvaFFGl6yXIEbTEOEvmSmMA7Pe5
         L6Sfll06uiN1epMCO/4SexlBwhp8pDj/4Dl3w=
Received: by 10.224.60.205 with SMTP id q13mr5701558qah.335.1282160999727;
 Wed, 18 Aug 2010 12:49:59 -0700 (PDT)
Received: by 10.229.16.209 with HTTP; Wed, 18 Aug 2010 12:49:59 -0700 (PDT)
In-Reply-To: <200088BC-F39D-407B-97ED-A771AA05E89D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153881>

On Wed, Aug 18, 2010 at 9:19 PM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> On 18. aug. 2010, at 17.50, Thomas Berg wrote:
>> Maybe there is a better way?
>
> There may be, but I'm not sure it would be worth the effort. =A0The r=
eason I started working on CRLF normalization in the first place was be=
cause I got tired of seeing spuriously modified files everywhere when u=
sing core.autocrlf, so I know how annoying it is. =A0The difference now=
 is that only people using "mis-attributed" repositories are annoyed, i=
nstead of anyone who uses core.autocrlf, and as I wrote elsewhere, I do=
n't expect there to be many repositories where this is a problem.

I guess you're right, probably not worth the effort (although I think
that the spuriously modified files are just as "bad" in this case).
Thanks a lot for your work on this, it scratched all my CRLF itches at
least.

I'm maintaining my own personal patches on top of quite a few git-svn
mirrors and git-hg mirrors.  Before git 1.7.2, rebasing these on
Windows was a pain. I even maintained my own .gitattributes files for
many of them, but still had problems. Now all is solved!

- Thomas
