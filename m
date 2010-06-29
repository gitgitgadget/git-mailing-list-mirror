From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: recovering orphaned commit
Date: Tue, 29 Jun 2010 10:26:06 -0500
Message-ID: <20100629152606.GA7202@burratino>
References: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 17:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTchr-0003Rz-De
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 17:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab0F2P0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 11:26:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:62375 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab0F2P0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 11:26:32 -0400
Received: by ey-out-2122.google.com with SMTP id 9so236795eyd.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sPVy7nIC6eOjPZz7UrDZBf/tJRI6x/s5ELvRHV9WCdo=;
        b=JH2cYWd6//zIPR+VzLWnSN//vwhxycEryLSCJbwyVEvSoh/7K4rMTEu+fOtSkB+3q4
         JnqWbmu7I9BfN8KDJp4Z4oltnJ7K9X8qyuxEtOdBdKgsdaoT1I7sPW1frwp83ZFgQ3DM
         68A1iE/nYupzu/JB2AfMl/NSutQ/qhOwbp28M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tUUHmJhFzxzgKSKqgW3luOj4YijlB6odH1lRYYTBN+VvH5NXoMKsN4cmIoDAcUCW1+
         Kk76T8p5UV+bGCDHU5YqMZZqn5G8HFrMa14r5SX6GGslZWwo/lfssFCw6cEM5hZmPQEL
         eoIFefP1RJ3b3DjkBJ4y6knLzfg7mt+IW1rPE=
Received: by 10.103.126.36 with SMTP id d36mr2034707mun.65.1277825189979;
        Tue, 29 Jun 2010 08:26:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g8sm14976210ibb.17.2010.06.29.08.26.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 08:26:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149907>

Hi Mahesh,

Mahesh Vaidya wrote:

>  2899684ed173063354b7fe4f5ec7216e7d953e2c	 <-- HEAD  ( say C1)
>  1ef67de1a0d6e97470a8c827d2989317600532ff                    ( say C2=
)
>=20
> To see file at C2 ; I have done git reset --hard C2

=46or the future, =E2=80=98git checkout C2=E2=80=99 might work better f=
or this task.
Unlike =E2=80=98git reset=E2=80=99, it does not change where the curren=
t branch head
points, so when you=E2=80=99re done exploring you can get back to where=
 you
were with =E2=80=98git checkout topic=E2=80=99 (where topic is the name=
 of the branch
--- e.g., master).

> Now want go to C1 ; Ho do I Determine C1  using git command ?

git log -g HEAD

Hope that helps,
Jonathan
