From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 08:18:28 +0700
Message-ID: <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 02:19:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPmCx-0005Yq-N9
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 02:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0LGBTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 20:19:00 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34177 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0LGBTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 20:19:00 -0500
Received: by wyb28 with SMTP id 28so12687064wyb.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 17:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=3ZI+RlvyuXVxaG8GH9iLeSa68e2Bo47p0/fDcbnGVzs=;
        b=kFdx/EsGtOjREAR3sHuTMehyOGsM9T4L63BLbnHF7YlYZv+Ipb3F0T/39mn5IL51JH
         Jq/yTPIZjUBDq76jB1dq8DMviL0NhO+MTlSfjEmvUSyKIjvPB0dSdQ9IJGT+uS4jJkWK
         ydUIAbsnGzqTyvWy+lQdT4hheZm9aIigXjtIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qO3DeqAGRmNDMYOCpI2WfUFYRTqkTwPWBVsliqocft+t/DQkQowbXwU/2t8xZoXkvB
         4n+nKAnHbyWCMSfGxxrgHb2P0E3Os6kHJoPFWt0H1UfgfDJOvX8b//CNTG7SoG4xhqfa
         +CFw0bWpiQLGegwpE7XUclmhVNpcWCb1I7YBQ=
Received: by 10.216.30.144 with SMTP id k16mr821648wea.19.1291684738996; Mon,
 06 Dec 2010 17:18:58 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Mon, 6 Dec 2010 17:18:28 -0800 (PST)
In-Reply-To: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163064>

On Tue, Dec 7, 2010 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> +#define BRANCH_DELETION_LOG "DELETED-REFS"
> +

Should this special log be mentioned in git-update-ref.txt or
gitrepository-layout.txt?
-- 
Duy
