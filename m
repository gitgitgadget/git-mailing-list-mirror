From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Sun, 20 Feb 2011 14:17:50 +0100
Message-ID: <AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 14:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr9Ai-0003qB-GU
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 14:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab1BTNRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 08:17:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34793 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab1BTNRw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 08:17:52 -0500
Received: by qwd7 with SMTP id 7so1424952qwd.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IXVr2x1DHhzFzUgaY6BJa1ZgNzPQtzfBRK7Rodl4i9Q=;
        b=RD+4kdiv0oPuWMYIuOhvGSd4xVi34QZ0sjA6oQ1QK+CEJzuswhd+hAShz2ZgI9P+T3
         tPsfjkS+fNqNhxvNRw0wp1ghAnf2D+A/JCgGfYdWLSgGyvTQNBdwKarkS91ssndgpBWV
         gB8T7jBi8QyN2nZl2SrjaGAR3WzYei79x4h/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Go91my5cuXWLXnNo10IcDIJ7k+rDvcQBIyeYfxSxc6s+PMBolY+qfCA7ZGRZuVjjEV
         YckRYtDv4TkiUwNZpoZ0QeUeG1MH/iUTKM3kTANOlQKy0dr9c5gtY1Gp/5VRJHJr4/4a
         u8GfYBzX4uwpAQfbznUzGPIjuLtkkPWbIrpaY=
Received: by 10.229.220.83 with SMTP id hx19mr227118qcb.52.1298207870417; Sun,
 20 Feb 2011 05:17:50 -0800 (PST)
Received: by 10.229.236.148 with HTTP; Sun, 20 Feb 2011 05:17:50 -0800 (PST)
In-Reply-To: <AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167424>

bump.

I don't think this issue was fixed, was it?

(no need to put kdepim back in the cc list)

On Sat, Jan 22, 2011 at 1:46 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Jan 21, 2011 at 7:37 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> I don't fully understand the issue, so excuse me if this is totally
>>> wrong, but wouldn't a rule like 'you can't create a branch for whic=
h
>>> there's already a symbolic ref' do the trick?
>>
>> But whose symbolic ref are you checking against? =A0Your own, or one=
s in
>> somebody else's repository that you haven't recently updated from?
>
> The local ones. That means that somebody can't create a 'HEAD' branch
> locally, and can't push a 'HEAD' branch either, as the remote server
> would already have a 'HEAD' symbolic link. And actually, if for some
> reason I have a FOO_HEAD, and I fetch a branch called bob/FOO_HEAD,
> obviously the local symbolic ref without namespace should take
> precedence.
>
> --
> Felipe Contreras
>
