From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: gmail smtp server and git-send-mail. Is this combination working?
Date: Tue, 8 Jan 2008 17:58:59 +0100
Message-ID: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 17:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCHnZ-0000eZ-QW
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 17:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbYAHQ7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 11:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbYAHQ7E
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 11:59:04 -0500
Received: from ro-out-1112.google.com ([72.14.202.183]:7862 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbYAHQ7B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 11:59:01 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2469249roc.5
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 08:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=BHDSp7aoL9veKJCZGZjd6HM2mitFJFujv3a2dTRVkfk=;
        b=cUIR2WceB7+TdfyIcD/6GOeBD6xh9B+g4LQ7U60L2OvkNkPR7okMUra6WMLaZb41nAmFqDOi8KjhDmXrDh73jIeKccoX4BpkZt7/kZ30G0HlAa9PA0OCvcqI5NaAQsVoDBrIUFxfU9Mk8KmA9Ss8RH2TMBCz30XG/Tv0s+REmzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZDQvy0AaRZaBAcPTl8yVd1W2LcmQ7cjKL9eC1o41XoauFECdB0Y8KkFMeO0b+7reXojLWD527j5oi8ZMHRhUYMWITm7aSJVyT8eC2MnrwcBEikq5X/JiRXdoOHe7P0fb+juLxlNSSzl5D8h5Ku54F3Y48KnYU94eUKYbMQw+iJ8=
Received: by 10.142.187.2 with SMTP id k2mr358785wff.51.1199811539134;
        Tue, 08 Jan 2008 08:58:59 -0800 (PST)
Received: by 10.143.162.9 with HTTP; Tue, 8 Jan 2008 08:58:59 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69891>

Hi all,
as I previously wrote I would like to use git-send-email to send out a series
of patches.
While I was looking for documentation I saw the following statement in the
git wiki:

" Mailing off a set of patches to a mailing list can be quite neatly
done by git-send-email.
One of the problems you may encounter there is figuring out which machine
is going to send your mail.
I tried smtp.gmail.com, but that one requires tls and a password,
and git-send-email could not handle that "

>From http://git.or.cz/gitwiki/GitTips.

Is this statemant still correct ?
Is msmtp the only solution for using git-send-mail with gmail? (tls +
autentication).

Thanks.

regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
