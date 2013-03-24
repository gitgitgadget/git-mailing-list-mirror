From: Matt McClure <matthewlmcclure@gmail.com>
Subject: Re: [PATCH v2 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Sun, 24 Mar 2013 09:31:45 -0400
Message-ID: <CAJELnLEhcY4Oc-EB=Mi7PKBQQF+EiVpW_dNH6G-abjZj0MAdNw@mail.gmail.com>
References: <cover.1363980749.git.john@keeping.me.uk>
	<cover.1364045138.git.john@keeping.me.uk>
	<e44349728c07d8ae22d4b73527b1d124b49cc4a9.1364045138.git.john@keeping.me.uk>
	<7vd2up4bo7.fsf@alter.siamese.dyndns.org>
	<20130324123620.GA2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Mar 24 14:32:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJl1y-0007JB-2X
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 14:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab3CXNbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 09:31:46 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:45939 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab3CXNbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 09:31:45 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so275276pbc.31
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OsplHoB4dwc2KAoOqeRUxvgklsCYY1RchjDsYMlCJes=;
        b=wc75Ry3E+HVESWUrDmZbNrEyXmZl6236wIESwTz+NoEfEWd4qPkjaCjY3D8K/BrC8X
         /hHiGxeO/9NROIMNlRAQhT22g6IotbpRlnUfbk5Ilh57zFpE6zN0CBTVi9me3dqZTOVq
         NbzpzEepvgSIv/cLsJjlIcZ+NG+lwXNTgAFBnZOpSlx8zbuy+RLeXMOVkiGiiDm0KvV2
         qSBCaza0DcIlsBhHDQRnOPWc5qtBlebll8wYkYlBWQmVOMD5z9iNmB/RHVLZEjqdhPK5
         v/P/qyii2FQxsmLhO/Lt6PN+QnTFWY5UnkHisnuJxwy60eJKiV1AGtcXWfCHWjg/Umb6
         tkbA==
X-Received: by 10.68.138.193 with SMTP id qs1mr12517711pbb.9.1364131905385;
 Sun, 24 Mar 2013 06:31:45 -0700 (PDT)
Received: by 10.68.11.70 with HTTP; Sun, 24 Mar 2013 06:31:45 -0700 (PDT)
In-Reply-To: <20130324123620.GA2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218957>

On Sun, Mar 24, 2013 at 8:36 AM, John Keeping <john@keeping.me.uk> wrote:
> In the
> non-symlink case I think a user might find it surprising if the
> (unmodified) file used by their diff tool were suddenly copied over the
> working tree wiping out the changes they have just made.

That's exactly what I was describing here:
http://thread.gmane.org/gmane.comp.version-control.git/217979/focus=218006

-- 
Matt McClure
http://www.matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
