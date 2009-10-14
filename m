From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/6] Open the pack file and keep a map on it.
Date: Wed, 14 Oct 2009 10:30:27 -0500
Message-ID: <fabb9a1e0910140830g7cac1063wfd8b31de02d32c12@mail.gmail.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com> 
	<fabb9a1e0910140548g2ad99ec4ia0f4cd4cb6fc409c@mail.gmail.com> 
	<4AD5EE77.3030802@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Herv=E9_Cauwelier?= <herve@itaapy.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 17:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My5q9-0001fL-Te
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 17:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934544AbZJNPb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 11:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934526AbZJNPb2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 11:31:28 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:54634 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934452AbZJNPb0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 11:31:26 -0400
Received: by ewy4 with SMTP id 4so4537731ewy.37
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/dDO66vBkYavVN5JBtNZu+ujf6CM8zI7fQSKSmvza2E=;
        b=fP9sRipEdtlB/k7OkBtuCnHQtb8XFl6WjANKhjKMJ+i2MGjnxmbUjbt1Aut0PRkKqb
         WbfEEKud1mH/NSAbgJUw/LNDYNy7o5NVvQsk8TugAUKt9wrxfGgC3qZS+Ff3UY9eb8gN
         lqiY1lzYr66HTeZ0zuIZATfVBpQcTFMsNUTTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OKTkMiEBbI/6vFVd3cCpnN0C/Cgb/v514cvdjKBhIoxtX+zKWWITgOh28olt6bFxPI
         buq6AtZGHabOw3IZMP+PNwcUCjXFcTBcGcCKShspvMUF7BZ4eP/Ip9Xmel86vIGRRbta
         5jAPOxw4dP0Ny6ZKSh/L1bsVeF+BgbJ2h45qA=
Received: by 10.216.89.70 with SMTP id b48mr2934641wef.160.1255534248212; Wed, 
	14 Oct 2009 08:30:48 -0700 (PDT)
In-Reply-To: <4AD5EE77.3030802@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130297>

Heya,

2009/10/14 Herv=E9 Cauwelier <herve@itaapy.com>:
> Hi, indeed I forgot and send-email sent them without asking confirmat=
ion.

Note to self: write patch to git send-email...
Note to self 2: learn perl
Note to self 3: find someone else to write said patch to git
send-email, perl is scary

--=20
Cheers,

Sverre Rabbelier
