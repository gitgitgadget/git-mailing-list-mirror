From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] merge: merge with the default upstream with no argument
Date: Thu, 5 May 2011 17:05:30 +0300
Message-ID: <BANLkTimXFt-RFSPOfv8Ge+boPS_e3NLXkA@mail.gmail.com>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
	<7vpqphasbr.fsf@alter.siamese.dyndns.org>
	<7vd3lharwf.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jared Hance <jaredhance@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 16:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHzBX-0000W2-8w
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 16:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754528Ab1EEOFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 10:05:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43907 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376Ab1EEOFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 10:05:31 -0400
Received: by fxm17 with SMTP id 17so1546825fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dCQSD3WoLWrGX2z2ztgRxMr97UY7k8Ofq7l7vHFevfI=;
        b=xaVRAV79s97/6tWUfSwMG5SKs+4Vs6XunJfBb9ZSSGbI+qWhpvX5Y9h7WmRDct6588
         NciZtuNBkvB9rDmWyGn0L8JkSaiWDxoxDATK1eLqYVhRS1h8bIi0UMaE/t0jTibeahMk
         rpocoTNF5H48PRb1axIvapNXDVnbrwRwGIlX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TI+wNlATzL3I+qg0ujKJ1j8ZRWCrAydTUV45XxTRNxDZXgcKjXnXUKhzYzl/+bsVB+
         tUE1LTo6p5SlVye6x7ZmhmSKFy8yiMM2JUSMPYKBvrbEV1IpZlpgcKbEvKpKWJf2RFWn
         2F9CqGLwZr587K1btWuEVhV1/9GAWzMLfzPVc=
Received: by 10.223.24.134 with SMTP id v6mr1353059fab.146.1304604330838; Thu,
 05 May 2011 07:05:30 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Thu, 5 May 2011 07:05:30 -0700 (PDT)
In-Reply-To: <7vd3lharwf.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172831>

On Thu, Mar 24, 2011 at 9:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "git merge" without specifying any commit is a no-op by default.
>
> A new option merge.defaultupstream can be set to true to cause such an
> invocation of the command to merge the upstream branches configured for
> the current branch by using their last observed values stored in their
> remote tracking branches.

FTR. It's actually merge.defaultotupstream, not merge.defaultupstream.

-- 
Felipe Contreras
