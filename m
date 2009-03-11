From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Wed, 11 Mar 2009 01:22:26 -0400
Message-ID: <76718490903102222n23e0e7fdlcee2888333a2b912@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	 <20090311020409.GA31365@coredump.intra.peff.net>
	 <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 06:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhGxT-0002EC-5X
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 06:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbZCKFW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 01:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbZCKFW3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 01:22:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:11572 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZCKFW2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 01:22:28 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2574147rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/PteDT2Xsl5AObcTVvXLjVDj94EaX8JmD8kNr/nt5eo=;
        b=pl5fs1Uspot7NoHEcPfnL7KJeGCUN3HW7IG1kTWYuu0fh+640OIviChaMD+hdj8tsI
         KZax2n1udzW+3uqFogS77OM/5TtwKryKpCRxwziMe5mTNWwP/My/IzdLCSkyxDxBxRP8
         LtbTAl0IaU8e5rmsFvr/JKq2AgjzSIXqe+Jmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j1sBmy+cFHRJfcvs+9XfnW/aSIlFKBDCJyKPapLy+rD10p5PD/9cOjYbDzjnHudOXd
         jXyzOWz++CNrWy+LgMkM7SqYQikM8H5jKFV5ra81y8cbhnKEOqAsD3tZ2yMPMvMBdp+g
         w6Ja27y3gh9njVf6KB4ZE5vshxSRsLGm7n9/c=
Received: by 10.141.179.5 with SMTP id g5mr4177251rvp.31.1236748946203; Tue, 
	10 Mar 2009 22:22:26 -0700 (PDT)
In-Reply-To: <7vwsaw7jzy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112884>

On Wed, Mar 11, 2009 at 12:37 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> I need to ask a more fundamental question. =C2=A0Is it really useful =
for people
> to be able to re-track arbitrary remote/branch with an existing branc=
h?

Actually, for me, I find sometimes I've forgotten to setup tracking,
or I've setup tracking and don't want it. I just fire up an editor on
=2Egit/config, or use git config, but I would appreciate an easy way to
add/remove tracking to a branch after the fact.

j.
