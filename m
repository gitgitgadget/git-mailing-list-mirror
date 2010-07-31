From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: error commiting in Git
Date: Sat, 31 Jul 2010 17:43:51 -0500
Message-ID: <20100731224351.GB7678@burratino>
References: <AANLkTimOZr8zq8uXdrzrpLMTDQqwJkZEyxB_zcWFEYBs@mail.gmail.com>
 <AANLkTimqWF7gZHAXFOmz0URdDTF=CfMmjJrBwmFavUkK@mail.gmail.com>
 <AANLkTi=n-J5rMOz0pkcxQZ7VgGs_EtXpotO=wZoDyz=C@mail.gmail.com>
 <20100731223356.GB7490@burratino>
 <AANLkTi=ExhKbUC4yqmPudD_=SpGxxV6MUm-bhaycSJOu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel =?iso-8859-1?Q?Fran=E7a?= <daniel.franca@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 00:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfKnv-0003fF-3F
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 00:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764Ab0GaWpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 18:45:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46782 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0GaWpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 18:45:03 -0400
Received: by gxk23 with SMTP id 23so977504gxk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FDDDgYyusFtyGQc+ZRAWYNivS1qzZa6+fAFfJMrSbck=;
        b=JuGIdtY9Wzl2yvrB05sNYSQ9Hj2DNW7meTUlILc7nLvzM/tPj5welDiadNndOWUlCM
         SAzCleeKXzN4bXapgq7HoW0sOxc6TWklLc1cHiLP6Hjbt+PR2+syaph0QdkfnGJnAn1b
         Aj4wVBKRRshGvwBxIrhU5DCiFrNC5hv53d9kU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bilBt/fhb1mkJRaKGULhMmTuvZYJAgS2R7V2lK+3Ump1jO2pOw/bXSWKQs2lPUpGDL
         3JNSkrcF1S0rH95PxbMvWz4oJM8jrgBImywLzIIzE+qsNyMKrm5XxWlnhG6gLm2CJbzX
         9Y2EHwWOGzCnWlrXkuBlW8qfm7g1mnRowmrAg=
Received: by 10.150.104.8 with SMTP id b8mr5224829ybc.226.1280616303152;
        Sat, 31 Jul 2010 15:45:03 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q36sm2376669yba.12.2010.07.31.15.45.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 15:45:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=ExhKbUC4yqmPudD_=SpGxxV6MUm-bhaycSJOu@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152345>

Daniel Fran=E7a wrote:
> 2010/7/31 Daniel Fran=E7a <daniel.franca@gmail.com>:

>> git commit -a -m 'Teste'
[...]
> the output:
> find: illegal option -- n
> find: illegal option -- a
> find: illegal option -- m
> find: illegal option -- e
> find: *.pyc: No such file or directory

Ah, you have a pre- or post-commit hook.  Take a look at
=2Egit/hooks and you may find something interesting. :)

Good luck,
Jonathan
