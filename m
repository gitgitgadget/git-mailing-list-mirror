From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [JGIT PATCH 1/1] Invalid test preventing a build using maven
Date: Mon, 16 Feb 2009 19:05:23 +0100
Message-ID: <bd6139dc0902161005x32e6ddccs8cbf9a825fa26c50@mail.gmail.com>
References: <85647ef50902160946m480542a3m1511366f6cafe04e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:07:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7rp-0002cI-NO
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZBPSF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbZBPSFZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:05:25 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:15386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbZBPSFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:05:25 -0500
Received: by fg-out-1718.google.com with SMTP id 16so274619fgg.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 10:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=K7goSUP2Seqferhi/n76pzg45Am6bwvsst8a9pYWeXs=;
        b=xbdDQfVE7Trm/AZMvXFdKKGozdqdIZPl4QZhzRBpuopEuQbirNNQDiP6zlssruXfQ3
         ZSoGjFUThxL9YCHBZgSb1ytZ+mXrhymDoWp7CzxZq4w/XW2vmMJwOp6lxHKB6AoYKc4V
         AF6yZgaptXcqhmMpa0hV2047EB4VcUbeEwLQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=dc/ycttgdPbpKE77Ec1DnX8tgH57CubgJNac9QqWStLa9wh0xYZhvG69kHBr5dATsz
         ygNI/IQGan46lN9PXPlD/wB+pb7pqApjpttHfyMPxL3KbXCMuXeNC0dPehF653Hz1pYX
         Mr3vTZCkUIqkLsG+9wseaFRfRCI+anMdmCpmY=
Received: by 10.86.94.11 with SMTP id r11mr1611867fgb.11.1234807523465; Mon, 
	16 Feb 2009 10:05:23 -0800 (PST)
In-Reply-To: <85647ef50902160946m480542a3m1511366f6cafe04e@mail.gmail.com>
X-Google-Sender-Auth: a315f95227816524
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110220>

Heya,

On Mon, Feb 16, 2009 at 18:46, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> The attached patch ensures that correct UTF-8 character sequence is
> used in the test.

Please follow the guidelines to submitting patches as described in
Documentation/SubmittingPatches (available online at [0]). Doing so
will save the maintainer (in this case Shawn) the time required to
munge your patch into an applyable format. Also, your commit message
is funny in the sense that part of it should go into the actual commit
message, and part of it should go after the triple dashes (also
described in SubmittingPatches).

Good luck :).

[0] http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD

-- 
Cheers,

Sverre Rabbelier
