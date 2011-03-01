From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Tue, 1 Mar 2011 16:44:13 +0700
Message-ID: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
 <4D6B6A8B.20709@drmicha.warpmail.net> <4D6C20F6.3070905@cisco.com>
 <4D6CA8B7.5000608@drmicha.warpmail.net> <AANLkTim78nQgS7NPXWErQyrqmt41OUXY6gzJmMwjtxo9@mail.gmail.com>
 <4D6CB45F.1030800@drmicha.warpmail.net> <AANLkTik1_f7s0OUK9Q-BER9RkOdWiB=ZeN76HnCgmj+3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <hordp@cisco.com>,
	David Chanters <david.chanters@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 10:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuM8P-00072D-SI
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab1CAJop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:44:45 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61435 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab1CAJoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:44:44 -0500
Received: by wwe15 with SMTP id 15so4194137wwe.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WnOGHsIXwqLROgPZY4SjFbT4QgFYemMBQn+fKJuNYnY=;
        b=rbZMglg6K2fWSMfU9NyjwSOll6H+YWrLy2K7fSq3mqO24k27fVZG8RlUo3WI9VUf39
         4+90bBbb6skp5AyoZKBCXL02QNhM55bROh7GNKNoxLCFt93/jQDu4jG9vOtR6pTND92Q
         OnUAh/nKkT+rOWZInjEfODOnWG//sf1fJdWVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KOeCUgIZJ6HgHxc8ykf9qyRjZfQx7yLt5LMEgnUkFwwnppujZ+ejVCjLq7ttzwjV9R
         ReckNxdDf3jE2ygSEYrXTPV/QteMtRm3ySApGwvskZwG/1K3el2wUNzpVCcj89jXI+DU
         A9V0RGRhqJFOKhSVn+VJRbMM39GM9dnT+f6F4=
Received: by 10.216.163.69 with SMTP id z47mr5845061wek.43.1298972683079; Tue,
 01 Mar 2011 01:44:43 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 01:44:13 -0800 (PST)
In-Reply-To: <AANLkTik1_f7s0OUK9Q-BER9RkOdWiB=ZeN76HnCgmj+3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168203>

On Tue, Mar 1, 2011 at 4:32 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> No it was in next or pu for a while, then got dropped out. I don't
> remember what "what's cooking" mail though.

I got it, 1dbdbcb (What's cooking (2009/12 #04)):

+The interaction with this option and pathspecs need to be worked out
+better.  I _think_ "grep --full-tree -e pattern -- '*.h'" should find from
+all the header files in the tree, for example.
-- 
Duy
