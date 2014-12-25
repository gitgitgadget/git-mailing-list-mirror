From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Upgrade Git in openSUSE13.1
Date: Thu, 25 Dec 2014 12:46:40 +0700
Message-ID: <CACsJy8A7W4iL5qfBnEDBc=-XRWz_721UtkyWfEx8tZszkESa4w@mail.gmail.com>
References: <11649454.2G0koPIBX8@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 06:52:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y41LN-00089M-1g
	for gcvg-git-2@plane.gmane.org; Thu, 25 Dec 2014 06:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbaLYFrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2014 00:47:11 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45263 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaLYFrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2014 00:47:11 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so6652798iec.37
        for <git@vger.kernel.org>; Wed, 24 Dec 2014 21:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fnYqyWabfTk/AW3vXWSLpt7E21NpET6N3mo0ED+nvwM=;
        b=CgD/fU/ygBQQoxLMFqMdRFXRnbQbq/ep2h8ZGyRY8fL7OVhCN/8GeO40jsMni9IfVU
         i78SO8Rq05nXtasTWzF6CKNVnaw69GAr8tg/Yy/BoZ/2w+6bFJDS+y/B301UmXX9TFTe
         xqRwA5ssX/FHfHQ8sq5rTbIrYJiPJpD+xVP+xh9nNW3mS34MWbchTeZw503goxdEMj4v
         a3rvj5T2IA/fND+4zByQRqi6fTCZVYME1zYICvwQfFu4UcNHBk+KNBhARv5359FQFKCM
         8YVP3SOvYEAU5dZ6R1UBnLUuogU9GAdeZbl6gBppPPEJC0WySsKgxnlh7ftG8bgs0HwJ
         gsQg==
X-Received: by 10.107.170.162 with SMTP id g34mr33877626ioj.2.1419486430339;
 Wed, 24 Dec 2014 21:47:10 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Wed, 24 Dec 2014 21:46:40 -0800 (PST)
In-Reply-To: <11649454.2G0koPIBX8@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261821>

On Thu, Dec 25, 2014 at 3:02 AM, Arup Rakshit
<aruprakshit@rocketmail.com> wrote:
> Hi,
>
> I am keep getting the below warning, whenever I am trying to deploy my code
> there :
>
> [arup@to_do_app]$ heroku logs -t
> Your version of git is 1.8.4.5. Which has serious security vulnerabilities.
> More information here:
> https://blog.heroku.com/archives/2014/12/23/update_your_git_clients_on_windows_and_os_x
> 2014-12-21T17:58:49.605785+00:00 app[web.1]:    from
> /app/vendor/bundle/ruby/2.1.0/gems/dm-migrations-1.2.0/lib/dm-
> migrations/adapters/dm-postgres-adapter.rb:60:in `ensure in without_notices'
>
> I am also not seeing any upgrade here -
> http://software.opensuse.org/package/git
>
> How to upgrade then ?

OpenSUSE appears a bit slow in handling this CVE. Follow this bug for
progress, status..

https://bugzilla.opensuse.org/show_bug.cgi?id=910756
-- 
Duy
