From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Tue, 15 Jan 2008 08:21:15 -0700
Message-ID: <a5eb9c330801150721t5da85295heacae2c5a5aad47e@mail.gmail.com>
References: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
	 <20080114202932.GA25130@steel.home>
	 <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
	 <20080115054807.GA3694@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 16:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEnbm-0003Na-Ab
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 16:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbYAOPVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 10:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbYAOPVR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 10:21:17 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:18803 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbYAOPVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 10:21:16 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4383648wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8qiMe7GftouCiaMuAtklyAtgzZJpna/25aXiwwty6/U=;
        b=V+deuVgUVRweG81XhDuXfe7vSQvPS4GGTpor77R/qYORoIZMveILc4uu2RGHN2X6Cts7w4B5CME5uXR6fWp1ywaZUWEC5roDwrreADqhYsb0GI4UDDfCuQtxUVsteog8RnOLcpaw1T/88FV7rJ2jJu2MsSuVCxXNnrs7YoMz9QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1XElJyrAPzdIfOkuD+37SGkiyEeCH6uXQyVR3T6t5L/Pot8YpGaEQqchuyMoIzZBm6fpXbnviMJt8CAxcHFqZNyazb7RQi7UxV/J3N8npv/nMLomT7w1C0EieT14l/UczQAciw6MjRakx8ZlecGc80rEEk4OgFwsqAudNDh8Ow=
Received: by 10.114.14.1 with SMTP id 1mr1885667wan.9.1200410475542;
        Tue, 15 Jan 2008 07:21:15 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Tue, 15 Jan 2008 07:21:15 -0800 (PST)
In-Reply-To: <20080115054807.GA3694@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70527>

I've just completely uninstalled (ie: deleted) and re-installed
cygwin, ensuring that bin mode was selected for the install (I'm sure
it was before, that's the default). "mount" confirms that everything
is mounted in binmode.

Sadly, I still can't commit to a git repository - same problem: every
file & directory immediately shows as a "missing blob" after "git add
."

I'll try the same install on my home system (Win XP Home) and see if I
get the same problem.

Paul
