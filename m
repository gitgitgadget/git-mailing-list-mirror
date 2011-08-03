From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-am: ignore leading whitespace before patch
Date: Wed, 3 Aug 2011 15:33:50 +0200
Message-ID: <CAGdFq_jm3recWwYGow0fZgw6zgwQBurTAPuAyd_qfzHLD6zGbA@mail.gmail.com>
References: <1312323646-93427-1-git-send-email-davidbarr@google.com>
 <CALUzUxpn-vCWpTQyB7z9dsu8a+UBL9MPjEycOfTmyws5ndz5kA@mail.gmail.com>
 <CAGdFq_it-QAA5uSme6S715dRzHs-s-Uj=MWKzBK2MOaaSdiXtg@mail.gmail.com> <CALUzUxrubhFpLd00BomM5WwPYNwPbxCx6q7U2TG4PssaQODkZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:34:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobam-00075P-5f
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab1HCNec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:34:32 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53586 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab1HCNea (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:34:30 -0400
Received: by pzk37 with SMTP id 37so80023pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PCvfWrhVVNBRzt/w6tX4+O7HMwICZ4Hmn9yuHq+iaQA=;
        b=f++3SekQPp3kII5ri66Vu8kxP6cL5olDyK1gO8N8eLe9lER1z+h+jGInjP51EJdr5g
         ZsfC5J5mYQs3kc09OxaaFGwa/aGiInzlY8bDG0G019n8hvUGqhzr5nWovRJPf1B2nLU9
         FozMMEL5zICgDn0nNrQLFAdedoba8W1EqKcuY=
Received: by 10.142.121.35 with SMTP id t35mr5016160wfc.7.1312378470565; Wed,
 03 Aug 2011 06:34:30 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Wed, 3 Aug 2011 06:33:50 -0700 (PDT)
In-Reply-To: <CALUzUxrubhFpLd00BomM5WwPYNwPbxCx6q7U2TG4PssaQODkZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178573>

Heya,

On Wed, Aug 3, 2011 at 15:31, Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Wed, Aug 3, 2011 at 9:21 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> So how do you get the patches out of gmail? Do you just copy/paste the
>> output of the "Show original" page?
>
> I Ctrl-S from the "Show original" page. Using Chrome, that yields a
> mail.txt file.

Ah, clever hack! Nice :)

-- 
Cheers,

Sverre Rabbelier
