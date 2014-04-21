From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: general question about git
Date: Mon, 21 Apr 2014 17:25:34 +0200
Message-ID: <CACBZZX5LoLLj3_sx1iiC2ucwybzvkqu=04vxUQr+zL=oGJA=EA@mail.gmail.com>
References: <7F780F951A13B047BB0CE5F6EA9069C121871941@hou150w8xmbx06.hou150.chevrontexaco.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Miller, Hugh" <HughMiller@chevron.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 17:26:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcG6a-0004MY-Mo
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 17:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaDUPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 11:25:56 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:36282 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbaDUPZz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Apr 2014 11:25:55 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so4313556oag.39
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZfmAD6VUNHYD0D37eePQihpjQYNd3R84693Ua990ldk=;
        b=KR7jT4PFsiEcL/DYoh4AZjOdFy0yxw7Ufw3df46RRsHk7NvLsYyJP9n6+v7KlM8aNi
         tTyGNQsHpsPGmSABBK5MWiuqijv6TZHSe0uFOyY/0rFDXp2tdHCYuPmuoZGuwYltFKwY
         oazKGJqSRVt53I1iiRJVjyoPxboCzNtgup+LEVZ18zIZenLtW5q7BF7dkRTvsxi5xmoF
         wInYJz2M3tmUtIoQ9Dk5y3/n8ShSkC1BetysTKHYkIfZAAS+V6TaA7bATCD9xg9blfhQ
         sOzz09Xh6DmTHPSQgWtKpMnvsmNh4DlmkAh6f6ALHgeKIaKO/0LwoKLU6EMfuQnhq8eN
         JO+Q==
X-Received: by 10.60.124.227 with SMTP id ml3mr1148071oeb.67.1398093954386;
 Mon, 21 Apr 2014 08:25:54 -0700 (PDT)
Received: by 10.76.176.40 with HTTP; Mon, 21 Apr 2014 08:25:34 -0700 (PDT)
In-Reply-To: <7F780F951A13B047BB0CE5F6EA9069C121871941@hou150w8xmbx06.hou150.chevrontexaco.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246612>

On Mon, Apr 21, 2014 at 3:17 PM, Miller, Hugh <HughMiller@chevron.com> wrote:
> I am interested in exploring the possibility of using versioning for "data", that is versioning non-text, non-code file sets. Typical examples are the data files or "project files" used by some application. These file sets typically contain binary files; these files can be somewhat large, 1GB to 10GB is not unusual.
>
> Would git be a suitable tool for this purpose ?
>
> Ideally, even if the data files can be versioned this way, one would probably prefer to build the versioning tools into the application.
>
> Would the git libraries be suitable for this further aim ?

Stock Git is still unsuitable for this purpose, but I recommend you
check out git-annex.
