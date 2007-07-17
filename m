From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [PATCH] git-gui: Handle git versions of the form n.n.n.GIT
Date: Tue, 17 Jul 2007 14:49:36 -0700
Message-ID: <31e9dd080707171449r26c430f1vacfb58eb00f578e5@mail.gmail.com>
References: <Pine.LNX.4.64.0707171244080.13359@reaper.quantumfyre.co.uk>
	 <20070717212103.11950.10363.julian@quantumfyre.co.uk>
	 <20070717214011.GU19073@lavos.net> <20070717214510.GV19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Jul 17 23:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAuvN-0003oj-V1
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 23:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbXGQVtj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 17:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbXGQVtj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 17:49:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:53239 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbXGQVth (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 17:49:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1660914wxd
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 14:49:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWcDjXq+zDZBZ7ZZzgEA/d6XgYCk1tEOAqVKltaIb/uRTIV1R92GkoGY+uPo8lk/IQfqh59iYKJqYjuJCT1mc73f5dsitjvXhAmreIKluri/22bE1TVx1Gb21FhSfyNMp8SEn3WtEyUT/yj8OI2T7lKAFLKljVdFy8yEsZfmHmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gn+RrwByhG+Ds/bGHhKaEQgEb1uWcm4+bJlUyLG2en74IU9FzTdFu/Mn+Vd2str8h22UQS5ljGu+x03Swl6ctY16f6GoK67pt43b97K/afds9aJfpuZNAHf8pKbwbQB7atD0cxZzomILzxdUmASbDzoIX2ADCQ7ASzkU9Deg6IY=
Received: by 10.70.48.15 with SMTP id v15mr1437948wxv.1184708976917;
        Tue, 17 Jul 2007 14:49:36 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Tue, 17 Jul 2007 14:49:36 -0700 (PDT)
In-Reply-To: <20070717214510.GV19073@lavos.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52805>

On 7/17/07, Brian Downing <bdowning@lavos.net> wrote:
> I take it this means that keeping your home directory under git
> /directly/ as I have chosen to do is a bad idea...

Interesting, because this is something I've wanted to do - I use
several machines (work, work laptop, home, home laptop) and I'm always
tweaking my various dotfiles... I could really use a way to keep them
all synchronized.

Just out of curiosity, what do you people do?

Jason
