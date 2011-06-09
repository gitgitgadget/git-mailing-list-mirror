From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 15/19] transport-helper: update ref status after push with export
Date: Thu, 9 Jun 2011 12:23:03 +0200
Message-ID: <BANLkTik2cWBAU9jYSKWR_MOd4DfLi5AJYg@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-16-git-send-email-srabbelier@gmail.com> <20110609091045.GE4885@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 12:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUcOz-0008DU-7r
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 12:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1FIKXo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 06:23:44 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58740 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab1FIKXn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 06:23:43 -0400
Received: by qyg14 with SMTP id 14so738884qyg.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=CZVet6B6+PIpXs+189EUODcOqjKpEV4O1/ZYN7BBC1E=;
        b=ZW7+rbexDGX+VtYHnOFGllusfXqX41Y3ApQXlPJKSM1sVh5uJdJ2HC7JkjbyzOWv/V
         ej+yrS5BzUc/89lflPp5pApx9HtnbQbC/QscswZiGEpjznbdT+r8OSNlh6nxwitAWWSr
         t2LfSaQ8Xgzv2jkKNfUrPpTNWPGfMi+4nZdUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dZk+SP7/GpWfcMlEz0MgiyHjkfrGaHfTrzKirjlSlPqcUa36DXfU1PNUso4EULbmSO
         Mw27rOde2iVdB0cYEeShlWNY39I//gwOsCgZszBziSPT3ku3n7cGwvsbv1bjrDxAUWlo
         3X8qiT3A6/psRwGIttu1xNJfQyREDEGaXi1JQ=
Received: by 10.229.127.99 with SMTP id f35mr408187qcs.91.1307615023091; Thu,
 09 Jun 2011 03:23:43 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Thu, 9 Jun 2011 03:23:03 -0700 (PDT)
In-Reply-To: <20110609091045.GE4885@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175514>

Heya,

On Thu, Jun 9, 2011 at 11:10, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> which is to say, this implements the "approach C" mentioned in reply
> to patch 10 that ensures that the remote helper gets the blank line
> telling it disconnect is imminent. =C2=A0Good to see.

Ah, yes it does :). Happy coincidence.

--=20
Cheers,

Sverre Rabbelier
