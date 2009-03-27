From: "Etienne Vallette d'Osia" <dohzya@gmail.com>
Subject: Re: Improve tags
Date: Fri, 27 Mar 2009 15:39:26 +0100
Message-ID: <49CCE51E.10203@gmail.com>
References: <49CB798B.4090107@gmail.com>	<49CBA713.4040605@drmicha.warpmail.net> <49CCAAD3.4070104@gmail.com> <m3bprn2gs7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Etienne Vallette d'Osia <dohzya@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:41:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDFB-0001xw-TV
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbZC0Ojc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZC0Ojb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:39:31 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53883 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbZC0Oja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 10:39:30 -0400
Received: by fxm2 with SMTP id 2so1054381fxm.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=LOnqPEMvpp1Cv78UBoBDy6ztdXg4XJjxM3XDmQC2aDo=;
        b=C7ubdQ7C6B7UXrHlXedcIlxkmxv8z1iCJZqo9b4zP5GLaqf3g+IdusjKkn6wMkjmPM
         KmwNFe+P3+XiBlm1wMUpZ4NInpJORQeQcM6IEWTCDRVUCS0Z1J+YUCJ/xBWxRzLfFYsO
         /i0JkZBZNGAWVgkZDld8/m7H6VyiXvjuhkyXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=dF+5HWvOfKF14NWESsPFEhD/N8ZoQEnpA/w8qr/E5ixtwNKjS+TxXdK37IGSMMRDzo
         QYg7WGbyZxBB2lXHsVxnD6jeGXj919Hek8Q3o7U2R0zvhxTzy0h5WNtY5/u0CqjoKkej
         x9AI8/Gl8vMCb4eev3q0oLakjI6Rowxr6uO2E=
Received: by 10.103.224.17 with SMTP id b17mr467153mur.61.1238164767998;
        Fri, 27 Mar 2009 07:39:27 -0700 (PDT)
Received: from schubby.inria.fr (schubby.inria.fr [138.96.218.89])
        by mx.google.com with ESMTPS id i7sm3340925mue.44.2009.03.27.07.39.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 07:39:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <m3bprn2gs7.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114898>

on 27.03.2009 15:15, Jakub Narebski wrote:
 > More seriously: take a look at 'notes' idea; I'm not sure what state
 > they are currently, but they are in active (more or less) development.
 > They are extension of tags, allowing post-fact annotation of commits.
 >
git notes store a message related to _a specific_ commit.
It doesn't allow to find some commits.

In my mind, the best way to bind labels and notes (which would be great) 
is to allow to create a note related to a label.

Regards,

--
Etienne Vallette d'Osia
