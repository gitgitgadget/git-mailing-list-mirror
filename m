From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] status: show the branch name if possible in
 in-progress info
Date: Wed, 30 Jan 2013 08:13:49 +0700
Message-ID: <CACsJy8ByU8jNFHi2wDyJG+Qfzg7r8R3=RwOqxo3o5UCqjRyy+g@mail.gmail.com>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
 <1359471493-32531-1-git-send-email-pclouds@gmail.com> <20130129184435.GA18266@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 02:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0MGD-0001Lj-9a
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 02:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab3A3BOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 20:14:23 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56537 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab3A3BOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 20:14:20 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so1096245obq.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2013 17:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+ItMfbJsOw8hZ009e8HTkDqN9OB+6iF2nRmRmDdi0zc=;
        b=q7+agDOvrQrEoRmkp0qq2H3rzr37wFPjwrjy73UVE3MVN2+o66Lqttz1skMT4dFHsH
         erbN1dtrmCS9HrSlA4ZvFR3tgiJpJoHpUcz40CqpTgBVbMX2H5rU+Y1KPHPc5YqpgKPQ
         F6jBEJ39mU0rNn4hjH+YRAvHAv+XVQtr0nGrYHODL0CI80bq+wRwr75DVa9TQMrduor9
         svhM6YqqeQAy/sL58JQ4Up7NmCF2mr5puAkQ+uRVuCaYgBTlP4O1N3ZIao/JMoKsaEhl
         Y4JFo4ViN7wBvNqEkpe3j9MeVTItjbcSs1Txu48HJq+rBZ39jMNGlX9Zqm24Pj2gp+z5
         rypA==
X-Received: by 10.182.159.5 with SMTP id wy5mr2392163obb.31.1359508459930;
 Tue, 29 Jan 2013 17:14:19 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Tue, 29 Jan 2013 17:13:49 -0800 (PST)
In-Reply-To: <20130129184435.GA18266@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214985>

On Wed, Jan 30, 2013 at 1:44 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> -     # You are currently rebasing.
>> +     # You are currently rebasing branch '\''rebase_conflicts'\'' on '\''000106f'\''.
>
> SHA1-in-tests radar blinking.
>
> Would it be possible to compute the expected output, as in
>
>         dest=$(git rev-parse --short HEAD^^)
>         cat >expected <<-EOF &&
>         # Not currently on any branch.
>         # You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$dest'\''.
>
> ?

That may be better. Yeah.

> I'm not sure what to think about the actual change itself yet.  Can you
> give an example of when you felt the need for this, so it can be
> included in the commit message or documentation?

http://thread.gmane.org/gmane.comp.version-control.git/214932/focus=214937
-- 
Duy
