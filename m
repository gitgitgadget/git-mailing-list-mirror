From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Advertising the prebuilt htmldocs and manpages
Date: Sat, 19 Feb 2011 03:41:04 -0600
Message-ID: <20110219094104.GA31980@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <4D5F0A7C.1080507@gmail.com>
 <7v39nkooem.fsf@alter.siamese.dyndns.org>
 <AANLkTikb0W-yLihPtvm5LDUKgxgRg_a5Rsq7pjnpZLCt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 10:41:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqjJf-0002wM-Ln
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 10:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab1BSJlP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 04:41:15 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56400 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab1BSJlM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 04:41:12 -0500
Received: by iwn8 with SMTP id 8so244954iwn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 01:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jor2FDFXhEKZc6I321i9AkYFMTVnjo05Ftkux7vx9s0=;
        b=nExTkKQi0YglYmTFCwPe+SzhS41SquDpYm+hHvyGXi+ehVzVmQE2e3ewGLakQ/V8ac
         +8Q9aOydlGyfPamujXbREoY401VTovnUTxEhXD1NABAAMotxfex4WT3evng5qeR2Zwjo
         78I8Mprb5ztfK1+YISoyvguMDSdUJmTzAA+H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=df6BXuowQcEXsxmBwaQJmwXYBQj/pvzNltNsiTNK0HNMNEhVMPgx5P98N0vSJgzE/r
         RLAnfpoKlqv8Uont3+GLlnlrT5c2Ld07oNr8/cSjXg3PGKfh3ZanlXd0p/e9WS4WW5Yp
         rcVGVMjE8TvCKMoE6OdHkQCOZgRjU30HzDHBI=
Received: by 10.231.59.149 with SMTP id l21mr1230172ibh.196.1298108472214;
        Sat, 19 Feb 2011 01:41:12 -0800 (PST)
Received: from elie ([69.209.72.148])
        by mx.google.com with ESMTPS id gy41sm2637577ibb.17.2011.02.19.01.41.10
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 01:41:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikb0W-yLihPtvm5LDUKgxgRg_a5Rsq7pjnpZLCt@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167263>

Piotr Krukowiecki wrote:
> On Sat, Feb 19, 2011 at 1:31 AM, Junio C Hamano <gitster@pobox.com> w=
rote:

>> We are talking about a source tree; there is no end-user
>> documentation. =C2=A0Only the sources to it.
[...]
>      Note that not everyone compiles docs into man pages - for exampl=
e I don't
>      have needed tools on my laptop and it's not that fast too. I jus=
t
> have to use
>      raw .txt files instead.

The INSTALL file explains:

   Alternatively, pre-formatted documentation is available in
   "html" and "man" branches of the git repository itself.  For
   example, you could:
[...]
   There are also "make quick-install-doc", "make quick-install-man"
   and "make quick-install-html" which install preformatted man pages
   and html documentation.

It does not explain that http://www.kernel.org/pub/software/scm/git/
contains git-manpages-* and git-htmldocs-* tarballs for people who
do not have git yet, though.

The README file says:

   Many Git online resources are accessible from http://git-scm.com/
   including full documentation and Git related tools.

Maybe this (especially quick-install-doc) can be made more
discoverable somehow.
