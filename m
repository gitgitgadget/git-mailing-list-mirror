From: Aviv Eyal <avivey@gmail.com>
Subject: Re: [PATCH] Support specific color for a specific remote branches
Date: Tue, 9 Aug 2011 21:59:47 +0300
Message-ID: <CAGHT48LHOi=TL6eSJKiFoao55quPn+nsK+etCmWPQsZB7ydLmQ@mail.gmail.com>
References: <1312818553-25042-1-git-send-email-avivey@gmail.com>
	<7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 20:59:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqrWs-0008Aq-4X
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab1HIS7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 14:59:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51339 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1HIS7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 14:59:48 -0400
Received: by ewy4 with SMTP id 4so190004ewy.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Bo+/uiopK2GFoYTij4cXM/D8uExdnCM9BX5SuyukPus=;
        b=hJ09dbmjCAtZHkWzQ9tvIW/tv1re4hK4oZcb4qrVt84pE8uZR7PZ6vj2fznlWMDGRg
         PzA5mKM8rKwoBlCrN746Hh2NgB/IIJZBXLR8m8wV67//N0FRNBKMQQJzbbKqGW0N0GDz
         GNZUWFOEFeIwW8hoFPRCP07i/wG34FWGL5Pns=
Received: by 10.204.129.73 with SMTP id n9mr2029076bks.223.1312916387332; Tue,
 09 Aug 2011 11:59:47 -0700 (PDT)
Received: by 10.204.30.207 with HTTP; Tue, 9 Aug 2011 11:59:47 -0700 (PDT)
In-Reply-To: <7v8vr3zsh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179043>

On 8 August 2011 21:08, Junio C Hamano <gitster@pobox.com> wrote:
>
> Who said a remote name is terminated with (and cannot contain) a slash?
...
>
> Shouldn't this code be consulting the configuration file to learn the
...
> so that remote branches from "frotz" remote, that happen to be stored
> under refs/remotes/nitfol/ hierarchy, are painted in the correct color?
>

Sorry, that's too dip & complex for me... Consider this patch 'withdrawn' then.

-- Aviv
