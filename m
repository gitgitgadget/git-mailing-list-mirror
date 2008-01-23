From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Wed, 23 Jan 2008 11:35:03 +0000
Message-ID: <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	 <200801162147.33448.kumbayo84@arcor.de>
	 <200801162158.26450.kumbayo84@arcor.de>
	 <20080117074559.GB25213@diana.vm.bytemark.co.uk>
	 <20080118042447.GA13178@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Peter Oberndorfer" <kumbayo84@arcor.de>, git@vger.kernel.org,
	"Pavel Roskin" <proski@gnu.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 12:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHdtL-00081u-Vv
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 12:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbYAWLfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 06:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbYAWLfI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 06:35:08 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:18954 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYAWLfE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 06:35:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2517756rvb.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oMSzWnLU6xaokHxD6Xqpg8fFk0rAHPKV1x+E5hKcqn8=;
        b=B56oLjdX3TMDPY5gIprGwvwCdd3BKbicCw5x8MCBEYR4y4XLVmjQrsVBWKHFeL3AsZPCZPdh4uxqO4/tTGiWUpv6phigMWq2VO4HmAR9ula6RojvR4zUcTxclLxnDwY0OCxPM5+K3QrC99AaEAJJszh5zNCnGTZv1olIMZWcqgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O/htMBAOGwBCysUyfZ42dJ3zFmqyBLylRBnnocnhLgN5GnqBUtiWIuuwBAjikEm9132mgRoXVjH/1CXRKxTuQ03MNtEb8ygTQgfnlrMJPJuEO0m3NffD1BmwjUKnre8dFa65gW5863tfRviULNH+IZ71W2m+Vk24OvMCKU93uJw=
Received: by 10.140.133.16 with SMTP id g16mr6235405rvd.231.1201088103534;
        Wed, 23 Jan 2008 03:35:03 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Wed, 23 Jan 2008 03:35:03 -0800 (PST)
In-Reply-To: <20080118042447.GA13178@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71532>

Hi Karl,

On 18/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> The following changes since commit 5b2666bab799830ac5e511f35103d04fc3=
968b32:
>   Catalin Marinas (1):
>         Remove a newline from the e-mail template
>
> are available in the git repository at:
>
>   git://repo.or.cz/stgit/kha.git safe
[...]
>       Teach the new infrastructure about the index and worktree
>       Let "stg clean" use the new transaction primitives
>       Let "stg goto" use the new infrastructure

I merged your patches but I have some wishes. Could we keep pretty
much the same reporting messages? For example, pushing reports a
conflict but it no longer lists which files conflicted. The 'goto'
checks the local status before pushing but doesn't report this (and my
machine is slow and it might wait even 20 seconds or more, it is
useful to get some messages).

The pop/push commands report that the action took place. The one with
"action ... done" was friendlier I think, especially with the 'pop'
command reporting that it popped the patches but it waits quite a lot
before returning.

Thanks.

--=20
Catalin
