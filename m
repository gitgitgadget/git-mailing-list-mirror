From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:25:18 -0800
Message-ID: <8c9a061001291325i4b8898b9m46054040c69f8fc6@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> 
	<alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302> <ron1-F6943B.13162129012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron1 <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:25:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayLY-0005FY-64
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab0A2VZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755001Ab0A2VZj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:25:39 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:43531 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0A2VZi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 16:25:38 -0500
Received: by pzk28 with SMTP id 28so1877869pzk.4
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dcgsKDhDpukKZYrIrqjyc1BacJ6/Vm9DacuorRsaPuU=;
        b=TlcUXCFxjJRnetl/zhhRXxuO+WTtUdHKBv7BMncVLrYTXyHjkW8H/e/EAu7hH7P9J8
         GcRM9vyMr4sawjLM0w0KZjATKto8xPnfB2YFpSnvCav+2SnB1vR+5E5fdSnOAGk8Y3r4
         bdH4y1rYKOipAIlIKNTWgxKO58/456oc2Gwd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uNqjbPnCg1JhujWKYFY3CbhY8l4A+WAqOpZIc/kQheJUvMZAIbq+YqqmwsF/irdXV7
         22cqwQ7qgRfKoqWtMHW8TUPDsfHX6czEauqUhAw+ZIk/bMc1s0wlEw2QoUOPYJsTgRBN
         NIXxW9ijbOnutf2sbjwwEG+dWfXVQeh36Z58g=
Received: by 10.140.55.5 with SMTP id d5mr895880rva.177.1264800338045; Fri, 29 
	Jan 2010 13:25:38 -0800 (PST)
In-Reply-To: <ron1-F6943B.13162129012010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138364>

On Fri, Jan 29, 2010 at 13:16, Ron1 <ron1@flownet.com> wrote:
> I know that master^ is a commit and not a branch. =C2=A0I thought I w=
as
> invoking the third variant of git-checkout (as given on the git-check=
out
> man page) and checking out a commit (which the man page calls a
> tree-ish).
>
> In any case, since my question seems to have sparked some discussion,
> I'd like to offer two observations:
>
> 1. =C2=A0Saying "isn't a local branch" is mightily confusing, because=
 it is
> ambiguous whether the problem is that it isn't a branch or if it isn'=
t
> local.
>
> 2. =C2=A0If I pass something to git checkout (or any other command fo=
r that
> matter) that it expects to be a branch but isn't a branch it would be
> much better if it just gave an error and did nothing rather than give=
 a
> (confusing) warning and try to extrapolate the user's intentions.
> Whatever a user could possibly mean by 'git checkout master^' it is
> almost certainly not what that command actually does at the moment.
>

I don't think that #2 would be possible.  My understanding is that
branches are basically just there as convenient "names" for arbitrary
commits.  In other words (in my understanding): There is no place that
expects a "branch" where a commit (SHA-1) would not work (and be a
perfectly valid use).
