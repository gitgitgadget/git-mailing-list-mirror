From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Sat, 31 Jul 2010 13:56:09 +0000
Message-ID: <AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com>
	<vpqd3u53sd2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 31 15:56:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfCXx-0004it-QA
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 15:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab0GaN4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 09:56:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51533 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080Ab0GaN4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 09:56:11 -0400
Received: by iwn7 with SMTP id 7so2342893iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=GxFg4vBpvY2sxBVyBLHUkAKRAaoFXrpNb4+DWtVTfz4=;
        b=cXa5bk7GQL0/MEUtXP+jtrjlQjr7nFkFFTCVavJAWDMwiI0FsstxxQ+AhD2aijKhg8
         vrIBJFGzXekH8DXwi5atTkW+xeEy7AzytF+uoHCShklGnNurQW3+wDe3RDFZk25usndF
         gX1FKJslNW0CQ4XUL5PfS2qyl4mcKsy/E4jyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xnenrM1nulQeap/Cz+VfxGuB8wFjuk24ZyajLomlm+cRfcUNJRxHOiPh6yo+KW4oB5
         ps/gpAyYs/G2JOQInu0ADvIKM6VDVPlCnNbN8tu1wi6mw4HnikUYwzTTj38r1+Z6NvW8
         FCKuUUM/4/RkO/cVD7dbzxWVkBcCLpNSdZXR8=
Received: by 10.231.34.135 with SMTP id l7mr3480420ibd.148.1280584570084; Sat, 
	31 Jul 2010 06:56:10 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 31 Jul 2010 06:56:09 -0700 (PDT)
In-Reply-To: <vpqd3u53sd2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152326>

On Fri, Jul 30, 2010 at 15:24, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>>> The name of the command may be subject to discussions. I've chosen
>>> "run", but maybe "shell" would be OK too. In both cases, it doesn't
>>> allow the one-letter version since both "r" and "s" are already used.
>>
>> "exec" with one-letter "x"?
>
> Thanks, that sounds good, yes. Any other thought?

I like "exec".

I think the docs need to elaborate on the environment the "exec"
command gets executed in, what's its current working directory for
instance? Wherever I happened to run git-rebase from? the project
root?

your if ! eval .. error message also exits with 0, surely that should
exit with 1?
