From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: pulling git -- version confusion
Date: Mon, 9 Nov 2009 08:51:34 +0100
Message-ID: <fabb9a1e0911082351o326b205aic205552faae4e4da@mail.gmail.com>
References: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com> 
	<fabb9a1e0911082237x462b1203v724b51e309a2d89@mail.gmail.com> 
	<f46c52560911082345y71eb12c9w114b799d70720dc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 08:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7P2f-0006pM-5v
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 08:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbZKIHvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 02:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbZKIHvu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 02:51:50 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56126 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbZKIHvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 02:51:49 -0500
Received: by ewy3 with SMTP id 3so2858643ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 23:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=nB1u6oNFezWx5WyIc9RV9fTCcQ3TURiq5PFrT1bhJJw=;
        b=rmNSyXc7eIAIVcAMqAZP7g4CHBIHceRYlKOj+wYvyPpFRxn0LDDF4yljjVKk9vbu2T
         Bj2NWnK6JBPuKMa0OLk+FSE4H1rykVnHHTIffNm0L5MkWoOZoKNgKaku9w/0w2UIMJPv
         NdOFvzx53G/Y4kx1NfLC3lmd3AP/iyWbcIcOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=K0oEDYFU7JQgnDCZUQ/PnEm2aseAQ23R7x7bZnooL1oKMrs8dqPS1rcGIpjdHOF055
         jHhZ8UBd46d8oFZNJlvin2IQO2hGZQIziOCK7bkoiNnRNpvydMAfznViQIR7njY9wN0F
         Oi+itp7f871oYShedGkV+xZ40iAnpXuaUR24o=
Received: by 10.216.88.15 with SMTP id z15mr1027808wee.113.1257753114310; Sun, 
	08 Nov 2009 23:51:54 -0800 (PST)
In-Reply-To: <f46c52560911082345y71eb12c9w114b799d70720dc6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132447>

Heya,

On Mon, Nov 9, 2009 at 08:45, Rustom Mody <rustompmody@gmail.com> wrote:
> Gives me
> fatal: ambiguous argument 'origin/master': unknown revision or path
> not in the working tree.
> Use '--' to separate paths from revisions

Well, as what remote do you have upstream configured?

What is the output of
$ git config -l

-- 
Cheers,

Sverre Rabbelier
