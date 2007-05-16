From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add an option to git-ls-tree to display also the size of object
Date: Wed, 16 May 2007 02:54:37 +0200
Message-ID: <200705160254.38463.jnareb@gmail.com>
References: <11792246701367-git-send-email-jnareb@gmail.com> <200705160119.10802.jnareb@gmail.com> <7vps51hacw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 16 02:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho7mx-0007Hd-2O
	for gcvg-git@gmane.org; Wed, 16 May 2007 02:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760082AbXEPAyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 20:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760084AbXEPAyk
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 20:54:40 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:32767 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760082AbXEPAyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 20:54:39 -0400
Received: by py-out-1112.google.com with SMTP id a29so324336pyi
        for <git@vger.kernel.org>; Tue, 15 May 2007 17:54:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YYYqmc5UWgW3kjt6hU8Kh+YuMIE0d3PnBfGvP3Ocy9A1RrbwiQmG0I8VvQ6DhpnBX8NFvbzMku/1cQkiTd8Moj8WYFMEUZE3BmNiWlgjPJ6F92rzjonmUYbD7N/qJwLGEU+GqXGE+4g7dE5jS+DrXnT5jfZ73ygHKbRTtXLOMto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qlxtcYS3JYJ9bPcqFvb33vceDh7NwxGaQTggspoRQYvtRdX+i1sHeCC45gVNcTaSbtjW/4My2R9qKk0r0MtpKdwgl5wWh0s87hmoxnsbT+QRTYl+UHk+GJRUuZEQNGDowHSXBhh66rWWYwzsdO/M89YFuikometsBRMeI/FRV3s=
Received: by 10.65.183.7 with SMTP id k7mr1995132qbp.1179276879236;
        Tue, 15 May 2007 17:54:39 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id f17sm1341872qba.2007.05.15.17.54.37;
        Tue, 15 May 2007 17:54:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vps51hacw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47400>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:

>>> =A0 Also I suspect that having to show the size of a tree object,
>>> =A0 expressed in terms of the canonical representation, might
>>> =A0 force packv4 aware ls-tree to convert its traversal efficient
>>> =A0 representation to the canonical one only to get its size.
>>
>> It still will be accessible, but perhaps it would be less efficient
>> with v4 pack. It is I think acceptable that -l needs more CPU (and I=
/O)=20
>> time...
>=20
> Shawn answered this better than I could. =A0I am moderately
> negative on the size of tree objects part.
>=20
> But modulo these details, I agree that being able to get the
> size of each blob would be useful.

We can always return ' ', '-', or '0' as size for tree entries.
I wonder what to do about commits/gitlinks/subprojects...

--=20
Jakub Narebski
Poland
