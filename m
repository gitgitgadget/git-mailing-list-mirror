From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Tue, 17 Feb 2009 08:13:34 -0800
Message-ID: <8c9a060902170813ie8f5bc1gfed53e4f31f64c23@mail.gmail.com>
References: <20090217011256.GA23314@spearce.org>
	 <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>
	 <20090217151838.GI18525@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZStI-0006je-Nt
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbZBQQcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbZBQQcL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:32:11 -0500
Received: from mail-qy0-f26.google.com ([209.85.221.26]:61432 "EHLO
	mail-qy0-f26.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZBQQcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:32:10 -0500
X-Greylist: delayed 1114 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Feb 2009 11:32:09 EST
Received: by qyk7 with SMTP id 7so993344qyk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aK6EXQL3sjLUaLMZrNoyA8wzoVZP1N8or6IbbhqOTRM=;
        b=I0ukH+D6LNuGw5rkTj03usVYqYm0jLOFEjDzCpVBJo6W/7kVUyySY/PAQUkSGD3K9X
         wsC1uQTpeibUqydZaeB9IVjcW6ydFi/mGlvE8YJpUy0VUhf6mFLg42V0qQhFE81psamj
         H8TSZI1aplXtf54gck61CRP/kZhoZD5BqkaxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wi8v8z5SLLa0cPoHZrArxPUF8lswHMxk0y5SJX0+XKxRAfYgLTivDcR56BDZM7tPQT
         kNWGEkysGcyqUqR2bx0HOh+A1XOLXEmcjs6o9vJkbcrIvIaqJxupFQmmOpK9UDsQM3h3
         rfeoI7hCR44B6hjQfLGymQSABpegMVo1+Ua+E=
Received: by 10.224.2.202 with SMTP id 10mr10388284qak.336.1234887214212; Tue, 
	17 Feb 2009 08:13:34 -0800 (PST)
In-Reply-To: <20090217151838.GI18525@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110406>

On Tue, Feb 17, 2009 at 07:18, Shawn O. Pearce <spearce@spearce.org> wrote:
> Gerrit is known to not work in Internet Explorer.  As an open source
> developer, my primary desktop system runs Linux.  My portable laptops
> all run Mac OS X, because its shiny.  I have no system capable of
> running Internet Explorer, nor do I desire to send dollars towards
> Redmond in order to obtain an OS license in order to do so.
>
> Something is busted in the IE AJAX code used by Gerrit Code Review.
> I'm guessing that instead of making the data available to the AJAX
> callback, IE wants to save it as a file on disk.  No clue why.
> And due to the lack of IE, I am unable to debug the problem myself.
> I am waiting for someone who really cares about using IE to debug
> it and contribute the patch back.
>

I've found IEs4Linux helpful for debugging IE-only issues under Linux.

http://www.tatanka.com.br/ies4linux/page/Main_Page

I don't recall, off hand, if it'll provide IE 7 (and the site isn't
working for me right now, so I can't confirm this).  It does provide
IE 5.0, 5.5, and 6.0, however.

-Jacob
