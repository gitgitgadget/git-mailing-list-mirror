From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 01:43:41 +0100
Message-ID: <bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michal Nazarewicz" <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 01:45:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzKtl-00020C-Qs
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 01:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbYKJAnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbYKJAnn
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 19:43:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:65083 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbYKJAnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 19:43:42 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2056005fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bOV8WF4EELIxeHeX04xVWGTPorQCcf61w3UZw+uTgek=;
        b=i3bPzIyMdf7FsuEefb/XiaZZl27rH2MgmKBftgHGOQfXf76EWOyzPJLL1BVoBap/uf
         TZCaCN08HQ6oSUdzgmS5uni2ikUjEhTfs9ANpRIaWnx6NV7dE1tstX/35lc7hwnUsgbH
         EflgYvBAKmfhmZoes4f4fewT2ryNTdeHq7+u4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=OniNv6ZW/oS6150XhLs9DZlp5YByvuXGa0DV6s/n3qSP/Z5yosWMJTx352igmPjDk/
         B9PoWpRS0hS6Vu+2ixE7X1Gc5PLT20jdA2Vrd2v39ZSx+7K9eKjl4O6eRcNw8BJ5Fk6W
         lxmliQkZIPl28/4Fd/zIZq0uU/HD83PzyVPlY=
Received: by 10.187.213.16 with SMTP id p16mr1526870faq.0.1226277821234;
        Sun, 09 Nov 2008 16:43:41 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Sun, 9 Nov 2008 16:43:41 -0800 (PST)
In-Reply-To: <87ljvsjuq7.fsf@erwin.mina86.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100483>

On Mon, Nov 10, 2008 at 01:22, Michal Nazarewicz <mina86@tlen.pl> wrote:
> Now, what I need is such feature in GIT.  Upon committing I would like
> some magic string (say "$Date$") to be replaced with some value
> identifying uniquely given version of a file (a date of the commit would
> be sufficient).

Please have a look at the relevant entry in the faq [0].

[0] http://git.or.cz/gitwiki/GitFaq#head-4a0afe71a2bb7734777a8b0b345e0308aefdbd40

-- 
Cheers,

Sverre Rabbelier
