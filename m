From: "michele" <michele@mailc.net>
Subject: Re: send an email with logs after push
Date: Fri, 13 Nov 2009 15:18:06 +0100
Message-ID: <1258121886.28608.1345063845@webmail.messagingengine.com>
References: <1258101999.17624.1345023113@webmail.messagingengine.com><a2633edd0911130055y199955a2n93888b03c5f9b985@mail.gmail.com>
 <vpqocn6iu4l.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 15:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8wyt-0001pP-Aq
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 15:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbZKMOSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 09:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbZKMOSC
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 09:18:02 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58156 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755136AbZKMOSB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 09:18:01 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2995EBF84A
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 09:18:06 -0500 (EST)
Received: from kvm1.messagingengine.com ([10.202.2.121])
  by compute1.internal (MEProxy); Fri, 13 Nov 2009 09:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=/kZv0r+liKylS/1/wmY27Ik/0nk=; b=ugxfWr2JKyr16s9r7Rtm8uq+cgiXVy+/bXPhfmUCDqRXVHFYA7Ig1FoTAIsmJsO8KLG35C5zBuFYn4ez6cSZ2anKZgVA24E6u/37DuyX1qxzGVzVGkpe+nIBkWhDNKY/fkYeN/Cy6rtevyvoytYnRPPRLAviST+Z9pGUnUUmvNI=
Received: by kvm1.messagingengine.com (Postfix, from userid 99)
	id 1DE9A438; Fri, 13 Nov 2009 09:18:06 -0500 (EST)
X-Sasl-Enc: oZ3VS8FwGd/Uep2GdI1EViomgiUVCxjQBVAySPi62jRn 1258121886
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <vpqocn6iu4l.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132836>

On Fri, 13 Nov 2009 11:42 +0100, "Matthieu Moy"
<Matthieu.Moy@grenoble-inp.fr> wrote:

> See also post-receive-email in git/contrib/hooks/, probably installed

Thank you for your suggestions. I've added a new post-receive hook using
the code from post-receive-email. The hook is executable and is placed
in the remote directory. The push is made from my local pc via ssh, but
after the push nothing seems to happen: the hook is not executed on the
server side. It does not depend from the code inside the hook: even the
unique "touch foobar" command does not work. Where do I have to look?

Thanks
