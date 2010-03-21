From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Speed up commands that use rev-list when max-count is 
	specified.
Date: Sun, 21 Mar 2010 12:12:49 +0100
Message-ID: <fabb9a1e1003210412n58a3b951x1de4543f11b888c4@mail.gmail.com>
References: <1269142267-17127-1-git-send-email-bmeyer@rim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Benjamin C Meyer <bmeyer@rim.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 12:13:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtJ5p-0000v1-3R
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 12:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab0CULNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 07:13:11 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:46314 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab0CULNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 07:13:10 -0400
Received: by bwz3 with SMTP id 3so4434261bwz.29
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=F2Swe6qV0R4LZzNVVqpUJBJmPCCxji3dVbTA8ukv4gU=;
        b=Isu2+yKvMxy8kUER4EQB9d5lHkUeXXJ7tTfcWhWxxiRl0mTQA5uXi48T5/EaDO8J+C
         jlNhKj7TpxtSMKua0Hq18M5SAUUfiPyCKSVm/vvGPV62CCQXAaiW+D4TNVzBUkaJyhmQ
         vVrdE1zQWfIkxZh9VpLIgW7CTJOOIkl46vjzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=a/VE5OqoK7lFq8dMrmA1bj32M0TN1d/S/kX5nSktQ9o18O00piUmyl3UcSb1pohNVo
         fcSz3AOnvw+RKeSXv6U/52ts1mdaaxHhReERurIIvLGnhAjg0TOIz8opIsLh2Mw0nYbN
         bMBSc5D7xvgWnJqJSjpbuW3jhGRoO1PSpmikk=
Received: by 10.204.36.70 with SMTP id s6mr1245788bkd.22.1269169989112; Sun, 
	21 Mar 2010 04:13:09 -0700 (PDT)
In-Reply-To: <1269142267-17127-1-git-send-email-bmeyer@rim.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142818>

Heya,

On Sun, Mar 21, 2010 at 04:31, Benjamin C Meyer <bmeyer@rim.com> wrote:
> Depending on the use case this can have a big impact on the running time.

Sounds promising, do you have any numbers?

-- 
Cheers,

Sverre Rabbelier
