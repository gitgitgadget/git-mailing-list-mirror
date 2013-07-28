From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 14:54:49 +0530
Message-ID: <CALkWK0n-a8XB_ZRmQBTxq2DQ79VfPYyuvPBsi=Zrf_ThzUsoyw@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
 <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com> <20130728050009.GA10844@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 11:25:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3NEW-0001JD-6y
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 11:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab3G1JZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 05:25:30 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:55753 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab3G1JZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 05:25:29 -0400
Received: by mail-ob0-f173.google.com with SMTP id er7so7240475obc.4
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kFAwdv4A/0Kf1+dGwRFBXtXgPyNMxtiYHdqXNAujFzo=;
        b=FIFvgd2weSqMmKMJYbca84Qvwtj3CGIsdaePX4pSbk50DeLX4r1gDKfuAXL7+CuNPL
         CiPCbwA+04xQon8YQOqRVnM+loBFnTvb+BxdhbVloa51CqwJ3gcudQH2Nk25PLKhW1k+
         /gXBOTA29j6YMo6JXnagURFUfAVTkOUOqOSxXHo2wbrsCjjLbuoLuWG/X5eD9/3oHwaI
         3rwLJJFta34pvVTm+QCHOAjIkDlBZQVsoSFBNfH0UOP65HbDTLB/qkrQ2/QJ5ET/N+ft
         ObSp7OyHX9cjyVZDu5yUJhC1w2dDPAUCxbOpMIfHpp+YdbXvXBjp/6VEbSU7j7ta7lpp
         mCKg==
X-Received: by 10.50.6.16 with SMTP id w16mr566307igw.29.1375003529295; Sun,
 28 Jul 2013 02:25:29 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 28 Jul 2013 02:24:49 -0700 (PDT)
In-Reply-To: <20130728050009.GA10844@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231265>

Duy Nguyen wrote:
> How about something like this as a workaround for emacs?

Even if we do manage to patch Emacs now, we still need to support
older versions: so yeah, this is an urgent candidate for maint.  I'm
waiting for the word from Emacs-Devel before writing out a commit
message.
