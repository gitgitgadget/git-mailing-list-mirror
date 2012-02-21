From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] push: add 'prune' option
Date: Tue, 21 Feb 2012 22:30:31 +0700
Message-ID: <CACsJy8ACoF=2dEUoFvT8bQDmUsjJA2_VWvTSJV6fakqyCLBCYg@mail.gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 16:31:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzrgh-0007Ns-QH
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 16:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab2BUPbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 10:31:04 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49204 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab2BUPbD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 10:31:03 -0500
Received: by wgbgn7 with SMTP id gn7so4073521wgb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 07:31:02 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.109.198 as permitted sender) client-ip=10.180.109.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.109.198 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.109.198])
        by 10.180.109.198 with SMTP id hu6mr27806216wib.16.1329838262000 (num_hops = 1);
        Tue, 21 Feb 2012 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S2cXdJKHaSdokoF9za/fC3e7hlR5smnlRr/qsodzEVM=;
        b=R0PnqHjLVW9IBgoMbBBU59HRpcvLWAQ040jTeK0PCo0KPp/a1LrWL6lWo/coceM7m7
         QJZTb3VksXgcGJdd06ijicwXZBsH8OT5deaE3Ny6kvMaCo8aR8tIWGGo+26qiT/7Fiwh
         +GiMp5YT5u6+Bh34BH7ljfX0wPujr1UrPY9wg=
Received: by 10.180.109.198 with SMTP id hu6mr23216947wib.16.1329838261922;
 Tue, 21 Feb 2012 07:31:01 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 07:30:31 -0800 (PST)
In-Reply-To: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191166>

On Sat, Feb 18, 2012 at 2:12 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> As an example I put my use-case; I want to backup *all* my local branches to a
> personal repository, and I want to remove branches that I have removed from my
> local repository. git push personal 'refs/heads/*' mostly does the job, but it
> doesn't remove anything, and that's where 'prune' comes from.

Yeah, may I have "fetch --prune" too, please? Looking at diffstat
gives me a feeling that you only need to add maybe four lines to
builtin/fetch.c and my dream would come true.
-- 
Duy
