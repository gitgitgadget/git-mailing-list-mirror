From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Git Submodule Usage Pattern
Date: Tue, 16 Feb 2010 15:38:36 -0500
Message-ID: <32541b131002161238h5549882fv89ab90812b3e8131@mail.gmail.com>
References: <c115fd3c1002160639m113a3604wa6686bc613a7c202@mail.gmail.com> 
	<32541b131002160948h317e71f5m2d2cb839470a38f1@mail.gmail.com> 
	<20100216200035.GA19834@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tim Visher <tim.visher@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:39:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhUCF-0000wB-E4
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 21:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106Ab0BPUi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 15:38:58 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:54817 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966Ab0BPUi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 15:38:57 -0500
Received: by yxe38 with SMTP id 38so4606210yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=tjR3+KgsVufJEeNYoWJT+EGq9wKQdYROUZuLqcwXH0g=;
        b=bSv42KB5W4i0eXG6pFXnOZbKAqqtv7LJ0cbQdaNhYjl5rBqaeafayZXEp5ujqofxl5
         7MbWKbBZhEQPtzFOzaJM6MCLPnFXWHhDfFXL2H6y2gIsYxe/ocpshLmcryFwMDI0ztCi
         qdbmpWmgg6gVKOovoSwLCyKEy+OHPfXO5/Q54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=spzTam+w3QlY9EbcYNfua9K8Gadgkk0cHqCo+tFolqVqgKQ/n1qCXV75FJIupi6eAZ
         uQDXgZ86Yn6NU/eXZNlZs6CYLxFWxseblH+qW0bqYePZBiqk0BTl6c1chQ18TWxoutKs
         0BHMzUMhLjBICjVhrdnlBhHTJceqqMsjDXul0=
Received: by 10.150.183.18 with SMTP id g18mr6066874ybf.130.1266352736271; 
	Tue, 16 Feb 2010 12:38:56 -0800 (PST)
In-Reply-To: <20100216200035.GA19834@inner.home.ulmdo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140155>

On Tue, Feb 16, 2010 at 3:00 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Tue, 16 Feb 2010 12:48:16 +0000, Avery Pennarun wrote:
>> Three suggestions I can offer:
> ...
>> 2) Try using relative repo paths (like ../foo.git) in .gitmodules.
>
> Is that a 'try', or are those supposed to work?

It works.  The reason I said "try" is that in order to *make* it work,
you may have to move your repositories around so that you can reach
one using a relative path from the other (ie. it's easiest if they're
on the same server at the same level of the directory hierarchy).

Avery
