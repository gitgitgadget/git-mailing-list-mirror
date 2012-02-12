From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Sun, 12 Feb 2012 18:54:19 +0000
Message-ID: <4F380ADB.4090304@diamand.org>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 19:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RweYw-0003su-Ps
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 19:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab2BLSyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 13:54:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab2BLSyI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 13:54:08 -0500
Received: by wgbdt10 with SMTP id dt10so4243403wgb.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 10:54:07 -0800 (PST)
Received: by 10.216.134.157 with SMTP id s29mr5172843wei.1.1329072847339;
        Sun, 12 Feb 2012 10:54:07 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id n5sm39246062wiw.7.2012.02.12.10.54.06
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 10:54:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1329070423-23761-1-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQlVBpqUvwqCXzRV+HVZH3GuvbKYhBWEZTeRNybeGqitjWmv1iQnMD5hOvuHwwTjOk/2Xi2M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190588>

On 12/02/12 18:13, Pete Wyckoff wrote:
> The git-p4 code is in a single python script down in
> contrib/fast-import now.  I'd like to move it up to the top-level
> source directory of git to make it easier to build and
> distribute.  Git-p4 already takes advantage of the git
> infrastructure for documentation and testing, as well as the
> community support (Junio, many reviewers).

About time this was done. There's still a few oddities around but far 
fewer than there used to be. I don't know if Junio has some rules on 
what a command needs before it graduates from contrib though.

<snip>

> a core git package, or as a separate add-on.  Getting support
> for python and git-p4 in msysgit is something I'd like to see
> happen too.

Not sure about msysgit, but last time I tried on Windows it didn't work 
at all well.

>
> While I considered taking this opportunity to split up git-p4
> into more modular components across multiple files, it seems best
> now just to do the script move intact.  That effort could come
> later.  If anyone has a strong preference to do this now, we could.

Regards!
Luke
