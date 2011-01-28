From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 20:53:34 +0100
Message-ID: <AANLkTimc92giAAJnzjv5Bq4f853xqEfLrgB=j+iRXPaf@mail.gmail.com>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 20:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiuO6-0007kI-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 20:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab1A1Txh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 14:53:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41570 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab1A1Txg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 14:53:36 -0500
Received: by wwa36 with SMTP id 36so3749820wwa.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oXgOT/8lbslij8g5iBBNaeNbM1cu7bHau0LKd7luaXc=;
        b=skLacL2Ted70XkQ6aHS73P+kwpPN762MKOf4AaE/KXpGf84VSml/11huqiceRJn+3B
         qkVs9AsV+OPkm8zrkNnfbaPoiKPK36rIrBLxhdktVayqMttfLWEwYZHD4Fey2TjrYW6R
         lygg5G6VMnZRAKVn5YdVfiR2ZLQOh+gKz3Y1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qDlwKUCmdIr6gxRd9O/lup8xYWEwYdz4li3HfnF1zrohHxfI09Ub3JL8ZeAsb4p8Qq
         hqM3iX3XEp7aPK0rgjPG9rvagHUSYsZHyBRmJaq/cSl8H76GkFoS+VIwS4PH3sR3ngTp
         ROLotxgV7acMZlja3AGyzKRIWbVfHHnwuhrjE=
Received: by 10.227.55.70 with SMTP id t6mr3116506wbg.212.1296244414955; Fri,
 28 Jan 2011 11:53:34 -0800 (PST)
Received: by 10.227.134.14 with HTTP; Fri, 28 Jan 2011 11:53:34 -0800 (PST)
In-Reply-To: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165637>

On Fri, Jan 28, 2011 at 17:17, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So 'git merge' is 'git merge @{upstream}' instead of 'git merge -h';
> it's better to do something useful.

Nice idea. Could you have a look into git rebase, I think this could
be applied there too.

Anyway, I think some high level sanity check won't harm. Ie. check if
there is an upstream configured.

Thanks.
Bert
