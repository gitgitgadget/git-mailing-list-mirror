From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Created branch in wrong place... how to fix?
Date: Wed, 01 Jun 2011 06:32:24 -0700 (PDT)
Message-ID: <m362opy8xz.fsf@localhost.localdomain>
References: <BANLkTingMK3Zv6NZdFAiLXZzJpSZYZmjQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 15:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRlXT-0001IG-Sl
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 15:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab1FANca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 09:32:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57046 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758915Ab1FANc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 09:32:27 -0400
Received: by fxm17 with SMTP id 17so39210fxm.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=7WIjSxI5BoF+M9gm4MYETU3gBiFRGk1Rkr0/HXPxYBw=;
        b=X8A7d4WxnT1OAgK7lRP4vvvlSNKbWnl31S6pfAqme3iylNCvd9sV6cGRVoV7+JWpRq
         rnUh93f8/4+Mw+MELVJqJccspI7U5+JoYoHP2ZVgXz3NpUrw1UjDGJA5vITkdQasQcOv
         MsUzHXhpKm58XtopPxT1J3FrsgrBRikbxcEAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VA2PNT6v4jvu2iUuDX8ZrTsZ3vPR9JJFWKc/8hrj/Xxe+77xMk1t8xUgupxTVdShof
         pAw1VHdezYUt1u6sDn8S9hDKehf5b2sR0ZvzkdBwlUMWl9B69Zn1ffB706Wp2mCZJyBc
         C7Gpvj3XIBdT+fwVLAF+7rpvTrfeCdKGopHlY=
Received: by 10.223.55.78 with SMTP id t14mr49082fag.43.1306935145876;
        Wed, 01 Jun 2011 06:32:25 -0700 (PDT)
Received: from localhost.localdomain (abwk140.neoplus.adsl.tpnet.pl [83.8.234.140])
        by mx.google.com with ESMTPS id n7sm416598fam.19.2011.06.01.06.32.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 06:32:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p51DVqMR014376;
	Wed, 1 Jun 2011 15:32:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p51DVaL9014372;
	Wed, 1 Jun 2011 15:31:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTingMK3Zv6NZdFAiLXZzJpSZYZmjQA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174867>

Howard Miller <howard@e-learndesign.co.uk> writes:

> I created a branch in a project and did a series of commits. I now
> discover that I really wanted to make all those changes against a
> completely different branch of the same project. There shouldn't be
> any issues as the branch introduces entirely new files (no changes to
> existing code).
>
> I'm struggling to see a way to do this without loosing the history.
> Some Google'ing suggests 'rebase --onto' but I'm struggling to see how
> this works or if it is appropriate. Any pointers much appreciated :)
> Thanks.

This is decidely work for git rebase:

  $ git rebase --onto <where it should be based> <where it is based> <branch>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
