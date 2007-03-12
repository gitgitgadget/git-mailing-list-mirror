From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add an empty line before signed-off-by
Date: Mon, 12 Mar 2007 16:25:45 +0000
Message-ID: <b0943d9e0703120925k17fb9cabt6b43e371433dfc9b@mail.gmail.com>
References: <20070309225959.20959.32505.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQnLN-0007A0-IC
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 17:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXCLQZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 12:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbXCLQZu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 12:25:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:25596 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030502AbXCLQZt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 12:25:49 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2298073uga
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 09:25:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fyZmACgsQc64NvZSa5qBPc7i1UNz4JZWjNQkIa9QgLLd8NeJVBru+u7Gxt65/dblizPtRarIQUU6+Uff83DLVDK3Z1aGg0LUX6G4LVBzyz9M51MyP3YJS45JYzCvrXcU/kvMyP963ZKNA5pAlc+b2HAGq69utglj3wlrg/5cJbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jEUs3EXq7OS8Pn+mvlxz6olcrUN7dT2+4tT/YbAjDCg458Nu0i+Tzgl3++3RwvgvPP8Hvq8VTJ/9b4MW6oUFtoYz0wVdVAD8Eo+Zm4LUPm5W59OOh/gC5yd9my78JE6a3A1FDHSV9JApo6qia9fTJMGHQ+4/eF0g3GcBLNk6qaM=
Received: by 10.114.110.1 with SMTP id i1mr1793754wac.1173716745396;
        Mon, 12 Mar 2007 09:25:45 -0700 (PDT)
Received: by 10.65.96.9 with HTTP; Mon, 12 Mar 2007 09:25:45 -0700 (PDT)
In-Reply-To: <20070309225959.20959.32505.stgit@lathund.dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42038>

On 09/03/07, Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Default to the standard convention of having an empty line
> before the Signed-off line when addign a signature using the
> --sign option.

I mainly use this option to counter-sign an existing patch, in which
case there is no need for a new line. Maybe we need StGIT to be
smarter and check whether the patch was already signed.

-- 
Catalin
