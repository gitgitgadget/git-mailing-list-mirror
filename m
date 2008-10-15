From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Super module pointing to submodule branch instead of a specific commit?
Date: Wed, 15 Oct 2008 17:57:17 -0400
Message-ID: <32541b130810151457q66a97ffob18d7154acbbacb3@mail.gmail.com>
References: <2729632a0810151416l3a16f6d6x4e32e457d26496bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 15 23:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqEO9-0000sY-21
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 23:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754284AbYJOV5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbYJOV5U
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 17:57:20 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45298 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754244AbYJOV5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 17:57:19 -0400
Received: by gxk9 with SMTP id 9so7542280gxk.13
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 14:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LC+kQTCo92lfw4MXadugl2WsvipjuBGaAMFKBRwAnf8=;
        b=nkh1BX5t7dEQYKp35rPhakTmy6w6JaWEAgyaiFjZc7721TDcxVW73iTUm7PFvW5Sch
         842xCZ4RsDK67Oiu+vcE2TMy0B/HygA8szbBSQYA/YupvnLERVqQF3m4O+aGImifuRav
         zTznnDChKZCzVkApcjfDI8y1KJG7eYAYms48A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jVTaPcvP9VkDujoa6mDw2HjWzyW4vPJJj3gXvrqd3K9VkSZRLwOKOPgMZkoZVCMTAQ
         rwNdm145ZXdI9dnHiHFDCmFxq86bK4OE5ZGxBMjWaQpHSBaMiDxnNJ7lfVEid6s4RSUR
         y32QMQmc3wvTShGAgibx4ndFVJywhzqg73Kps=
Received: by 10.150.228.12 with SMTP id a12mr2619109ybh.25.1224107837619;
        Wed, 15 Oct 2008 14:57:17 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 15 Oct 2008 14:57:17 -0700 (PDT)
In-Reply-To: <2729632a0810151416l3a16f6d6x4e32e457d26496bc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98333>

On Wed, Oct 15, 2008 at 5:16 PM,  <skillzero@gmail.com> wrote:
> Is there a way to have a super module point to a branch of a submodule
> instead of a specific commit ID?

In some sense, this is too simple to be supported by git-submodule.
You might want to try the "ext" tool instead:
http://nopugs.com/2008/09/06/ext-tutorial

Have fun,

Avery
