From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What do you use to receive mailed patches? (was: What do you use to send git patches?)
Date: Fri, 5 Sep 2008 16:30:58 +0200
Message-ID: <200809051630.59036.jnareb@gmail.com>
References: <e29894ca0809050715p6cc11525k7da204b43ae164ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org, "Tor Arvid Lund" <torarvid@gmail.com>,
	"Christian Jaeger" <christian@jaeger.mine.nu>
To: "=?iso-8859-2?q?Marc-Andr=E9?= Lureau" <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbcMB-0004xx-Nc
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbYIEObH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 10:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbYIEObG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:31:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:14896 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbYIEObD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 10:31:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so739680fgg.17
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 07:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=w98h9Eq+nMCC0QhPA+9FLWr432wBkcZwTWck3lX3mag=;
        b=EWaQOVhXZRPMdlWYuo+8WfAeInDXdF/Kgt3tjTmPBz4GeogMnarw0VhyzzW9olTK7B
         NGnaoRcyp2aeuY5xsE/cvDEhviN0D8Sck/fPXAfH7hHMZsNz86jRE6ttkLIUjFDXrkJI
         4Hj31tPUnVb3wpH2VS4jgojdGU+2YsLdnqTzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wiLKiFtGCP1b7WxdIsMvMRImcKLT84p9x5i2PIzBK7cmbQmbHCgtHH19ZyfDMhAWBz
         /9WdVIfni0R8Byr3kI2yXeSIiSifbk3CHQaxhYPfPgqDDFGOgwtjRjbj08hhRItnbgJw
         rxE6fq3f1Z9oJ8VRwBnBdydXUiZSLm9zOTQK4=
Received: by 10.86.63.19 with SMTP id l19mr8827081fga.60.1220625061332;
        Fri, 05 Sep 2008 07:31:01 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.238.224])
        by mx.google.com with ESMTPS id d6sm991660fga.2.2008.09.05.07.30.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 07:31:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <e29894ca0809050715p6cc11525k7da204b43ae164ee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95017>

Dnia pi=B1tek 5. wrze=B6nia 2008 16:15, Marc-Andr=E9 Lureau napisa=B3:
> On Fri, Sep 5, 2008 at 5:10 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>>
>>> If somebody could explain how they handle the git send-mail patches
>>> they recieve, I would be thankful. How do you create .mbox files? W=
hat
>>> is your workflow when you deal with mails?
>>
>> I almost always use git-format-patch to generate patches (some peopl=
e
>> use git-show or git-diff for proof-of-concept patches), and either u=
se
>> git-send-email (I have sendmail configured to send mails via GMail,
>> but my computer is single-user machine; you can try sendemail.smpt*
>> options instead, if you have appropriate Perl modules installed), or
>> use KMail: Message> Insert file, ensuring that in Options I have Wor=
d
>> wrapping turned off.
>>
>> In some rare case I used 'stg mail' (also via properly configured
>> sendmail).
>=20
> My question was about handling the patches you receive. Sending
> configuration is quite easy.

Sorry, my mistake.

Handling received patches is even simpler. In KMail/KNode us Save As
(with .txt or .patch extension), the "git am --3way <file>"
(or, but only once, "stg import -m < <file>").

--=20
Jakub Narebski
Poland
