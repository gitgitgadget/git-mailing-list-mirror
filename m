From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t 
	for greater compatibility
Date: Wed, 30 Dec 2009 01:55:57 +0100
Message-ID: <40aa078e0912291655m57ea0081vddf3b64bf27e1d02@mail.gmail.com>
References: <hhbldr$di8$1@ger.gmane.org> <4B3A7000.4050308@kdbg.org>
	 <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 01:56:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPmr5-0002gm-E7
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 01:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZL3Az7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 19:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbZL3Az7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 19:55:59 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40844 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZL3Az6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 19:55:58 -0500
Received: by ewy19 with SMTP id 19so3264469ewy.21
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=h70I0V5LjDLLzmavBxlt9+tjEK1kp8rYoBxU/LVZv8Q=;
        b=yGGm8ODT8QePZHsaB+eogyL4hn1sXvUd/NH+stIpsDg+CdocuDgJo9TE46VPS9dJVS
         mjfE0VySh/MXY5HDE27rDhf4hKcOFJbOAx/cCbdOd3JBDTlJp/WWj9Vy9ng5X495nIZY
         1+MfFaKzbdIOcW2Ryol4puN+VIEIDoRwEhleo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=O6ACLqcqthawHlAZWQhcP6ZmEMCB8gXoLEfj5iN7/K79CVtY6TY1rxKpyTn7+MW6Bd
         55Rwq5H1NcgaMV649cB3Okxy6+vYTsrnOck5v+7sFYD4DpbYDmSPk8bzHhW0D+86yAmW
         rxxcCNGyhPbmDzdsJTddWRKQ8WdEOM9twrjew=
Received: by 10.216.87.71 with SMTP id x49mr2057815wee.11.1262134557095; Tue, 
	29 Dec 2009 16:55:57 -0800 (PST)
In-Reply-To: <bdca99240912291649h1c727072q3b1e4099cab426df@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135846>

On Wed, Dec 30, 2009 at 1:49 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Tue, Dec 29, 2009 at 22:09, Johannes Sixt <j6t@kdbg.org> wrote:
>
>>> MinGW: Use pid_t more consequently, introduce uid_t for greater
>>> compatibility
>>
>> Why this? Compatibility with what? What's the problem with the status quo?
>
> I wanted to include Hany's Dos2Unix tool (hd2u) into msysGit. h2du
> depends on libpopt, and either of the two requires the uid_t type, I
> do not recall which. And while adding the missing uid_t, I felt it
> would be right to actually use uid_t / pid_t in the function
> prototypes.
>

Perhaps I'm missing something here... why do you need to modify the
git-sources in order to include an external tool?

-- 
Erik "kusma" Faye-Lund
