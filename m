From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/remote-helpers: explain capabilities
 first
Date: Fri, 18 Mar 2011 17:21:07 -0500
Message-ID: <20110318222107.GD23407@elie>
References: <20110318174504.GA22332@elie>
 <AANLkTimfZM6muiU3vPMgx3NnRdb4H0t4E2DMXt1233LP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0i2u-0004ek-St
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976Ab1CRWVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 18:21:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51573 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837Ab1CRWVT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 18:21:19 -0400
Received: by ywj3 with SMTP id 3so1774009ywj.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=scvc3ZgpWlw12xn2loPZXBm0X6V2qjBczDi2RdM3y5o=;
        b=U0sr96nh+UnUqVZ3NSpht5sUPEbDzIatC/wWpAKZ3A813c/jeStHaM6tLoDz9oKDu8
         E5Jf3WsChu2zaiLTwfX0rYK7aQKL5eHDlKUAnN892lTBNUuW8QZk9hDA3j85ST2Qxfv/
         LK8ef3sdnnZ6JwSz+qtV/Q8hKMx1rufz1OnnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wtLHT2FkSxYngN3EAUpAhBjLh4Ft1c09PBVW3xHqPrtfDReQakKuQkjCM6UOYZ/83s
         NyT9lQp8LCsLVpcrUpUs8DqSi69Y+kvipAcBjGtbKNPqXAN5RXqqZsEkea8Aq8qIm5pm
         dd2qAMds8yQyUKeaKHLZMmaJ4zd+HdtVw7+wE=
Received: by 10.150.65.3 with SMTP id n3mr1790791yba.39.1300486878746;
        Fri, 18 Mar 2011 15:21:18 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id u29sm1413507yhn.71.2011.03.18.15.21.12
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 15:21:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimfZM6muiU3vPMgx3NnRdb4H0t4E2DMXt1233LP@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169369>

Sverre Rabbelier wrote:
> On Fri, Mar 18, 2011 at 18:45, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> No documentation for "export" ... yet
>
> Which is for the better, since I think the current interface is
> broken. It'll be easier to justify changing it if it's not documented
> ;).

Thanks for explaining.  FWIW I'd be interested in your thoughts on this
sometime (not now necessarily, just some time before the svn push
support project is on the front burner :)).

>> (by the way: would it
>> make sense to export the GIT_DIR environment variable so a round tri=
p
>> for the 'gitdir' capability would eventually be unnecessary?).
>
> Yes, that makes a lot of sense.
>
>> The current documentation left me lost, so I wrote this (which still
>> probably leaves one lost). =C2=A0Thoughts?
>
> I think it makes sense.

Glad to hear it.  (The GIT_DIR idea is Tom's iirc.)
