From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 12:37:24 -0600
Message-ID: <CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbx7m-0007pG-Un
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab3JaSh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:37:26 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:46519 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3JaShZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:37:25 -0400
Received: by mail-la0-f45.google.com with SMTP id hp15so2666633lab.32
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BfKX2nshIVcfBxMSGC2ASQmI07WodvT1ILBIHCdqeyg=;
        b=dkw31wN1mRUitHt/k7FicljCUgAEGgoeCn22+hrUiXrVq51iUYEJfLo4J3P+NXJYF1
         C+/IP0G1sL4C2O8Ljhpk7z6SmEKrQfEA63lkhB1MI3jGHfpua3KwlYCQfDnIThWov+/h
         BeO5Q8epYfbsWiuKNtsOpq1m0QJa5zteGmmr+6OVhtxX2tLaGeaNI1dWO0oWoyBzCT7x
         SUvPWnGogw+3NZ057Pq7UC/mwZ8JkBtkq4BI8zRcv+JNcmWLnGEnw0QlBtrIA6PdGHP+
         2hnUyLjgeQaJQaTvmWJaBMUhKnkC31/Xb02IK2T8I6+Htxfpao8KJsKXIfKJDkI/5Ds3
         hacw==
X-Received: by 10.112.234.168 with SMTP id uf8mr3140863lbc.35.1383244644265;
 Thu, 31 Oct 2013 11:37:24 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 11:37:24 -0700 (PDT)
In-Reply-To: <xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237150>

On Thu, Oct 31, 2013 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
>>  "`master`":
>>
>>  ------------
>> -       A---B---C master on origin
>> +       A---B---C origin/master
>>        /
>>      D---E---F---G master
>>  ------------
>
> This change is wrong; the illustration depicts the distributed world
> (i.e. a fetch has not happened yet).

That is an irrelevant implementation detail, specially at this high
level. In the user's mind origin/master means master on origin.

If you want to be pedantic, this is the "reality":

  ------------
      D---E---F---G master
  ------------

-- 
Felipe Contreras
