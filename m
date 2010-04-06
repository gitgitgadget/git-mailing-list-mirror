From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4] Documentation/remote-helpers: Add invocation section
Date: Tue, 6 Apr 2010 08:13:49 +0530
Message-ID: <r2gf3271551004051943u6111c956p24f4fd2897c08d0c@mail.gmail.com>
References: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com> 
	<7v1vetmrl1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 04:44:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyym1-0004UU-IL
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 04:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab0DFCoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 22:44:12 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:53128 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100Ab0DFCoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 22:44:10 -0400
Received: by ywh36 with SMTP id 36so2500950ywh.4
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 19:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=fO/Lx+NJSiQ2TpPvs3i59VXGUoR4QadLVi50JecNRtY=;
        b=ApbQp9eMbG0JJ/CA+Dd8hPR0L9wdPDz2Lg4jtzhtkji1DC6GsHDT8tBmcj6yvAIjH5
         rpXui7fnPzPBG3wwzqcAZyeR9a0VAIi6z9ZDZ9a1Z0Sc1KcxCnGO0rnkAkLQG7o7nbZE
         5QYGtNnqrPwIdZCFHGITeO/U8dZhrtAFgmj4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=c2CV5Ee1qESSMyRwOa9ko49clkG/z1Z0iIDY1Izh3S9j4pK2r06Ah1T7npKGWosWPs
         mhGkSHl5N4OAI6yWxS3vkjwbuA+Nw9AILhNVda9eBnKovppGJLJqa1Bb07FvPtpfgyT9
         kRdgsIfyvFiqCKuo3n/+uBk9Su/QIQ7+rlCrg=
Received: by 10.90.69.14 with HTTP; Mon, 5 Apr 2010 19:43:49 -0700 (PDT)
In-Reply-To: <7v1vetmrl1.fsf@alter.siamese.dyndns.org>
Received: by 10.90.19.22 with SMTP id 22mr1862204ags.67.1270521849245; Mon, 05 
	Apr 2010 19:44:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144086>

Hi,

On Tue, Apr 6, 2010 at 4:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I would think that INVOCATION section needs to specify how the helper is
> selected (e.g. taking "frotz" out of "frotz::<some info>", or using the
> configuration variable remote.origin.vcs), and where the one or two
> parameters given to the program come from, to help such a developer who
> wants to add his own remote helper.

Junio: I think the first revision of my patch [1] is more along these
lines. I prepared this revision after Daniel Barkalow's comments [2]
and [3].
Daniel: Could you please comment on this?

-- Ram

[1] http://article.gmane.org/gmane.comp.version-control.git/143434
[2] http://thread.gmane.org/gmane.comp.version-control.git/143438
[3] http://thread.gmane.org/gmane.comp.version-control.git/143483
