From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 15:46:56 -0500
Message-ID: <535583c0caa69_5c94d452ec6c@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <535572b73183b_414c80b30863@nysa.notmuch>
 <CAHGBnuM3TVMbow7Zbb9QnEeJOR9aZY1dwj2CWqs-Ti_HDppE1w@mail.gmail.com>
 <20140421204506.GD5105@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 22:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLHJ-0001Sr-F7
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbaDUU5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:57:21 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:43662 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbaDUU5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:57:20 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4006016yha.38
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Ij1yB2YkgmqKglYA3YwoKiAx4vrZR41uA7/n8YyxGGs=;
        b=hGhL5YYAZvSr17WniNDR+hBOT3hxxgKcajsny2k9Spj32WS9OHNCKxM10kXJDQTGBf
         tPPWmj319GQmYy4Se7m2eSEPoPtJczlfCaIiT8YJ60R9sLXF12uJL77+riy5Gq/0wh1U
         Wc9jqlAATjN1vYW+HY60eUoLrnQQHzdcjNOrJDE47Xufg4PVs3u4UAlsM+LeqhFpV2Au
         m/YpZxLurm3rIxKVqzWheWndyl3BJ3gfsIpWBY1zRFDKt+9M/iOUMgAqRGijBV7K6AEA
         GTL7uU8TIPbNFU4CA26s7RG8Mz7Bi+rmMkzOlfFaBkQd8xotPCelsT7oHpxx4Ftb49as
         HGyg==
X-Received: by 10.236.81.6 with SMTP id l6mr56443334yhe.29.1398113839780;
        Mon, 21 Apr 2014 13:57:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s68sm45018214yhk.22.2014.04.21.13.57.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 13:57:18 -0700 (PDT)
In-Reply-To: <20140421204506.GD5105@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246637>

Theodore Ts'o wrote:
> On Mon, Apr 21, 2014 at 09:47:57PM +0200, Sebastian Schuberth wrote:
> > On Mon, Apr 21, 2014 at 9:34 PM, Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > 
> > > I have these aliases as well, except br => b, and cp => pi. 'br' is probably
> > > better, but not sure as 'cp' which can be confusing.
> > 
> > If by confusing you refer to "cp" to copy files, that's actually what
> > I like about it: cherry-pick is somewhat like copying commits, thus
> > "cp" makes much sense to me.
> 
> The problem is that between "git rm" and "git mv", if we default "git
> cp" to mean "cherry-pick" there could easily be user confusion.
> 
> I'm not sure that cherry-pick is used that often it really needs a two
> character shortcut.  Maybe just "git pick"?

I'm in favor of having both 'git pick', and 'git pi'.

> Personally, "git branch" and "git checkout" are finger macros that I
> type very quickly, so creating two character alias probably wouldn't
> save me that much time.  But I do appreicate that there are folks for
> which such aliases might be useful.

I bet I can type 'g b' and 'g co' faster :)

-- 
Felipe Contreras
