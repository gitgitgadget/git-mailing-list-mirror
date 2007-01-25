From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: How to change merge message ("weenie commits")
Date: Thu, 25 Jan 2007 17:05:46 +0100
Message-ID: <8aa486160701250805y1b4fa78bj96fd7a137089824d@mail.gmail.com>
References: <17848.54065.631799.755255@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 17:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA76n-0000rx-4Y
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 17:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbXAYQFu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 11:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbXAYQFu
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 11:05:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:59085 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030248AbXAYQFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 11:05:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so491494uga
        for <git@vger.kernel.org>; Thu, 25 Jan 2007 08:05:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZATe72wU0VfO7BYIj+CD7kWDBmfjuA+aBCN1N6dYaIZ9fcuOW+NueYXLzi37CnnFaemexv/z54uWcVWoOHukYsYN9TUX3ftfRGxUnTkC0IfF/kmgHb1QMZcXqNNaVef7r6tn0QZfMEofaDWdldv5hXy+WGUEkvNC3j1ZhgJYui8=
Received: by 10.78.158.11 with SMTP id g11mr867290hue.1169741146635;
        Thu, 25 Jan 2007 08:05:46 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Thu, 25 Jan 2007 08:05:46 -0800 (PST)
In-Reply-To: <17848.54065.631799.755255@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37731>

On 1/25/07, Bill Lear <rael@zopyra.com> wrote:
> So, when I merge my topic branch onto master, for example, I'd like
> the commit message to be something more thoughtful than the
> "checkpoint 1", "checkpoint 2", "fix typo", "redo sort algorithm",
> etc., etc., and be more like a short set of release notes, a summary
> of what all has been accomplished.

I think the --no-commit flag to git-merge/git-pull (man git-pull) is
what you are looking for, or a git commit --amend.

Santi
