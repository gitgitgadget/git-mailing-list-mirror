From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH 2/2 v2] mergetool--lib: Add Beyond Compare 3 as a tool
Date: Mon, 28 Feb 2011 19:15:07 +1300
Message-ID: <4D6B3D6B.2010001@gmail.com>
References: <4D6A355C.3000805@gmail.com> <4D6A365E.4030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	charles@hashpling.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtwMx-0004Ry-Sl
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab1B1GOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 01:14:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46077 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab1B1GOA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 01:14:00 -0500
Received: by pzk35 with SMTP id 35so574318pzk.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 22:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tB5TQwsgc1ynv2RuOZe7skbJP7VJ9Fve3NdqE9CTMys=;
        b=V/ppt+mIEPYyY7twaC20M0VXhJYXnRv4xJqWhNDDdSMJfL+C8+jGkrzVnh+PJ44fob
         OapdYt0ZpLXEVuFOrUW0EFQRMp7hAtzggv56Qy0hMVVoSv1jFUof5cupvvMQ6QvHp+6q
         98KtE4er1T+4L/KLx1xeqaKEhCqbkpRUg2bhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JPiDFgaZCPNrx5Ft0E+aCXBH2w6vBfQINwpFIhWtIPPkUscR+XGOWoo3W8v6mEpmST
         bXilKnx/2atRJzqmS7Jb1zhm++97N/7Y8FJ0STZ5nFCftIQkYQP/su+zKmx51bczTjl3
         1CfbYtwWXDxRz1KidkpOuzuvXNsgkvYSOploE=
Received: by 10.142.61.13 with SMTP id j13mr4000739wfa.394.1298873639808;
        Sun, 27 Feb 2011 22:13:59 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id w32sm5500127wfh.7.2011.02.27.22.13.56
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 22:13:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
In-Reply-To: <4D6A365E.4030904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168065>

On 28/02/11 00:32, Sebastian Schuberth wrote:
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-difftool.txt         |    2 +-
>  Documentation/git-mergetool.txt        |    2 +-
>  Documentation/merge-config.txt         |    2 +-
>  contrib/completion/git-completion.bash |    2 +-
>  git-gui/lib/mergetool.tcl              |    7 +++++++
>  git-mergetool--lib.sh                  |   22 ++++++++++++++++++++--
>  6 files changed, 31 insertions(+), 6 deletions(-)

Works for me.

Tested-by: Chris Packham <judge.packham@gmail.com>
