From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/7] sha1_name: prepare to introduce AT_KIND_PUSH
Date: Fri, 24 May 2013 08:22:15 -0500
Message-ID: <CAMP44s2AxHkx54HzCCK5nUsexAhWy4J_oqg4wNu0=FzvEYtXAg@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
	<1369321970-7759-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 15:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufrws-0005R0-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 15:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab3EXNWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 09:22:18 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:48339 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3EXNWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 09:22:17 -0400
Received: by mail-lb0-f179.google.com with SMTP id r11so4568104lbv.24
        for <git@vger.kernel.org>; Fri, 24 May 2013 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BbS8hhQkFQ0Xe9ekybyxW2027MdI7vGEYE5IsWFz7g0=;
        b=dqpT/He1vGYKrVH6VIl2PfeK2LlDfmzvuzBiLS7zrz7nAjB7xxMvJh1xnfST7bJ43w
         IHJ9kjmHZkoVX5pSgU9STbm3swtxmK8VgrU8BcOGyZqFPogT0i5UzrKa/BRQFNWj2pXQ
         IwrNpZA1EPKOwqpWl38oo/NDVaV026nE5CMV+kYnxo+Sn3t+sNR43JprSHjojT/fdgic
         iUgABZ/DA7dcG6Egp/wTRlvr/SmoalHKNjHzlp5/cK3895AZFfIRzGyqfgUFOeaGdnKj
         yBXtE+wD2FY7UG2q1W1M6CsWgApXLO9CDqxZNanBeO5NV2we9P2bzm6aQ2TzMVBNAgrW
         2k6w==
X-Received: by 10.112.236.70 with SMTP id us6mr4628305lbc.121.1369401735991;
 Fri, 24 May 2013 06:22:15 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Fri, 24 May 2013 06:22:15 -0700 (PDT)
In-Reply-To: <1369321970-7759-7-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225351>

On Thu, May 23, 2013 at 10:12 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Introduce an AT_KIND_PUSH to be represented as "@{p[ush]}".  Determine
> it using branch.remote.push_refspec.

I think the semantics of this don't make any sense.

  git push branch@{upstream}

Is very clear: push upstream of branch.

  git push branch@{push}

Is not clear at all: push push of branch?

Is it a noun, or a verb?

I would expect branch@{X} to be 'the X of branch', and "the push of
branch" doesn't make sense. Whatever X ends up being, it should be a
noun.

-- 
Felipe Contreras
