From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 10:34:33 -0500
Message-ID: <9e4733910712120734r2618e882w1e6f930c74f3065a@mail.gmail.com>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
	 <Pine.LNX.4.64.0712121453150.27959@racer.site>
	 <alpine.LFD.0.99999.0712121001430.555@xanadu.home>
	 <34660cca0712120719p2d7cda44s97ab770abd648742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Tbu-000538-Vg
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXLLPeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 10:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754019AbXLLPeh
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:34:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:2406 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbXLLPeg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 10:34:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so460515wah.23
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4/e0kxqlM0zoTn2MW5oC7oNkBTctT6oo4sxVfrwOvgE=;
        b=Oj7tXFHvSDoZ7L53eoY7hGfGIEFuzelhO2pzWTtRmvM8nJdVrEwpDwkzrTYTSxJr4TQHuvZtRmhpQBTry2NWD5nx9mKjYkUzrHqtErZREIl3h/jYeMDCDoTHsvdhXbHJL3/BNUKFZll6UfbB97lyr0N47guPocqxPnvTfABoqF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wbOp1YgJtjlGgYk4EkF8kVB5uGhSW0FRJBnwfBtjFQXvczPNrle0xDrEwM0ZgXlLc+keIobP+ZEEjlbZ2ITdlyXTHTHNGrfgxrPoW8NceeVTFbUAbxcZZjFiSckVafB+s8HoMSEjSoq9kI+bipMS0Bq22hCiU6B+9XXXOi2ehZU=
Received: by 10.114.13.1 with SMTP id 1mr898056wam.106.1197473673819;
        Wed, 12 Dec 2007 07:34:33 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Wed, 12 Dec 2007 07:34:33 -0800 (PST)
In-Reply-To: <34660cca0712120719p2d7cda44s97ab770abd648742@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68052>

On 12/12/07, Eirik Bj=F8rsn=F8s <eirbjo@gmail.com> wrote:
> > On the other hand, this is pretty trivial to extend the protocol so=
 only
> > commit objects are transferred.  Using 'git log' on the client side
> > would work, as long as you don't use any of the content walking opt=
ions.
>
> Nicolas,
>
> So what you're suggesting is that:

Write a script the runs the command locally on the remote sever and
emails you the info. Or ssh to the remote server and run the commands
locally.

>
> 1) git-clone could be changed such that the user could ask not to
> fetch content, only commit objects.
> 2) git-daemon (or the protocol layer, again I'm not familiar with the
> implementation) could be changed such that it only sends commit
> objects on request.
> 3) Changes to git-log is not necessary.
>
> Anybody have a clue how much work this would require and if this is
> something that would be generally useful for the community?
>
> Eirik.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Jon Smirl
jonsmirl@gmail.com
