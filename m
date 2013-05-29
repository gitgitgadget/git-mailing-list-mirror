From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] fixup! rebase: implement --[no-]autostash and rebase.autostash
Date: Wed, 29 May 2013 23:08:06 +0530
Message-ID: <CALkWK0ndproca_tbs3yg5X2Zw+opDPPRXsd520v6TPVcU4iSfg@mail.gmail.com>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org> <1369825880-8608-1-git-send-email-artagnon@gmail.com>
 <7vzjvdu1y5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:38:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkKp-00072L-D7
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479Ab3E2Ris (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:38:48 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38021 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932730Ab3E2Riq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:38:46 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so25605131iet.14
        for <git@vger.kernel.org>; Wed, 29 May 2013 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VWDMNQpEqf7cU7dZY8SYQfVZICQYGf9H3h5zORllkkQ=;
        b=uSr/XP8234xpQU4Nir8lFH4qjhbcj9T0C5B2I1k2AYxIgXDZKZXL51Fs+ByZelcoFw
         HXPm7I6WKohtDW9g1PJHMeBGqRPjhkTzYU2DKoiTg65qJSY+py+X1y6/k+RVymvvtOyx
         tYQLlSIdfSF7o8sVSDiLXxA6Bd5StYe8FFnc6VNCnvAg5EAQWNYIKMRQxUORF+/iYV88
         oONeZh/H6ZiL0QQI0gfyRzhIJYVjLKO3BGT7q8YNkw97N0iR3MKDZWLta00BHcLrBqaI
         i6M58tjc4Mz6bNX0b+zhdq6aLNRHXt6lvxW67qx8/3fEVdiFiX3wCGp+SXUuKpK3BWWy
         fLqg==
X-Received: by 10.50.32.8 with SMTP id e8mr1848379igi.89.1369849126178; Wed,
 29 May 2013 10:38:46 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 10:38:06 -0700 (PDT)
In-Reply-To: <7vzjvdu1y5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225849>

Junio C Hamano wrote:
> As I wasn't the one who were disagreeing, that would not work
> well.

I meant in the tiny details like echo + gettext versus gettext.

>From the review of v3, nobody had any disagreements; just minor
suggestions: that's what this patch is about anyway.
