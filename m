From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 11:09:44 -0400
Message-ID: <AANLkTinGuVm8gib9r7omVV9hHw8B-iBQGgsv+b6wb5=Q@mail.gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<vpq8w1v5gce.fsf@bauges.imag.fr>
	<buopqv6kcsd.fsf@dhlpc061.dev.necel.com>
	<8B950268-7F6E-40E5-9D6C-F150EBEA4F0C@wincent.com>
	<AANLkTinb0149C88Mzx6m4_2BdhpW12OwQ+uP6XzQ5yLx@mail.gmail.com>
	<6FCE62E3-A27E-43D6-9FDF-0133ABD851C2@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 17:09:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8Dp4-0000Hb-UD
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 17:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab0JSPJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 11:09:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45051 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0JSPJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 11:09:46 -0400
Received: by bwz10 with SMTP id 10so362318bwz.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iuQLsN+7oOZomtkqBNrRQaGA1NdXv+QkiJbLX8DuGwg=;
        b=JtDS4jcvoVKYmmbcnQWydDLkiuOwRJyM/BirURXZnwz37iteqsqhqOJBkoC9Atb4Jl
         tui0ZwTR9ejyDjyA1di7Cl3Dwf143K3GnSST1kpiwTYhKyA9VUVA/t7g7s7ZzoGTyUvb
         Vm5PfwPj7MOCpzkHR9dkURbzpxeeV7Eds1Itg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KANJ6mkBOFIc2u4HzSpA1muqTJfNXHOEHYdhYg1PoUx0H1PEqFmJA5OO8ne8W3bNbM
         2sy40F0RvS309IwIJETiM+WYRoap9k3DJLSQjAadwtGjQ6rC8VzQGGmtXHjitmlh4gM+
         67qGbFEx20vxtFBRZjvdL264Nx+pHrijQJTaA=
Received: by 10.204.68.10 with SMTP id t10mr5451693bki.77.1287500984772; Tue,
 19 Oct 2010 08:09:44 -0700 (PDT)
Received: by 10.204.46.207 with HTTP; Tue, 19 Oct 2010 08:09:44 -0700 (PDT)
In-Reply-To: <6FCE62E3-A27E-43D6-9FDF-0133ABD851C2@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159334>

> Well, I'm not "assuming" that the complaints are justified; I'm talking from 3.5 years of personal experience using Git:
>
> - the concept of the "index": learnt it in 30 seconds, and sick of hearing people complain about it
>
> - terminology related to concepts of "tracking"/"remote(s)": discomfort almost every time I've had to deal with it
>

I concur. I 'm working with a couple of dozen of people and helping
them to learn git and the most confusing part is the tracking/remote
because of too many meanings of the same words in use.

We are talking about the tracking branch which is "local remote", but
we also can create a tracking branch that will track the remote but
will be local like:
$git branch -t dev origin/dev

There should be some different consistent and not inter-crossing
naming for the origin's master branch (on the remote side), for the
local origin/master
and for local master that is a tracking branch. The only way i found
so far to explain this is actually via the naming syntax where having
/ in the name of the branch means remote branch. I was a bit surprised
that i can create a local branch with a slash in the name - probably
it should be prohibited.

In this light pull command not updating the remote ref, but FETCH_HEAD
is only adding to the overall confusion (I remember: it is pending
change)

Thanks,
Eugene
