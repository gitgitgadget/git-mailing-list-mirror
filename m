From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 11:57:18 -0700
Message-ID: <a5eb9c330801161057q61a04d66u2059e08db1bdd3ee@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <20080115200437.GB3213@steel.home>
	 <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
	 <200801160002.51048.robin.rosenberg.lists@dewire.com>
	 <20080116071832.GA2896@steel.home>
	 <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
	 <7v1w8hslhw.fsf@gitster.siamese.dyndns.org>
	 <a5eb9c330801161010h41e55486y5e8a4335dd939b73@mail.gmail.com>
	 <20080116183840.GB3181@steel.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4113_27156175.1200509839105"
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:57:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDSQ-0006BS-Mo
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYAPS5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbYAPS5U
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:57:20 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:22825 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbYAPS5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 13:57:19 -0500
Received: by wa-out-1112.google.com with SMTP id v27so583308wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 10:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=pN7e/7t9jYBfxf1PYN1ODPKSyIPKq6ITmIHHvuIInVI=;
        b=EOa127vJfOHPQXDrn8f23kgkKn75iqC5xVXt+uCLbkyNvpdXy7bacPUb0/Jm6KjFd5llV8AnpPDD6Imvku8yyFsBYf1SyLSUi+ny3cs1xTCHMXWSa99qQooc7l4d1u7DVkiOM9nBTBTW3b8vHQfv3M2UdNix8kBH7b9FRwLNwmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=rpjwSupKbPnuNP4l+grq0OAsFjoYbGAlWdHRnwodibmvvne/WHj5IjLI+2uzNinA5IqVIMgsPfEWZQRtd1ynu71JoSAh7OVSkAsWJTd7gBGOwRjZ02qRXiuz3lUsk+hHIlTgbFELFXVsA7Bsu3oAn+n78/7kgHnzhIj46L7gzL4=
Received: by 10.114.150.1 with SMTP id x1mr1272008wad.145.1200509839097;
        Wed, 16 Jan 2008 10:57:19 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Wed, 16 Jan 2008 10:57:18 -0800 (PST)
In-Reply-To: <20080116183840.GB3181@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70720>

------=_Part_4113_27156175.1200509839105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Done. The cygwin install is the standard, all-defaults install (and
I've done it 5 times now). I've attached a tar.gz with the test
results run under sh and bash. Hope that helps.

On Jan 16, 2008 11:38 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Paul Umbers, Wed, Jan 16, 2008 19:10:43 +0100:
> > > After seeing the above error, running the test with -i (stop
> > > immediately on failure):
> > >
> > >         $ cd t
> > >         $ sh -x ./t0000-basic.sh -i -v
> > >
> > Tried Junio's latest suggestion. The resulting output and contents of
> > the trash are attached as a tar.gz. Thanks for all your help guys, I'm
>
> Well, either it didn't work or you omited something critical (like
> stderr):
>
>     * expecting success: tree=$(git write-tree)
>     * FAIL 5: writing tree out with git write-tree
>             tree=$(git write-tree)
>
> that is too short. All the traces missing. Could you please retry
> with
>
>     sh -x ./t0000-basic.sh -d -v -i &> test_results.txt
>
> ? If that is what you actually did, I suspect you have a very broken
> shell installed. Could you check if you have bash (bash --version)
> and try it instead of "sh"?
>
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com

------=_Part_4113_27156175.1200509839105
Content-Type: application/x-gzip; name=test_results_sh_and_bash.tar.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbi8ikom0
Content-Disposition: attachment; filename=test_results_sh_and_bash.tar.gz

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
KFCgQIECBQoUKFCgQIECBf998G+0Z0ggAHgAAA==
------=_Part_4113_27156175.1200509839105--
