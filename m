From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 02:26:03 +0330
Message-ID: <4d8e3fd30802241456l6c02a040te21643c830cf0e46@mail.gmail.com>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Goerzen" <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:56:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPm3-0005FY-9X
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYBXW4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbYBXW4I
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:56:08 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:4012 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbYBXW4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:56:07 -0500
Received: by gv-out-0910.google.com with SMTP id s4so475541gve.37
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 14:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wGHP2+DMBT7nZhpKI7kOOhXTKWJFIc4cBAsa0XSlIrA=;
        b=IDOqtSlcd+/7HIUp8XtiuiniUH3+xT7ygDlQq7Ud7lGzddIz1npKA34de+i4bz22v65P0Mfk67+koU+/y52WjMCVnbqRHj0XEW7Zh4CFFm9QfSIuh37fISQK7c4rBG2vGsAsLig7zIhrjgvYWFwKzM9kDiQtjYzLMtczpVdYW8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=anYOv4h64QcYZGuZPaZlNNIizFBwRtBy9b+gxIcG/SqGXpQPZD9RUZJFCv6tAjHUz8H6MUYdAYACxR0WCGnNTwlkdCfk/O/rp6rQcZ25O2eG9IGhxuKXlb45cu5N3aODIcygRXBnkdIiasdgKXrAfnBh4lZUtCD5CR/NDCY6uTw=
Received: by 10.142.226.2 with SMTP id y2mr1624475wfg.46.1203893763761;
        Sun, 24 Feb 2008 14:56:03 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Sun, 24 Feb 2008 14:56:03 -0800 (PST)
In-Reply-To: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74974>

On 2/25/08, John Goerzen > Would it also be possible to unify
git-format-patch and
> git-send-email into a single command that generates and sends the patch(es)?

I can't think of how to unify the commands from the ui point of view.
What do you suggest?

However, i like the idea of a --send commad line option to
git-format-patch that calls git-send-email to create and send the
patch series.

Ciao,
--
Paolo
http://paolo.ciarrocchi.googlepages.com/
