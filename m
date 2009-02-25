From: P Baker <me@retrodict.com>
Subject: Fwd: git & Google SOC 2009
Date: Tue, 24 Feb 2009 20:13:52 -0500
Message-ID: <526944450902241713w141169bbgfc1aef4097c2c269@mail.gmail.com>
References: <526944450902190720o253b2f26gd1422bdd6963ad79@mail.gmail.com>
	 <20090219164046.GR22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 02:15:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc8Mw-000300-Go
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 02:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbZBYBN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 20:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758687AbZBYBN4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 20:13:56 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:24951 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756761AbZBYBNy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 20:13:54 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1222178yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 17:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=D8bANXRpZIe6IZv6fQAcL1aExDKaqZ3YoS6pnLHzQgM=;
        b=vvONthoLSJzBc9QAO9M2PtC/GQvTE08tvp+1tt4VzfQEPoTSxRvHRnhp0nFEhsiIxe
         NzSfZmu2Fz64vZLBxHZllevv935Z0Kp0LsZOOhGWnSAdCi9O+AgPLZsCPlx3XlPnyD6h
         IzRAwRGW4F0Rdq8ZYXCmBD1S5DULjC5zomNxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=boCaLUSfc/rv4yA6IGTJs/jC23O5QZW5/o2W/iiNRw1XyOUvR7UYDXaCrf46t/7NFn
         mt3noqNQyBzU/+/1BaFRU4ftNduITj19YmzgDnlvbawm3pe6seH5qMBEwsLQ2fJNlvjJ
         Ck8RZxlKDD+shIhe56FplzlsmPGLZeWW/6AAU=
Received: by 10.220.83.149 with SMTP id f21mr8494vcl.34.1235524432475; Tue, 24 
	Feb 2009 17:13:52 -0800 (PST)
In-Reply-To: <20090219164046.GR22848@spearce.org>
X-Google-Sender-Auth: f6892e10ae676ce5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111364>

As per Shawn's suggestion, I'd like to start talking about git and
submodules. To answer some questions that came up in the other recent
GSoC thread, please see my e-mail and Shawn's initial replies below.

Any further comments would be welcome.

Phillip Baker

---------- Forwarded message ----------
=46rom: Shawn O. Pearce <spearce@spearce.org>
Date: Feb 19, 2009 11:40 AM
Subject: Re: git & Google SOC 2009
To: P Baker <me@retrodict.com>
Cc: jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>

P Baker <me@retrodict.com> wrote:
 > I'm not quite sure who to address this to, but all three of you were
 > involved in git's 2008 SOC effort.


Actually, Junio is Git's maintainer and tries to stay out of GSoC.
 Its a lot of extra work that he usually doesn't have time for.

 This sort of email is better discussed right on the Git mailing list,
 git@vger.kernel.org, as the potential pool of mentors can also then
 respond and be involved, and Junio doesn't have to deal with it.


 > Is git apply as a mentoring organization
 > again this year?


Yes.=C2=A0=C2=A0No assurances we will be accepted, but we do plan on ap=
plying
 again.


 > If so, I'd like to start talking about projects I could be
 > involved in, and any prerequisites I might need to get done before a=
pplying.
 > I'm a sophomore in EE at UPenn, and much more interested in playing =
with
 > y'all over the summer than circuits.
 >
 > In looking at the '08 list of ideas, the git-submodules task (
 > http://git.or.cz/gitwiki/SoC2008Ideas#head-9215572f23513542a23d3555a=
a72775bc4b91038)
 > did not appear to have been taken on last summer and a quick search =
of the
 > mailing list did not turn up any patches, so it seems like its still=
 open.


Yup, that's still an open issue.=C2=A0=C2=A0That should get ported over=
 the
 '09 ideas list again.=C2=A0=C2=A0Maybe.=C2=A0=C2=A0I still think its w=
orthwhile to be
 done, but I can't bring myself to do it.


 > Please let me know who I can bug to help make this happen!


Start talking about it on git@vger.kernel.org.=C2=A0=C2=A0Really.=C2=A0=
=C2=A0Its the
 best way to get those interested talking about it.

 --

Shawn.
