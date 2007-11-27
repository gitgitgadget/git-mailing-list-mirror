From: gapon <gapon007@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 14:45:47 +0100
Message-ID: <200711271445.47695.gapon007@gmail.com>
References: <200711271127.41161.gapon007@gmail.com> <200711271231.51270.gapon007@gmail.com> <81b0412b0711270503s7e69be3bn151cfa58b8067f35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 14:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix0lg-0003on-IV
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 14:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbXK0Np4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 08:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbXK0Np4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 08:45:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:17946 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbXK0Npz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 08:45:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so953377nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 05:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=542J8DF64R6Qqhv90ToCM9BCKH9NqDZLa+opT/IkPqc=;
        b=F2HqjnN00j3eUvT6IacBqWYCYgVEfsg7enrS75ibdgJjDFZDn+o1EwfrFncXVLNYo5qKjXgpjNcE8wH4zfAIa76iTKrNau7+bXqY+c4Uhehl7pn71b2c3GwSUPgsauBdKgJOE5gjJUv0/jLQxadnNQ8mvXcwoWmD+KwSDzrAepU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lQCObzPqHlRxd2LxlavcHZ4xb/I6iCo9bItx5zWDmGmNFAt4JYn/sWVdVyTZjyHE6vW/w2N8FSSzqHtQUH7DD+fbitlxeuQDZnrDY14zoqpH5Fvlgv4sGO/+w57NDIhwYCF2k9RuhgyU/aCqOxVMf+T75s1gp9jjlZQPqZvftFA=
Received: by 10.82.118.2 with SMTP id q2mr10607163buc.1196171153615;
        Tue, 27 Nov 2007 05:45:53 -0800 (PST)
Received: from dhcp-eprg06-20-185.czech.sun.com ( [192.9.112.196])
        by mx.google.com with ESMTPS id 28sm4537365fkx.2007.11.27.05.45.52
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 05:45:52 -0800 (PST)
User-Agent: KMail/1.9.7
In-Reply-To: <81b0412b0711270503s7e69be3bn151cfa58b8067f35@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66209>

Dne =C3=BAter=C3=BD 27 listopadu 2007 Alex Riesen napsal(a):
> On 27/11/2007, gapon <gapon007@gmail.com> wrote:
> > as i wrote in my first email - i know that this is not "correct" sc=
enario
> > (i don't and won't use it anywhere) - but the git's behaviour is in=
 such
> > case confusing, at least for me
> > just for clarification - my email wasn't about how to push or creat=
e
> > shared repository - it was just about what i have discovered while
> > playing with different scms
>
> Well... It is known problem, for one. That user B of yours, did he ju=
st
> cloned user A's repo?

yes, i can paste here all the scenario step by step if you want
>
> What I suspect is a change in how git-clone setups the cloned repo
> could have taken care of it. We could either setup push-configuration
> so that it just does not work (and let user change to his preference)=
,
> or somehow figure out where the pushed references can safely land
> and put that in the cloned repo configuration (that is "SOMEHOW",
> I afraid. Absolutely no idea what could that be).

hard to say what to do, what is correct - now i would say that i like h=
g=20
behaviour the most - but i can be wrong of course; the only purpose of =
this=20
discussion is that i have found out (by accident ;) "weird" behaviour o=
f git=20
in such situation - and because git is definitely my most favorite scm =
i=20
wanted to report bug/feature/whatever

thanks for all your comments guys
