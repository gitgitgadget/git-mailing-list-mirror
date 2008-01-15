From: "Chris Ortman" <chrisortman@gmail.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 14:30:28 -0600
Message-ID: <c0f2d4110801151230g5843df66t62fb659375a1680e@mail.gmail.com>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	 <478D1442.2090301@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jean-Luc Herren" <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:31:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsR2-0001U4-FL
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176AbYAOUad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbYAOUac
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:30:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:9078 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125AbYAOUab (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:30:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4531086wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 12:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/reCaa9/9J9IbeDK8WReuP/5TZpXqSbgxAvfLeQcSho=;
        b=UFvuNxwb4F9TpuM7DmyPe0We20rRaarif7giNRkpG8g7lq9AemJGULpO/PECn0VKMymO9WUIB72avUOiLjg9XGBLRZOZXKCQTBK/vkjN4mY+/L3ALBDHr+gr1a0R4omVmZaMX4tbspzAYtgWAOKZKrJBOZIUrAAcf32Jk1haQqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W4Pq4rwbr16RGlJZPMNjujWzx6IQxDn5+MHVFm8PhFmIeNPWYT7YlQTRkz1rZL06i8FxZvTr4U9qA+AWSBX60UZL1BMELFueHSDfvOm7lKQZKYh+CaA5st/+3o6NX0SSy1JQkZjTC0b6aNo86G7YgMFpsHk1BTiZTnGIQpWakVY=
Received: by 10.115.92.2 with SMTP id u2mr2195065wal.139.1200429028125;
        Tue, 15 Jan 2008 12:30:28 -0800 (PST)
Received: by 10.115.17.6 with HTTP; Tue, 15 Jan 2008 12:30:28 -0800 (PST)
In-Reply-To: <478D1442.2090301@gmx.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70553>

You are correct about Tortoise in that it is too strict.
I looked through their code and they have written their own patch
program which keys off these Index: lines
http://tortoisesvn.tigris.org/svn/tortoisesvn/trunk/src/TortoiseMerge/Patch.cpp

I think it could go either way as to if git-svn creates a different
format patch or tsvn accepts multiple formats, but I anticipated
git-svn would be easier to extend so I started here.
