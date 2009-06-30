From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv8 1/7] gitweb: refactor author name insertion
Date: Tue, 30 Jun 2009 22:23:34 +0200
Message-ID: <cb7bb73a0906301323j32e1f8dam9ba185401b2d1e2f@mail.gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906302204.40876.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:23:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjrn-0004Ko-9k
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbZF3UXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZF3UXd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:23:33 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62364 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbZF3UXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 16:23:32 -0400
Received: by fxm18 with SMTP id 18so395662fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lwmaLrsBBOdsLrrwymmGGY8g834zqphBsjOw82/hde8=;
        b=ph9DXAm4JuRBDsTXESwJN4OnL+E9QRwTN4EyTm/bp3+mOBbx0DmQ3H32wajHtvOFZu
         tztZeHx6o9xNAUKemfpkzr8N8XV6HSq8XLAwcDoRTZbf3ZpY4NkcwOmKof4AKDoU5a+o
         vkANRghHpQ9cld5c6TBqR7oKziTbMhvRFdARs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q8c5vPI/GMtexIwviejK8xPqzlqZJvOx5k6xLcmsv3UJ1DjTggnJAV3VkpCm1wNQZt
         vhW6sQ6Y7GnRf5GZ6EDBKqeXOqh4A5cxTmMxGI9qXAMyrqfS1BygZwWM81XR0AT/IKjX
         7fdkcd7zvrz0Zk2P+Axma7OaDq8nItUtPjfjE=
Received: by 10.204.60.72 with SMTP id o8mr8689798bkh.184.1246393414021; Tue, 
	30 Jun 2009 13:23:34 -0700 (PDT)
In-Reply-To: <200906302204.40876.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122530>

2009/6/30 Jakub Narebski <jnareb@gmail.com>:
> On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:
>> +sub print_local_time {
>> + =A0 =A0 my %date =3D @_;
>> + =A0 =A0 if ($date{'hour_local'} < 6) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(" (<span class=3D\"atnight\">%02d:%=
02d</span> %s)",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $date{'hour_local'}, $date=
{'minute_local'}, $date{'tz_local'});
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(" (%02d:%02d %s)",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $date{'hour_local'}, $date=
{'minute_local'}, $date{'tz_local'});
>> + =A0 =A0 }
>> +}
>
> Very nice refactoring.
>
> It could do with a comment describing its output, but it is not
> necessary, and IMHO not worth resend. =A0We can always add it "in tre=
e".

Damn! I was sure I'd forget something ...

--=20
Giuseppe "Oblomov" Bilotta
