From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Thu, 23 Aug 2007 15:04:02 +0100
Message-ID: <b0943d9e0708230704k78281ce4jc8dcb7078fea20ed@mail.gmail.com>
References: <20070810031949.19791.54562.stgit@yoghurt>
	 <20070810032318.19791.70483.stgit@yoghurt>
	 <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com>
	 <20070821164629.GB17045@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 16:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IODIG-0003ie-Vs
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 16:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462AbXHWOEL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 10:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbXHWOEJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 10:04:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:24373 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbXHWOEI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 10:04:08 -0400
Received: by nf-out-0910.google.com with SMTP id g13so379646nfb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 07:04:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UZC6wv8CmaipDuNkz+QMriEmV7OJvlTdvpdxfALIg1sCDWCcZtUM2Fkw/BsS0ueSk+RlGIlmPNC9T17gvV2FLDILkAa4GDzCp1afxD0bCz2s5Rv/MamKnRtnSJhCpW7OOQPe8RqxVkyyMM1cedBUqgOsnVA3lUDgaT48LPtNhew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=guNKLKWlbUjQkJXVPocVXHNqAs/ZuIdFvtMaTnOuXXEueeNZgHvcISMBw1emrH38qvLYeEOE+lc56KNAZc4r9u179kUJpzQUF6cmM5weEZydcryf1pKXNKmBiJq0PDHDMJbIcnj1UdPQgs8Aw7eGTk8h2jg25BSFI2SDvK8IVvQ=
Received: by 10.78.166.7 with SMTP id o7mr1235725hue.1187877842311;
        Thu, 23 Aug 2007 07:04:02 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 07:04:02 -0700 (PDT)
In-Reply-To: <20070821164629.GB17045@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56499>

On 21/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-08-21 14:23:29 +0100, Catalin Marinas wrote:
>
> > Thanks for this patch.
>
> Two things:
>
>   * The test in your tree has the latin1 form of my name in it,
>     instead of utf8. (I noticed because I got a conflict when I
>     rebased onto your master.)

I imported it on a different PC (at work) where I think the locale
support isn't properly set up. Xterm accepted a copy-paste operation
with your name and I passed it through emacs which probably broke it.
The From: header had a different encoding and hence the author was
correct.

I'll try to do it on my home PC only (or just pull from your repo :-)).

>   * The test suite now fails on your master (since you've applied jus=
t
>     the test and not the fix). Please don't do that; it makes
>     development needlessly hard. (To be fair, this is partly my fault=
,
>     since I posted the fixin a separate patch. I'll change my ways.)

I think it's OK to send separate patches and I'm OK with a test
failing in a development stage. The 2nd patch didn't apply cleanly and
didn't have time to see what was wrong. I'll push it tonight, please
have a look for things I might have missed.

Thanks.

--=20
Catalin
