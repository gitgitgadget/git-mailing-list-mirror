From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 00:54:30 +0200
Message-ID: <4fb292fa0606141554p2562cbear8fff960d052e825c@mail.gmail.com>
References: <1150324030.23268.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 00:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqeFv-0007od-E5
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 00:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWFNWyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 18:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFNWyc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 18:54:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:52138 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964978AbWFNWyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 18:54:32 -0400
Received: by nf-out-0910.google.com with SMTP id o25so156939nfa
        for <git@vger.kernel.org>; Wed, 14 Jun 2006 15:54:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Za9r30XQ5uv+rzoYAXgWlc3/InpAJBAF0mki7/oGvdFGfbW/SmY9ynUlgwtV/ZNkeVD6Ka2TUmlYsCnnZChWLv8IEznajg7CAs2K0ePLgRIv9f3ChQtIhpYmWnic3qJT5CXDG1WrUmK2/J/uMun/ALXuOdHqOEPP8IWi677muew=
Received: by 10.48.255.8 with SMTP id c8mr933590nfi;
        Wed, 14 Jun 2006 15:54:30 -0700 (PDT)
Received: by 10.49.34.12 with HTTP; Wed, 14 Jun 2006 15:54:30 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1150324030.23268.12.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21871>

On 6/15/06, Pavel Roskin <proski@gnu.org> wrote:
> Hello!
>
> Is there any interest in converting the build system used by git to
> Autoconf and Automake?  The ad-hoc configuration in Makefile is getting
> too big.  As for nice features like remembering $prefix, wouldn't it be
> better to add them to Automake instead of limiting them to just one
> project?

Autofoo are pretty good but it's unix make dependant, can't create
build files for other build system as Visual, or so on. How don't lost
his hairs trying to do autofood his project ?
CMake seems to be as good for git. And is also expansible.
Git Makefile is quiet big but not complex, autofood imho will make it
less stable and usable.

-- 
# Beber : beber@gna.org
# IM : beber@jabber.fr
# http://guybrush.ath.cx, irc://irc.freenode.net/#{e.fr,gentoofr}
