From: Leonid Podolny <leonidp.lists@gmail.com>
Subject: Rebase with tags
Date: Wed, 29 Sep 2010 10:45:43 +0200
Message-ID: <AANLkTinQm8kVA_rCgX_SN=fX_2a0UU78aiOHr-YtO6zK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 10:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0sIq-0001yF-D1
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 10:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab0I2Ipp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 04:45:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46109 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383Ab0I2Ipo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 04:45:44 -0400
Received: by iwn5 with SMTP id 5so754521iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=iGaAwHOfwBgR1EvPNFVeppzIW8ZVJk1E6rK3+iOMfPU=;
        b=RAaWdL6sTbXunJfKBwdySVa7L6zMLRfYIhLHo4/zduuXOtt+SaCwI5SCbILUwsAFWB
         E4GciT/DvjF0qJEuWEx3koptc8tRbVICeQCQyfPUQuS0Sq7xp9IDZyoZcEbI4uctICMb
         Eq1j6FXSpMzpKYb6xYdTfHkGbtnCqjxQifJkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=t1Ws+/Ql8I4QxH6qtXPKVCHFD5CVFE3UvD0SjD47YXFxr9lme+t0grDfqU2MzvoaS4
         g8Qja8fntKph3UjT+lympgfNq+fFTtzKSd9nPxsUFtahI7WntfIycfGMYedFjHVqrq3d
         f+XKkG1NIyKX+JUSgiOMeBxzpek0h4d+S4Opo=
Received: by 10.231.192.80 with SMTP id dp16mr1450189ibb.39.1285749943932;
 Wed, 29 Sep 2010 01:45:43 -0700 (PDT)
Received: by 10.231.130.141 with HTTP; Wed, 29 Sep 2010 01:45:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157546>

Hi,
I would expect this question to be asked dozens of times already, but
surprisingly I can't readily find an answer.
Is it possible to transfer tags to a new branch during rebase? I mean,
during the rebase process, when git applies a tagged commit, I want it
to transfer a tag to a new commit.
Is it possible, at least, to receive a set of (old commit, new commit)
pairs, so that I will write a little script that will do that for me?
