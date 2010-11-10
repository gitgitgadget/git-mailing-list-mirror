From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Tue, 9 Nov 2010 19:56:23 -0600
Message-ID: <20101110015623.GC1503@burratino>
References: <20101104112530.5c0e444a@chalon.bertin.fr>
 <4CD2E7B4.3000908@nextest.com>
 <vpq62wddmc0.fsf@bauges.imag.fr>
 <20101104181020.GB16431@burratino>
 <20101104205307.GA8911@home.lan>
 <7vd3qfr7ki.fsf@alter.siamese.dyndns.org>
 <663A3F43-5F64-41F0-B272-64EEE9775250@sb.org>
 <20101108222937.GH3167@home.lan>
 <20101110014215.GA1503@burratino>
 <833D47AD-041C-47BF-9AF3-69FD97F42712@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Yann Dirson <dirson@bertin.fr>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 02:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFzvg-0000wN-MI
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 02:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0KJB4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 20:56:47 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63958 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202Ab0KJB4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 20:56:47 -0500
Received: by qyk31 with SMTP id 31so138162qyk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 17:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JsWeAw79EMRRUOOx8vKdaGtO08oARlugbWw0hzAqfOs=;
        b=ItQ1XfV2vxGOQaf4lQHoWP+FpyDANcz3zt5CuXdxrpOkiLqi5u34+i0LogLYkDf0lR
         8f7Lo56aRQmgqVBmXDNQf1e6Mpt/kok0E3iGw9R5P62fXMv9gA60nS6jlkQlSeCYBRaw
         6eg1i1ugMtKPEFrZbO1N5eg3Erf7pisyBsIzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nyW+RuArs/3Sg+X89mHFj5uQWUBHRX4NTvYCA36kRTMMxgTUd/HAj1lQuS11B8154t
         oQ69cKaSpuPdxCnt3extka0rn/h9n8n4U1lch0Y1n1EFiUVLFIWHUXEFNfgIMrtuk/Hg
         FqMGVGn9xQZ88atcBVgfkyQf2TbqMHBDCiA/8=
Received: by 10.229.211.6 with SMTP id gm6mr7059873qcb.93.1289354202294;
        Tue, 09 Nov 2010 17:56:42 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s34sm96820qcp.44.2010.11.09.17.56.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 17:56:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <833D47AD-041C-47BF-9AF3-69FD97F42712@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161121>

Kevin Ballard wrote:
> On Nov 9, 2010, at 5:42 PM, Jonathan Nieder wrote:
>> Yann Dirson wrote:

>>> |Keep in mind that any commit in the original todo list, that would
>>> |not be there after your edits, would not be included in the resulting
>>> |rebased branch.  In case you realize afterwards that you need such a
>>> |commit, you can still access it as an ancestor of @{1}, see
>>> |git-reflog(1) for details.
>> 
>> Do you mean @{-1}?
>
> @{-1} is the previously-checked-out branch. @{1} is the previous commit
> that the current branch was pointing to. I believe @{1} is correct here.

Ah, this is after a successful rebase, so @{1} is a synonym for ORIG_HEAD.
Sorry for the noise.
