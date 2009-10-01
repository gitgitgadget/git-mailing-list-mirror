From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms 
	from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Wed, 30 Sep 2009 21:33:21 -0400
Message-ID: <2c6b72b30909301833w1c30742dxd881047a9e0f898f@mail.gmail.com>
References: <2c6b72b30909280546l62a6ef9cm21112ca071cdef4c@mail.gmail.com> 
	<287437.36328.qm@web27806.mail.ukl.yahoo.com> <20090930211646.GM14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Struberg <struberg@yahoo.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, Jason van Zyl <jvanzyl@sonatype.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 03:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtAYG-0002lW-Cp
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 03:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbZJABdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZJABdi
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 21:33:38 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:40377 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbZJABdi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 21:33:38 -0400
Received: by iwn8 with SMTP id 8so3983355iwn.33
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 18:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XJzhnWoITYxR/7AIZbwOQxbu8uLtpaj/rsmHV/UZ6W0=;
        b=H/iRIufe5aWhEkpk1Gv6ZmcJFp0uVG5p44SV33YzQVRwv4kdX1nQvAu3YCWbl7JbPL
         gZ4/Ix3QWf6k7uS8uYXdNu0gaVqniZb6JOLKfiYSvA/t/lLgARADOXnaPCoaQKpUncvo
         I1OnuVVq/bKlXeKPe7zbGbqiBQLu927Sf1+28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ryHrcSb8qBg4PvziGyQKV32mCzUfe3tlpfB4dqchJBi7n4aPMTwSFrH3KUkk/BGDHp
         Akt7qH4YqsZarBj5uFCZXaZZoF0PvlDjMZJ9a48Qe7aoZQh23GQigBzg2Oc+dZFacADf
         SDH1C1CKgR/r4raadgZ5votWVRcXTCwoyM+Mo=
Received: by 10.231.83.75 with SMTP id e11mr1070508ibl.11.1254360821139; Wed, 
	30 Sep 2009 18:33:41 -0700 (PDT)
In-Reply-To: <20090930211646.GM14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129372>

On Wed, Sep 30, 2009 at 17:16, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Mark Struberg <struberg@yahoo.de> wrote:
>> > From: Jonas Fonseca <jonas.fonseca@gmail.com>
>> > actually
>> > removes features (by not keeping the JGit specific
>> > settings), which
>> > you then try to amend later in the patch series.
>>
>> I'm not sure what JGit specific settings you speak about?
>
> I think he's talking about the Eclipse settings files? =C2=A0Or is it
> something else?

Sorry for the confusion, I meant the tweaks in the current pom.xml for
matching tests such as T000* ..

--=20
Jonas Fonseca
