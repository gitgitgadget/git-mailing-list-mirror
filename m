From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sun, 13 Jan 2008 14:28:21 +0800
Message-ID: <46dff0320801122228r4261786eo2f23258e79f2e346@mail.gmail.com>
References: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	 <46dff0320801120312i7b22f13vb9fe2394b1f687a9@mail.gmail.com>
	 <7vve5ysv72.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 07:29:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDwL4-0003zB-0I
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 07:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbYAMG2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 01:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbYAMG2X
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 01:28:23 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:58031 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYAMG2W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 01:28:22 -0500
Received: by py-out-1112.google.com with SMTP id u52so2406585pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 22:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RFccawdToioNdV0KcVNXry1ydmF/sWO4uBA/ZJ7Et4U=;
        b=h+inLwbk913t26HHpGIDuZ0xesgNrx1rW5LsJWVfIjmGdVNT1t0tBXWKxNNeah+IqMO+WT/nonuJdO91UqfLXRGQH30C+zRjoJpUitUvgGmf3QerWMtcbsRE27tNNIvNrYV5GocsJ8nMlCoSYY74tYtmo2j8KJSAGitWfq7V3JY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPA3tsGv2X4UNu57Q1os0j40bCe4SL5mjv5NW2bM403N348/FwwWav6hLzKIOqKAmed40fg+NB6SWqRtFNZellU3M7vGEkutkiGxvnRRV6k4+MAjpXaJawScUDXTphzah/hejU15H4MSpvLTKZzlc5e0GkFenJ1fiN4wi1Y1EyU=
Received: by 10.35.87.10 with SMTP id p10mr5990266pyl.34.1200205701697;
        Sat, 12 Jan 2008 22:28:21 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 22:28:21 -0800 (PST)
In-Reply-To: <7vve5ysv72.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70370>

On Jan 13, 2008 3:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
> >> +                       echo "* $name $sha1_src...$sha1_dst:"
> >
> > If it's a type change (head submodule but index blob, or the the
> > reverse), $sha1_dst or $sha1_src will be the sha1 of the blob. It's
> > inapprociate to be shown as if it's a commit in the submodule. May
> > 00000000 should be shown instead of the blob sha1?
>
> I do not think that adds much value.  When A or B is a
> non-commit, you know that A...B notation does not apply, and
> because it is probably a rare situation you would want to make
> it even more clearer to the reader by using a different
> notation.  Like
>
>     echo "* $name have changed from submodule $sha1_src to blob $sha1_dst!!".
>
> perhaps in red bold letter in larger font ;-)
>
OK, i will think over.



-- 
Ping Yin
