From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 16:32:21 +0200
Message-ID: <36ca99e90905190732g53599cb8y142a137bc79ad655@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
	 <20090519110800.GB28702@noris.de>
	 <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
	 <20090519131044.GD28702@noris.de>
	 <36ca99e90905190632q656a5855qe7624902ef82a3da@mail.gmail.com>
	 <20090519133947.GE28702@noris.de>
	 <36ca99e90905190651tfed03f9ha87ca32b3aee2599@mail.gmail.com>
	 <20090519140920.GF28702@noris.de>
	 <36ca99e90905190714l15a13483p2a76ab7f630bd8bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 16:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6QMq-0001Xs-0n
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 16:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbZESOcW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 10:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZESOcW
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 10:32:22 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:64384 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbZESOcV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 10:32:21 -0400
Received: by bwz22 with SMTP id 22so3865779bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XTuKOJeAFbFOzcoeROkRxx08KcFR+P3yThC/+ph2MeM=;
        b=RJqTXksEjoGZ7KbpCzmE997wLYmGaVrN1NuymEoe+1/ItekEQriyqxgtDYMivhoGdG
         ezXGD9bsLBSrLXtLENoj7XUvKvVeBV+6CPnN83IalZQL+G+fYtonNCGkupFHFVnPlqIt
         LFxLbRBITTPlbR9Smlq6iFZgLNgNMAgIEjT5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eA4ITUcBVeQar+N+heMWLpEJrGaekWA0lpILJa5npydNj70aRzrjeZFIipqVUsFOZQ
         7HDnRcoBRsrdRblMdQ292fCi6FGGSfqO/TPxDbfeCraLolTA5kzCcCODXBdHokbiDTEP
         MPKVYR6ZOnbc5hiy4rjAZLtm5XCQ01QLzB7lE=
Received: by 10.204.31.196 with SMTP id z4mr112599bkc.92.1242743541913; Tue, 
	19 May 2009 07:32:21 -0700 (PDT)
In-Reply-To: <36ca99e90905190714l15a13483p2a76ab7f630bd8bb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119535>

On Tue, May 19, 2009 at 16:14, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> On Tue, May 19, 2009 at 16:09, Michael Radziej <mir@noris.de> wrote:
>> I see another issue. On a quite complicated repository, I did the "t=
g
>> summary --graphviz ... edit ... =C2=A0graphviz ..." dance, and there=
 I get the
>> following output:
>>
>> mir@mir:otrs-git$ cat /tmp/graph | gvpr -f ~/src/topgit/share/graph.=
gvpr
>> gvpr: "/home/mir/src/topgit/share/graph.gvpr", line 936: gg_nl_ret +=
=3D
>> graph_output_commit_line();<<<
>> =C2=A0-- cannot convert node_t to string
> Ok, still two unrelated problems.
And still I can't reproduce it here :(

Bert
