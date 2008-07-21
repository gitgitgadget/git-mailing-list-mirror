From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 1.6.0-rc0 tagged
Date: Mon, 21 Jul 2008 01:26:12 -0700 (PDT)
Message-ID: <m3k5ffwsma.fsf@localhost.localdomain>
References: <7vd4l7wyfl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 10:27:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqjj-0008Ox-Rn
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbYGUI0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 04:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbYGUI0Q
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:26:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:63603 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbYGUI0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 04:26:15 -0400
Received: by ug-out-1314.google.com with SMTP id h2so216548ugf.16
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=hH6m/KwgHXO1M3MUsHuekWTJ95igU2+9DTZV4CXYyBI=;
        b=rY6UkrbI2fAsNS/21EUaTtkfvNnWL0Y4GQVZa6HMtN5avvXKSUjXnSYWayv6BILHAM
         kBm+51+zwp5e1gIr2b/5s4F8cCLPz4zqmGnvHbdVb5cjfT0yxJq8tHQyBH6JLKSa+vG+
         nuLF1vkxl4Hpix4EOCUUbqB8/S56A5ISV9tq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=DW0G5N5MrjCQoOM/73Yb9D+cte89lY2Lo3MmUIG57AldBIOh2fZPUjNt3q2KcQbjwl
         eKuVcfN3GPt/na/g9Wole7F88dNhfjs4g3t6psqAyrIUJqdsdF7Bt7Ggo038WuhwvYSj
         oqQoipZhi64HPZ78wmhvAFlhhYrRPYkFqzlyY=
Received: by 10.67.98.15 with SMTP id a15mr1448459ugm.15.1216628773917;
        Mon, 21 Jul 2008 01:26:13 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.212.51])
        by mx.google.com with ESMTPS id 31sm7122023ugg.36.2008.07.21.01.26.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 01:26:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6L8Q7lQ012232;
	Mon, 21 Jul 2008 10:26:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6L8Q5QQ012229;
	Mon, 21 Jul 2008 10:26:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vd4l7wyfl.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89322>

Junio C Hamano <gitster@pobox.com> writes:

>  * The ".dotest" temporary area "git am" and "git rebase" use will be
>    moved to $GIT_DIR/rebase.  We might change it to $GIT_DIR/rebase-apply
>    which would be more logical name before the final, though.

Very good idea.  $GIT_DIR/rebase looks slightly strange with git-am.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
