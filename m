From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 12:35:59 -0800 (PST)
Message-ID: <4b61f52f.1d255e0a.4cc1.7f37@mx.google.com>
References: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com> <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:36:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nab63-0001GG-R9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 21:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab0A1UgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 15:36:05 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535Ab0A1UgE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 15:36:04 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:37710 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0A1UgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 15:36:02 -0500
Received: by fxm7 with SMTP id 7so1335555fxm.28
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:references;
        bh=xY0mi4sIKFXptHSY9FfK5FQL+cl8EJ42Y3XKefF3P7o=;
        b=EEaXNGA69rjmyNA/rCbD+3gcQeQ5apDgWL2UaPXSGIAtL9L4QTNoJiMGk4Fv3N/r05
         I8mDiUZEogJZJh1Y0gxCWA3fqmPCpi13g5tcZCb69KHJB5DaeooExWmBa7v1CCH5Ql+F
         cf+h9Gv/ynFnsO5culHjEXGFKSjtgCBII131I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:references;
        b=cfGkGGy6fR522maBgqLeS8veFIymFrTy0Q9WLM+t297kreroQWo/pnAQ07Xgv/6ddf
         q8ofmDZBBX9i2kTtsIkTadZXh0wiui6LuJfOFayzc3N5auFRrX5ewlVtLxABCmVjwCUG
         VT1Vn5A/UDdqy2tx+tuYhUmFnFan2RbnpjKoE=
Received: by 10.223.5.142 with SMTP id 14mr3408725fav.39.1264710960821;
        Thu, 28 Jan 2010 12:36:00 -0800 (PST)
Received: from gmail.com (gpftor2.privacyfoundation.de [87.118.101.175])
        by mx.google.com with ESMTPS id k29sm181323fkk.21.2010.01.28.12.35.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 12:35:59 -0800 (PST)
In-Reply-To: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138269>

On Thu, Jan 28, 2010 at 2:03 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> These =C3=BCbercommits would also allow developers to make a string o=
f
> commits that by themselves break things but together formulate a
> complete solution; because the =C3=BCbercommits encapsulate the break=
age,
> bisection would still be simple (no fear of dealing with broken
> commits), but the small manageable commits would still be available

As a corollary to this, developers can maintain patch integrity.

Quite often, I've sent a patch off to some project only to have
the maintainer `tweak' the result before making a commit. However,
I frankly don't want my name attached to someone else's work,
because I may disagree with what has been done.

Were =C3=BCbercommits available, the maintainer could commit my origina=
l
work and then make a new `tweak' commit and then bundle the 2 together
as an =C3=BCbercommit in order to encapsulate this series of events.
