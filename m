From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: New mailmap file for the kernel
Date: Mon, 28 Jul 2008 13:11:13 +0200
Message-ID: <bd6139dc0807280411k3a283c5dr4b874342aab167dc@mail.gmail.com>
References: <9e4733910807272145y5b67112er4b90cc36141663c1@mail.gmail.com>
	 <alpine.DEB.1.00.0807281251000.2725@eeepc-johanness>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 13:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQeF-00006B-GG
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 13:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYG1LLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 07:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYG1LLO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 07:11:14 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:63442 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYG1LLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 07:11:13 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5664078wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 04:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=oosEmoJ6mGo2wP/RphzRRFMoz9nt0CBPcvciInneGKg=;
        b=ubj8h886A0/uE7jqkEwLKQ8hjvb22EqvJ8ctvAZ4Q5unApqpXG6t3B81s1zxlS1V2E
         oT1sMErWXx3qk5yABZyyQgh4hpZS/0jqeAFyu6xEYFNVjs2JzK44v8ZImKXLSL0UYV05
         dmtmoXq1y1IrVLoAMLx3HfV+BFcjt0uqcxsAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=G7DEh2oWRFMtYlJ1NpSWrJPprAh3HwC2/66l1D5Z9d70OqqQv8cYSapuXpKyZKA+3X
         C4BZ2/KcTpob5vDG+frFtUFMphryy8wCmoT3S8QD2tjAiwqmZO1qCU2pVHGa9tdNI6sr
         JD+X6bpiiWHxFx+bwararJdV5uW/PKhyFtHG4=
Received: by 10.142.240.19 with SMTP id n19mr1553031wfh.12.1217243473200;
        Mon, 28 Jul 2008 04:11:13 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 04:11:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807281251000.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90440>

On Mon, Jul 28, 2008 at 12:53, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Unless somebody forgets, right?

Unless there is a pre-commit hook that prevents you from committing
when you are not in the mailmap. That should give enough incentive to
first make a commit that puts you in the mailmap before you start
sending in patches.

> Also note that in a distributed world, you cannot properly speak of a "new
> developer".

Yet we do it all the time on git.git ;).

-- 
Cheers,

Sverre Rabbelier
