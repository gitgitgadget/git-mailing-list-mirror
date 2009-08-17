From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 17:21:09 +0700
Message-ID: <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com> 
	<fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com> 
	<2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 17 12:21:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MczLN-0002od-8X
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 12:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbZHQKV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 06:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZHQKV3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 06:21:29 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:63664 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbZHQKV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 06:21:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so2763220and.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5lOZzM+abqelxUmIRf3HfOiaC7ILuADuqOZitfPFYaY=;
        b=N+jF6Yi9AUIyZq5LVxBsYoDey1ODyG3MTNNnyfJhdNnuSoh9wR0yrA0J4J6Bk98IJH
         VdevnQPovrlSIbubmnpyd3+yMuGRYc1W4ykXjLMeonPiEajJXV6PMQb3H6WgQrOT8X9U
         R+gB0DL8XUtaGq5T1d5+fstC+8uSCs5EGjm7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F9taqt4nwn2pw/LfTSvxu41GH2vRo5ehupIfC1XngHgTC8mUTKMwe10N7497hajHFg
         DheLnAVKOYE95eW0suc03UQ4AkrRFsEQfw1Vg/BL1srbGJhbeMciMzLeQqqY7PUlxNYD
         PJkxGMTMNfMOGJ7OWhKHMiE75p9w19lAeJ7ao=
Received: by 10.100.55.18 with SMTP id d18mr784075ana.80.1250504489090; Mon, 
	17 Aug 2009 03:21:29 -0700 (PDT)
In-Reply-To: <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126154>

[I haven't read the rest of the mail, will read it through later]

On Mon, Aug 17, 2009 at 3:49 PM, <skillzero@gmail.com> wrote:
> It would be nice if .git/info/sparse is there by default (like
> .git/info/exclude) with some commented out instructions (also like
> .git/info/exclude).

No it can't be there by default. An empty .git/info/sparse means clear
assume-unchanged bit out of all files in index. It's not the same as
lacking .git/info/sparse (which does disable sparse checkout feature).
-- 
Duy
