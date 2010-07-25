From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 7/7] t/README: Add a note about the dangers of
 coverage chasing
Date: Sun, 25 Jul 2010 11:05:45 -0500
Message-ID: <20100725160545.GA25169@burratino>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
 <1280068861-17701-8-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 18:07:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od3jK-0003hP-75
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 18:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab0GYQGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 12:06:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53568 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab0GYQGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 12:06:51 -0400
Received: by iwn7 with SMTP id 7so2010206iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SgKul2lJk65eMmiRQ0zlgqTsCv6gI3QnedPjsS/00dk=;
        b=mXgpTeY387vpBt9ldIKJz9yNzXPd3ZOx+qBVzoAV8qR5jzm8UNvG67siiTuuvMh63Y
         ZGKwWwUPAxIZdwMaPOcGQn7+qpSizDkTHIgyW7qz3DuDlCceMzBrUg/2J6MK58Ih26IR
         sHjFrJEdH5fEY5/z+pvwWTOFbEoSfo6nDYsXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f822wRDfT4TfHv6H4YLS6+zHC6VlPRha2EwLQYvRi1jjpC7bLSsXIVl5+1s8Hiuycp
         uw9D+bgsTigSxgGM2jOzVneQJ166EgyLh6Oknh5l5ajJyYWCU64vtCusO9ZLLOrdwVp+
         hIvWk6Y2T5UpSfSlNkScmpvHy3Wjpa21S1PvI=
Received: by 10.231.14.200 with SMTP id h8mr6293887iba.188.1280074010090;
        Sun, 25 Jul 2010 09:06:50 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm2636075ibb.20.2010.07.25.09.06.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 09:06:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280068861-17701-8-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151755>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +   Don't blindly follow test coverage metrics

Hmph, that is just common sense, while =E2=80=9Cyou should really not b=
e
paying any attention to your code while writing tests=E2=80=9D is not. =
 I even
prefer the text without this patch applied.  So forget I said anything;
I can find a way to hint at that in t/README later. :)

Jonathan
