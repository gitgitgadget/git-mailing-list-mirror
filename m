From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] http-push: send out fetch requests on queue
Date: Sat, 30 May 2009 18:52:07 +0800
Message-ID: <be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
	 <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	 <20090530093717.GA22129@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat May 30 12:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAMB7-00076H-76
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 12:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760509AbZE3KwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760521AbZE3KwI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 06:52:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:65300 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760509AbZE3KwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 06:52:06 -0400
Received: by wf-out-1314.google.com with SMTP id 26so2230133wfd.4
        for <git@vger.kernel.org>; Sat, 30 May 2009 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QdVCR4zhuA7VhH4DacgmATSBKqx2ziCcq7oC5sG2G10=;
        b=KSQw9EMjJP6j1V2SBadN6IY+3v9V9j/D+BlByfdui95LY7GKbeKrfERNOVzpnOMStU
         YTM7mg5vWsAgyKOjr8MaQ3CIaRjz5zorR6ItGXlIOb67OI/T/FH/pT4/3HngO5oVBtir
         dC5pBujwRzLm6zuirt4oic3bM0dNusVOIA8Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eO9zKXCqgp5so+EzXE7Eb9X1YNa9XecolnN+343EbJpz6SXYQCNaQiwcco6gvvtznM
         3J1wKzYWPkuscBhqG3cyzaQ0k9dV1o8jtq7UJfXAnou9ryeDXNBC9AmtI3fUutaa91H4
         +qzwsd4ScpJe8H49M/iv1dgwiwEgLhTwEg6DA=
Received: by 10.142.169.4 with SMTP id r4mr1233593wfe.105.1243680727982; Sat, 
	30 May 2009 03:52:07 -0700 (PDT)
In-Reply-To: <20090530093717.GA22129@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120347>

Hi,

On Sat, May 30, 2009 at 5:37 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> Sure. The same thing happens.

curiously, I wasn't able to reproduce on my cygwin setup, but on my ubuntu box.

-- 
Cheers,
Ray Chuan
