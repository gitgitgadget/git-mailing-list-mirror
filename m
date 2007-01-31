From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Wed, 31 Jan 2007 17:36:16 +0100
Message-ID: <81b0412b0701310836q4222c82arcfda05d3594182af@mail.gmail.com>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Nefari" <fastestspinner@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 17:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCIRZ-0007B0-Fu
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbXAaQgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 11:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbXAaQgT
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:36:19 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:50803 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030255AbXAaQgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:36:18 -0500
Received: by wr-out-0506.google.com with SMTP id i22so248268wra
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 08:36:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=invVWZ45srnsMrETRUSmP3s5D+dGTFWyeP9aHS55ukqln1Eq3ZSEHho61AUdpaopE/Vsjp+Ppo5NV3iyZwdmHNRKQPchnQEb7AV2B8IcztwZKEHw7oX5+Ugd0KQy9rFNOQ8bjVfady4RB8sUsQNm5KSHSjE1T5vgxlX8W23+7V0=
Received: by 10.78.138.6 with SMTP id l6mr196557hud.1170261376574;
        Wed, 31 Jan 2007 08:36:16 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Wed, 31 Jan 2007 08:36:16 -0800 (PST)
In-Reply-To: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38273>

On 1/31/07, Mike Nefari <fastestspinner@hotmail.com> wrote:
> The gitk gui layout was completely broken on Cygwin. If gitk was started
> without previous geometry in ~/.gitk, the user could drag the window sashes
> to get a useable layout. However, if ~/.gitk existed, this was not possible
> at all.
>
> The fix was to rewrite makewindow, changing the toplevel containers and
> the particular geometry information saved between sessions. Numerous bugs
> in both the Cygwin and the Linux Tk versions make this a delicate
> balancing act: the version here works in both but many subtle variants
> are competely broken in one or the other environment.
>

The patch is broken very spectacularly. How have you made it?
Copy-paste in the browsers window?
