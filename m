From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Handling multiple parallel versions.
Date: Wed, 21 Jul 2010 12:09:38 -0500
Message-ID: <20100721170938.GA14177@burratino>
References: <4C471223.9050303@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ian Hobson <ian@ianhobson.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 21 19:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obcoj-0001g5-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 19:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab0GURKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 13:10:44 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64438 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0GURKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 13:10:43 -0400
Received: by wwf26 with SMTP id 26so3297631wwf.1
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xyk+WrBhRlHISE60KHPnx/G4VTPVcY/G2/Powk1XvgY=;
        b=q1GGfWgHPpuwIbWlUPSWW0KBH92uKBt9DlP6pQMyleWQ6gxt2eo9p0NJBISaA+dfZS
         4OB0ieDo3E5BojS/0kXcoTSMcyw201LKquwu3KTWB2JOL0cY87FEXBmU2S93plQLVMvG
         n/aMENFtkW3r6aKpqojyVAmfoQlvkE8x7QpJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=awGvskVbtfgBb/7mDFphbL7OCjd2qBSU9EQZOCxObUqgR+bvgzx9Q5yKznmxww3IZq
         WvmX9Tgmx5UEclGq3iCpTA90OSSmfO9mS8GEE9tuyd4PG/vyR8xBdvIpoNL1BMn+HZux
         pZt6+JHMuiyjXBvoIRF/DBAJeHAS8v0fiHy7U=
Received: by 10.227.157.17 with SMTP id z17mr460229wbw.122.1279732241061;
        Wed, 21 Jul 2010 10:10:41 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p45sm3528579weq.45.2010.07.21.10.10.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 10:10:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C471223.9050303@ianhobson.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151407>

Ian Hobson wrote:

> So this solution is NOT working for maintaining parallel versions.
[...]
> re-applying the differences between each version (they are a set
> of images and a config file).

Okay, now that I=E2=80=99ve gotten that rebasing rant out of my system:

I suspect the best thing would be to track the branding and
configuration file separately from the main source tree.  See

http://thread.gmane.org/gmane.comp.version-control.git/146084/focus=3D1=
46097

for hints.

(sorry for the noise)
Jonathan
