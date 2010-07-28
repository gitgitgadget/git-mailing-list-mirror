From: Tong Sun <suntong@cpan.org>
Subject: Re: Recommended work flow with git to send in patches
Date: Wed, 28 Jul 2010 19:30:33 -0400
Message-ID: <AANLkTinfobkVFVfqgUV9QiExosfW=W3gAFr3DmDb1URw@mail.gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
	<m3y6cwkew7.fsf@localhost.localdomain>
	<AANLkTikkXQNiaagPGN5cYCDg6hfvojpLcEePWF6UbUDV@mail.gmail.com>
	<201007290120.05093.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 01:30:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeG5A-0001cr-Dy
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 01:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab0G1Xaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 19:30:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49941 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab0G1Xae convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 19:30:34 -0400
Received: by yxg6 with SMTP id 6so1189830yxg.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=9SRP+i8VGkKe9jIP20B8yZYvQPyca3lBWA4foqP6b2U=;
        b=pKiCNy6XHNW1cYcLbCoU21M62ZyPA4yB6XNSNtAvfnHdPV0IKToESl0tmjsN1jPhPy
         90iyD65CrcEbVmZcWvVgQeKCL+f94cYtH+239o8SH6nqEoS+zD8cGYI5OX12Eq1Xw/xz
         12tClAWGe+zcrthyw1BaVCfK+saodfsyBpbVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=LhHp1oWknHh4E5plQGC8e+na9rxEtoH80qZscTj5lU5wvcCYXvHl6fYqnU0NNzVviZ
         /GrFclC+is/TpbFJ8QOgBCC1LMRHM+cKWlPZsUIm3nhMXaqjuLsboxUcC14z1Xv2nrNK
         6G9kPMlBakayQ8TSAk62AciWzO5fONcR6cWc4=
Received: by 10.150.117.13 with SMTP id p13mr80458ybc.20.1280359833983; Wed, 
	28 Jul 2010 16:30:33 -0700 (PDT)
Received: by 10.229.233.206 with HTTP; Wed, 28 Jul 2010 16:30:33 -0700 (PDT)
In-Reply-To: <201007290120.05093.jnareb@gmail.com>
X-Google-Sender-Auth: oZMm5sougDPa8ownL2gEkY555vU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152129>

On Wed, Jul 28, 2010 at 7:20 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>>> If you plan to continue working on this repository, and it is not
>>> one-shot patch or patch series, it would be better (easier in the
>>> future) to use "git remote add".
>>
> . . .
> I don't think that would apply in your situation, but "git remote add=
"
> is used if you want to fetch changes from more than one upstream repo=
sitory
> (or you want to configure repository to push into). =A0This is an alt=
ernative
> to one-shot "git pull <URL> <branch>" which does not save _any_ infor=
mation
> about upstream you fetched (pulled) from.

Got it.

> See git-remote manpage for details.

and http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html as=
 well.

thanks again. no more questions for now.

cheers
