From: "Kevin Leung" <kevinlsk@gmail.com>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run without sub-commands
Date: Fri, 30 Nov 2007 17:09:58 +0800
Message-ID: <e66701d40711300109nc43f3efyb33e591af15a060b@mail.gmail.com>
References: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
	 <20071130084131.GA29668@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 10:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy1tA-0002Ta-Qv
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 10:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbXK3JKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 04:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXK3JKE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 04:10:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:24865 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbXK3JKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 04:10:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1887431ugc
        for <git@vger.kernel.org>; Fri, 30 Nov 2007 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fRuBciW4nUTmq/6a1Y3oGySwu0HJBS+IvGzp+AKRDGA=;
        b=M/QfUxcNNyLpaiD1ZBthLKQbw0sbl5vSbdTzAfl04W8X8qWSdgOOApQCSsjjEplETT3EgkJFq0aaHx0r17O9MeUqNKFIgQOFmxqGPyicCF+ehDaJNEA4i2V8ud57FzLegH8eCrUS114+sCoDGyxEEdaULV0qLy34W1/mP5faZdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oCyFZaFOB1CADPmLValRYkyt1uiL6qAHWBjjlqor8vBbryLoqcKaTOg84Y30GMDjEAHvIjuZE9gs0WZA5XN49GvGq1Jhx0gYcdFywsDqCeEiTPvNrGOUpKJ27vfSHg/SY2OF9njpuPk+XPPkJpGLfzUgcfg1C4uj/iFYYBW96Gc=
Received: by 10.78.145.14 with SMTP id s14mr3419944hud.1196413799029;
        Fri, 30 Nov 2007 01:09:59 -0800 (PST)
Received: by 10.78.57.2 with HTTP; Fri, 30 Nov 2007 01:09:58 -0800 (PST)
In-Reply-To: <20071130084131.GA29668@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66626>

On Nov 30, 2007 4:41 PM, Mike Hommey <mh@glandium.org> wrote:
> Still, 'git stash' alone should *do* the stash.
>

How about `git stash' still does the stash, and `git stash llist'
exits with usage message? And if you want to save the stash with name,
you can only do it with `git stash save name_of_stash'.

Kevin Leung
