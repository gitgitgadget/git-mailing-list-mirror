From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Tue, 7 Dec 2010 13:49:23 -0600
Message-ID: <20101207194923.GD22587@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
 <20101202210207.GA4994@burratino>
 <20101207160747.GD1867@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter van der Does <peter@avirtualhome.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ3Xg-0000gi-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab0LGTtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 14:49:35 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49736 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0LGTte convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 14:49:34 -0500
Received: by vws16 with SMTP id 16so288027vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 11:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xNzrmy9Sat21Bl+ipofMhBjdAatRr6SJQcRN0DvFMY4=;
        b=r/PhN+SkM2cqgY9OGzwn0TNQyvZ9VMCwXR/Yj6ay5vKxC8wUKHCWFYbdOaub3IuHML
         hZYmqkc5NPS8lqjZx0CWlaPUufMcaGdQFTREsMywsR0bhPP9pZjZE143+PZ3+anJvmYp
         HyCfSRwfny9DUwFE4B8fP0c6oDb3SSWPE1LPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VFg48TeK4vgkH0u2xtAiTMHk2NV3DfshzMs4q6xeAp5HPKoVBNf+MYAB/uYouXSpUb
         p/zQlRTM8DI65EfTESjqUEJIVcL8RA1U3xAZU04IZ6sOT+y/2zUsrDLSJY+23YIjX9hS
         IQ/oPn7YJwbjSdwfDDK3Cf+Sgl+0sBVEglp0o=
Received: by 10.220.178.2 with SMTP id bk2mr827334vcb.166.1291751373013;
        Tue, 07 Dec 2010 11:49:33 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id y14sm889609vch.28.2010.12.07.11.49.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 11:49:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207160747.GD1867@neumann>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163120>

SZEDER G=C3=A1bor wrote:
> On Thu, Dec 02, 2010 at 03:02:07PM -0600, Jonathan Nieder wrote:

>> Add a minimal implementation of _get_comp_words_by_ref,
>> the routine used to work around bash 4.0's COMP_WORDS semantics.
>>=20
>> Based on bash-completion 2.x (commit bf763033, 2010-10-26) but
>> tweaked for simplicity and to allow zsh to at least parse the
>> code.
>
> What is this patch based on?

Ah, sorry, applies to d93f4a297 (bash: work around bash 4.0 change in
COMP_WORDS semantics, 2010-12-02).

Can re-send in a few moments based on maint if you'd like.
