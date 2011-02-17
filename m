From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 02:08:55 -0500
Message-ID: <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 17 08:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpxzY-000577-6x
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1BQHJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:09:26 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46137 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab1BQHJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 02:09:26 -0500
Received: by iwn9 with SMTP id 9so2171093iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 23:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zskR5dW59RgpKWViOum9MmOpWoG1A1rsbRAc3KX6hsM=;
        b=L3WqfEFumuyfWCJSKed7zW4urV3wxo6eYv2xuXTjfKckepsO1lravIKc7EgyEmP6zi
         VZDKbBm2AXoG1VR989rOnt/UKRaN+LQWRcQBQQYCAezJJDpDtcf0NNOS1dmsDt5V2FgE
         Gh492RSGHYU9Ejid53kVDQtQNoEmFEfwiX1yA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EqyzNDppsRz1CgXAGleg2UZxf8IRhByEyKj7gVZRobRX7ewCxy1Mghk5KE5cNARBer
         c0zsf4YZdI6bQXp1sYhvYNTXaPBxhDpG1phCe+hbrtHJZSmRsbGbo6mu2qze0T4ZvM9d
         KI4ugHA7czokCIrmxiFtzKzxUAj5vvSQf56Jg=
Received: by 10.231.36.69 with SMTP id s5mr1264184ibd.167.1297926565347; Wed,
 16 Feb 2011 23:09:25 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 23:08:55 -0800 (PST)
In-Reply-To: <buoei77xmpc.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167046>

On Thu, Feb 17, 2011 at 12:19 AM, Miles Bader <miles@gnu.org> wrote:
> Is there a convenient, intuitive, way to set (or change) @{upstream} for
> the current branch, without doing anything else...?

$ git branch <current_branch> --set-upstream <new_upstream>

But note that this is deceptive: what's important is the relative
positions of <current_branch> and <new_upstream> on the command-line,
and they must be in that order. It doesn't (currently) matter where
you place the --set-upstream.

I've got it on my todo list to make --set-upstream take <new_upstream>
as its argument so that you can just say:

$ git branch --set-upstream <new_upstream>

j.
