From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: use printf instead of echo
 to print commit message
Date: Thu, 22 Jul 2010 14:45:49 -0500
Message-ID: <20100722194549.GA4439@burratino>
References: <MoU2SrLLcYS4J28tNBJjfxYnqoLoX04XwHLgciB5KCUnhqJoXifmNFbSGHS4r8pboBurx-NhZWs@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 22 21:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc1jP-0001q8-H1
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 21:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327Ab0GVTqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 15:46:54 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33875 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0GVTqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 15:46:53 -0400
Received: by ewy23 with SMTP id 23so3082386ewy.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cqYKCgywZkYcAOaEbNk4s5k921VSBi9ne8xtMWk7gKg=;
        b=CVGlC3GyA6SuF7c5fPrUI8MK6a/7oZ0Som1cYOhubtaTU3AuNbxhpstMbVIuAJfdB/
         qlJB4HYeuk5pqWLMTMS6mef1dd1G7i9BQuioEKNS8l6SccMJt/mYBUbuT5zuPBhpmBUY
         hcLr46Injib2cF/yGvgJx/xLnN9VcD9Z/VB8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qT1kKRGYzI7NpLmKnYuSeXDU/oX4pAKRpSroUxV7w/ghBu1XY1Us0Oe0NNPZnNaMR+
         6zZtbK/ruLuqIyGkfTW/8d1VFr/cOlZ/HQzhZovvqsmH0WO8OgtWyLw3+odK/AASYZKK
         x9GXp3X87BG5OkYMtcqP210X5kP9fGklB79XI=
Received: by 10.213.26.75 with SMTP id d11mr8306789ebc.27.1279828011808;
        Thu, 22 Jul 2010 12:46:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v8sm55792069eeh.20.2010.07.22.12.46.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 12:46:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <MoU2SrLLcYS4J28tNBJjfxYnqoLoX04XwHLgciB5KCUnhqJoXifmNFbSGHS4r8pboBurx-NhZWs@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151474>

Brandon Casey wrote:

> On systems with an echo which defaults to the XSI-conformant behavior
> (Solaris, or others using Ksh)

Debian and BSD systems with the Almquist shell, too.

> So work around this issue by replacing the echo statements used to print
> out portions of the commit message, with printf.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for taking care of this.
