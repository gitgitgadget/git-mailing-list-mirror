From: Kevin Ballard <kevin@sb.org>
Subject: Re: Highlighting whitespace on removal with git diff
Date: Tue, 19 Oct 2010 20:15:33 -0700
Message-ID: <D058D986-2A83-4979-A461-F7CB34EF9448@sb.org>
References: <AANLkTik7a8OQz2+SVTm+HjZkCtbjm6O9d12biCJ8MyZz@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Stonky Fandango <stonkyfandango@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 05:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8P9f-0007sE-4n
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 05:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773Ab0JTDPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 23:15:38 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58005 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500Ab0JTDPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 23:15:36 -0400
Received: by pzk3 with SMTP id 3so591806pzk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 20:15:36 -0700 (PDT)
Received: by 10.142.13.12 with SMTP id 12mr5402189wfm.77.1287544536381;
        Tue, 19 Oct 2010 20:15:36 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id y42sm20228821wfd.10.2010.10.19.20.15.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 20:15:35 -0700 (PDT)
In-Reply-To: <AANLkTik7a8OQz2+SVTm+HjZkCtbjm6O9d12biCJ8MyZz@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159390>

The highlight isn't telling you what changed on the line. It's telling you that this added line has trailing whitespace, and your core.whitespace config value is set such that this is considered an error.

-Kevin Ballard

On Oct 19, 2010, at 5:46 PM, Stonky Fandango wrote:

> When I do say 'git diff', and I have added a line with a trailing
> whitespace, i get a red square box highlighting the added whitespace.
> (on the '+' diff line)
> What I want, is the reverse - so when I delete an existing whitespace,
> I get something similar, for example a blue box highlighting the
> deleted whitespace (on the '-' diff line)
> 
> Currently the only notificate I get is identical
> '-' and '+' diff lines, but no indication of the whitespace deleted
> 
> I know I can do this with graphical tools, but ideally would like some way
> using the standard console git diff - if this is possible.
> 
> I have  the following in my .gitconfig
> ---
> [color "diff"]
> whitespace = red reverse
> [core]
>  whitespace=-indent-with-non-tab,trailing-space,cr-at-eol,tab-in-indent
> ---
> 
> Thanks,
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
