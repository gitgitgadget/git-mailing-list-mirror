From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Thu, 30 Oct 2008 00:38:03 +0100
Message-ID: <bd6139dc0810291638r5cabd3c8uca83687bc314ca2c@mail.gmail.com>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
	 <alpine.LFD.2.00.0810291922320.13034@xanadu.home>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:39:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKdH-0006Rl-Cf
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYJ2XiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbYJ2XiI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:38:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50308 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbYJ2XiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:38:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so240148fgg.17
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ow56dq+OTYSEzJs4YbTOZZeqzES4srhoSkfGMlN5X78=;
        b=kmZx64s7LgqK3HPdtAI2lN5Ez0yf9n2czuLM0LRl7y+PIPZCWxYODb0SB5o6+PaEoT
         nP5wEK2J+mAHOh3H8ZB/pe4/fzOy3870J5HQ34W1aKw92VMykwaTM5fZnBRQdUDjX3Vk
         9pLDvOigjoy0MXTbU9YuLq8fjHpUCtYbrY2+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=FJDtKsJ0UAaNk6g2WK1zGa1ukixaOEx09U4+y2c5DA3W6aFYaBy6yXZ+xsJdqXk7pA
         F9ne/7FOMgL1V425LeSP7qbY2/MWlgf3I0EMSLqYMWnrUYyMLFT8E8n79PHMZZlKezvh
         pOIN7UxdLYsPdD5hoqUuRg8Dm8NjAKN/cre4I=
Received: by 10.187.223.14 with SMTP id a14mr918933far.66.1225323483447;
        Wed, 29 Oct 2008 16:38:03 -0700 (PDT)
Received: by 10.187.213.8 with HTTP; Wed, 29 Oct 2008 16:38:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810291922320.13034@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99436>

On Thu, Oct 30, 2008 at 00:31, Nicolas Pitre <nico@cam.org> wrote:
> If those are not significant enough to have a proper description, then
> I'd suggest you use 'git rebase -i' and its "squash" command to fold
> them into the appropriate commit.

They are there because the work was done incrementally, having them as
seperate commits shows when the changelog was modified. Having a
description for a change to the changelog is pretty senseless, since
it would be the same text as what is in the diff.

That said, sure, I can squash those commits no problem.

-- 
Cheers,

Sverre Rabbelier
