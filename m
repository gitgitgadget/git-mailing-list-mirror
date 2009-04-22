From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn init/fetch: wow that's slow
Date: Wed, 22 Apr 2009 11:55:46 +0200
Message-ID: <fabb9a1e0904220255w55c8fee1uf534aad07cefa818@mail.gmail.com>
References: <E26B8975-74D3-4F01-A9D9-DAAB96C8FC85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 11:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwZD7-00083W-Oi
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 11:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZDVJ4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbZDVJ4G
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 05:56:06 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:54591 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbZDVJ4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 05:56:03 -0400
Received: by bwz7 with SMTP id 7so2235119bwz.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YqOEhGKV2zJfc04AHGiPAaw7oed8xUOwO0TYWuWzous=;
        b=QZkQKb0VDKzMqmlkuEO0QpxfeHp1P+xVn4p8rHF+iy0BRkjXccyx0Q09urC6OGCfoN
         3w5J4sUNocPzD32C7yaAEWkZ/7eVMvfOEB+bopph6jvx4Uv/pzCaq1JBEpNRBXpV7jqc
         6PpTZL4OrWveTu1T9lv6KnIcnZaaI/tAawcUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dM0GJS9nDisAEN8kH8ypQ4kbFVdb4ZThqBz+YQ4UoBILM+gLULh7xseYOJSRZXdD01
         1KbfFrsRlAPPF0NFgwdNnhbUU9kVPf3nT63OZCgViAtLLWuvlV0bGxsiX0+FE6/kgtZt
         y2R0It4OVkL/S09YPDx5l72JQtkVWZQBykPsI=
Received: by 10.103.214.8 with SMTP id r8mr4419742muq.6.1240394161120; Wed, 22 
	Apr 2009 02:56:01 -0700 (PDT)
In-Reply-To: <E26B8975-74D3-4F01-A9D9-DAAB96C8FC85@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117186>

Heya,

On Wed, Apr 22, 2009 at 09:40, Lachlan Deck <lachlan.deck@gmail.com> wrote:
> Okay, so I'm using git 1.6.2. I assume this is all a 'known issue'. Has
> there been any work / plans towards improving this?

This can be improved by using svn 1.5's delta feature, however, Eric
(the author of git-svn) does not have the time to do this, and no-one
has stepped up to do this.
A workaround is to not clone from r1 but instead start at a more
recent revision.

-- 
Cheers,

Sverre Rabbelier
