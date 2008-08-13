From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: Re: Local uncommitted changes, not checked in to index with gitk
Date: Wed, 13 Aug 2008 21:22:51 +0530
Message-ID: <ace3f33d0808130852g766d71c5i6035309ff7296e0d@mail.gmail.com>
References: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com>
	 <vpqljz1cfkm.fsf@bauges.imag.fr>
	 <ace3f33d0808130553g318ce97gf654c3f998d4047a@mail.gmail.com>
	 <48A2ED80.5000808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:54:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTIfc-0005DB-Cy
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYHMPww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYHMPww
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:52:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:54061 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYHMPwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:52:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so55470wfd.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/ekxYPw3r+81J7ld1cUBkph0FBM9bHAzrI7zl9pmHw0=;
        b=jBD4MAf3T4D9r9sXDhDQNRCBVkaTKPXRSCP2CfsmHgQmnfHaWwRE18WhT1JbKMMRtt
         Qn8QQbXrXZ1+sQ2drJVFomUWMm399EzIfkgmMCU1sWLi/AE29PjBUrNr9DU9dJhGUx2e
         cy0HT7N9uOqFxvVu5lWguE/wxdkgjbhuuc+80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VvHxCWyrgVNCf0+55Vc5n9Xi4AFh+unbjmGmpWnoFyKAxrvsJ25VzlRMG9w4uUP/qV
         sXebw+wkhq5IgsnuAa6ITepz9VGvgJjOmeAvYGAkjibMyzFcGYcaCtzbFyAUmMW/8rVf
         xM/e7WAwbjMNzpai2Al9X2yeDosQcYFHclMJQ=
Received: by 10.142.52.9 with SMTP id z9mr2150wfz.258.1218642771220;
        Wed, 13 Aug 2008 08:52:51 -0700 (PDT)
Received: by 10.142.134.7 with HTTP; Wed, 13 Aug 2008 08:52:51 -0700 (PDT)
In-Reply-To: <48A2ED80.5000808@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92234>

Yes, you are right, am using cygwin, without having the point in mind,
i simply thought some thing is going wrong on the git side, I just
compared with the gitweb copy on the kernel.org.

I just seen in the cygwin faqs, could possibility of case sensitive
managed mount in cygwin,
have to see if can achieve that.

And thanks for giving clarity.

-srinivas.

On Wed, Aug 13, 2008 at 7:49 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> srinivas naga vutukuri schrieb:
>> I just done "git status", Its giving the following output. But i
>> have't done around these files anything at all, not opened, etc.
>>
>> -------------
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   include/linux/netfilter/xt_connmark.h
> ...
>
> You are on a case-insensitive file system. The linux kernel source
> requires a case-sensitive file system because the sources contain both of
> these files:
>
> include/linux/netfilter/xt_connmark.h
> include/linux/netfilter/xt_CONNMARK.h
>
> (ditto for the other cases that you observed).
>
> -- Hannes
>
>
