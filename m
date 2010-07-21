From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: CRLF behavior
Date: Wed, 21 Jul 2010 17:21:14 -0400
Message-ID: <AANLkTil5hUWwSXcz9T7cgeU_LwYtx8Nio7lUaUebJ5YM@mail.gmail.com>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 23:21:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObgjY-0006GF-8n
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 23:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758714Ab0GUVVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 17:21:36 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50593 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757693Ab0GUVVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 17:21:35 -0400
Received: by wwj40 with SMTP id 40so2818699wwj.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=rLsuoxcyPmMi5yT9aq4kfZWY/ixxu6RYdNqR+KCZ0Jk=;
        b=KAhH44rv9z2WU9MeozPrrBUDlJoBhDDG/g4gTuVbit66pv850QYE1whGl5ZUqxAZnt
         7BfJ6jLekLt5CTX7t8aVkwjRhkNpSMmwX21J972Cut59fT2gNWcv57KoNnSQOzGLl5X4
         KGPVVzRwxdM37A//8LwuG8QcPXL9lYSfk4FL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lAxR7SNBtnqMunIYZH4ipAjgPwV860F3Cr2CwsBnQaU7OjGbPYPNNqzPLgLtGw4kJS
         zq0610WUJiPcszhvBscTnMEtJzSDaDT7P3KHr2ghFXg3LZdIUylHjkAB3liJ7UXUWN77
         FG/Mi8UlDiFqpYZpd4AJLNEpGd2xIMe3tWH+s=
Received: by 10.216.232.144 with SMTP id n16mr813624weq.1.1279747294379; Wed, 
	21 Jul 2010 14:21:34 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 14:21:14 -0700 (PDT)
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151421>

On Wed, Jul 21, 2010 at 5:18 PM, John Dlugosz <JDlugosz@tradestation.com> wrote:
> I'm running MSYSgit on Windows, and have no mention of any kind of crlf conversion in the config files.
> Running git config --list shows nothing that would suggest any such setting.

Try 'git config --global --list'

Avery
