From: Elijah Newren <newren@gmail.com>
Subject: Re: need help with git show :1:...
Date: Wed, 8 Apr 2009 12:38:06 -0600
Message-ID: <51419b2c0904081138o3f05a6fm6a4213e7b0f1db6f@mail.gmail.com>
References: <6838.1239212486@relay.known.net>
	 <51419b2c0904081058p7d5a56c3j6aa5cebb0188ad43@mail.gmail.com>
	 <7199.1239213762@relay.known.net>
	 <51419b2c0904081107s7ba08367w671d5b494095402@mail.gmail.com>
	 <7357.1239214209@relay.known.net>
	 <51419b2c0904081125u3bdf37deyd5dd85f6c2a6d7cc@mail.gmail.com>
	 <7685.1239215733@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 20:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrcgn-0001eO-Qs
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 20:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760460AbZDHSiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 14:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759352AbZDHSiK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 14:38:10 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:34119 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758931AbZDHSiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 14:38:08 -0400
Received: by yx-out-2324.google.com with SMTP id 31so259179yxl.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6auNwItgxpv10S0z+s29DkAierGsxIb9p1phwQ86AkQ=;
        b=N2WdfsBkpF0p8Fumfwr5xuR84KEkAfKkbQplAcjSeVL06XJMxlWZw256MKBxphtCRH
         wJ11Mfic2RVn/Zso72HYEbSxAve0ikbgsGPuFkIQOiacUrLI7SQci4SpuvHC0zsxt892
         KnXsYtnu+yqhopZDDAPSNvaCfL/wRvHQnkN5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lvrjYaRXJGASCpHab3u7b/nIQPsOENySwQwxUUIbCQNW0E1C/wfeoQLChwHgzMP0Lj
         UbjJR4vg4UQMJRuG/EaU20BkMpqiZLvFsB7c2JdLwcvEcIUy82rYBGpW97Achrf8t/kR
         Oth1snOi+S5/8EI2YddjCWJQdisNAEA+41nbs=
Received: by 10.231.15.74 with SMTP id j10mr440477iba.10.1239215886518; Wed, 
	08 Apr 2009 11:38:06 -0700 (PDT)
In-Reply-To: <7685.1239215733@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116108>

Hi,

On Wed, Apr 8, 2009 at 12:35 PM, layer <layer@known.net> wrote:
<snip>
>>> git merge-file current-sock other-sock base-sock
>
> Did you mean this?
>
>  git merge-file current-sock base-sock other-sock
>
> The man page seems to indicate that.

Oops, yeah, current then base then other, like the manpage says.
