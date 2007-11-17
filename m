From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Sat, 17 Nov 2007 20:54:01 +0100
Message-ID: <200711172054.02746.jnareb@gmail.com>
References: <11949569992214-git-send-email-msmith@cbnco.com> <200711171918.40981.jnareb@gmail.com> <20071117191846.GE5198@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItTkL-00021S-Ec
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759595AbXKQTyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759402AbXKQTyM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:54:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:64286 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759553AbXKQTyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:54:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1090593nfb
        for <git@vger.kernel.org>; Sat, 17 Nov 2007 11:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=hFxd4XZxahBrm3Qr9Tz2mikQ0vrwMSe8in7ln3yRBg8=;
        b=Q86TeyKrzwFhG2BqpDZmjHGQKuAE6oja2MZEvhNmuYwnK5kzUFd09fb7vj/PR2AZvUgTImt1EC0uv/VjK8iSf1xp0EbnnQA432mfwiSC7V4hMkT3Glm81LwA070thhjoPXu7j2rlXzeuEQ0NTsds98H5+jphQwU20PwwRHL9EVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WQTI9hGuP3eSZC8ngE8+VOpaYtRFyOzPkqKyREgfOxGzUtcBKSfoW0COk+lPc/L4mYanyPbZ7EVTJU6//Vn2OUKWE/h4CYWidKTRvDyqm8OzCX6PdEm30dHco0qPyWNpBSWvpYXtLIoMuY5IrC9+M65ACkS6uQHhNjYzo9J2/ek=
Received: by 10.86.58.3 with SMTP id g3mr3155397fga.1195329249751;
        Sat, 17 Nov 2007 11:54:09 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.236.102])
        by mx.google.com with ESMTPS id e20sm4612193fga.2007.11.17.11.54.08
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2007 11:54:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071117191846.GE5198@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65299>

Jan Hudec wrote:
> On Sat, Nov 17, 2007 at 19:18:40 +0100, Jakub Narebski wrote:
>> On Sat, Nov 17, 2007, Jan Hudec wrote:

>>> git log has such option?
>>> 
>>> $ man git-log | grep -e --left-right; echo $?
>>> 1
>>> $ git --version
>>> git version 1.5.3.5
>> 
>> It has, although it is hidden in git-rev-list(1) manpage. It is a bit
>> obscure corner...
> 
> I hope the new option parsing ifrastructure will take over quickly and start
> to be used to generate the short help and probably even option section in the
> man pages. It's unfortunately not the only option that is not mentioned in
> the manual page of a command that has it.

Truth to be told _this_ one option I don't mean it is only
in git-rev-parse (which git-log references, together with git-diff)

-- 
Jakub Narebski
Poland
