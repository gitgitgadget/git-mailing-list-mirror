From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 7/7] git-stash: use git-reflog instead of creating files
Date: Mon, 29 Jun 2015 14:03:02 -0700
Message-ID: <xmqq381a9qih.fsf@gitster.dls.corp.google.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-8-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 23:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9gCs-0003WJ-Oo
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 23:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF2VDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 17:03:06 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34199 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbF2VDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 17:03:04 -0400
Received: by igcsj18 with SMTP id sj18so90551176igc.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=The1FKmUecHeIIr/K9d3iVi5TLzN4bcpWahkQGXaLs0=;
        b=r31hq8ruZP0W0wYtQi7q7hkVeR6QWbpcgvLeZGlpHKscZOaUUWUeWM/X1hxpmNQLed
         RsG5fgTX4HiRRY2x6botQN8fcXyjyy6tXEImfd2ydBINtQGKtpmHmgg654lbI01YkjbV
         tHtpenVboN95jPGMvK1b9fxKThbBlYQhAUkuAjrefj1at33MawiK3yfLWVwFEwPufDxk
         TnxznaSvFbhjdwS4W+wzAdfIySRQrfKIYZDAjNoxB68yQNKecKW/Kx3tMGSDalQIn9zA
         OFnCOovo+y3oNfTGa/esOgZu15Df8aJdk3yOYlMXp8FH9omr73oI65cVrAYqbNBTVWKA
         ZeYQ==
X-Received: by 10.50.112.73 with SMTP id io9mr19514382igb.18.1435611784175;
        Mon, 29 Jun 2015 14:03:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id g12sm28567593ioe.28.2015.06.29.14.03.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 14:03:03 -0700 (PDT)
In-Reply-To: <1435609076-8592-8-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 29 Jun 2015 16:17:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273020>

OK, I'll squash in the last bit and restart today's integration run.
Everything looks much nicer than any previous versions ;-)

Thanks.
