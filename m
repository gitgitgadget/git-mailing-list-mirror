From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Partial clone/pull?
Date: Tue, 20 Jul 2010 18:38:04 -0400
Message-ID: <AANLkTik6nn0bjQkysY9kfk3rZNKT-CNKtf9BA8MlzGZ1@mail.gmail.com>
References: <29220205.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dread Quixadhal <quixadhal@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 00:38:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObLSK-00072s-5d
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 00:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937Ab0GTWiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 18:38:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35242 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932733Ab0GTWiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 18:38:24 -0400
Received: by gxk23 with SMTP id 23so3237006gxk.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5U0E4ofqfrrfBl9bJUV89xlTXhesqKQSpqwRLg7uqQc=;
        b=vxb8Hef2yNB6uP7u78l+dbRSsikavO2ZIs5oIOOtaKMJbErX80dqu5HNhn1iz4oBsK
         nNIWfmfpZXqKA5vlD7yr5LBxXLZSlPekrvzEt6+CeCrmwWX9ayL73AjIEg9sGY+Vbgde
         HU+MnqPV6GvlP81CTifYTXtFurIItz4sFIjm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lhrV4W/t4tP18cXB+c0HhspLBYEn/jmpMiCtUmVq5uaifwQ+nwFNFgvXwCiRUCmZkL
         UHByDN4BHXMVTaHkcen8fqCaal2XM6XK3N7pMCqpGgHECXlRqSLJXdQ0A0W80R3WfaZC
         PQ4IoICsQmjzRVruEUC3RxmFECufCNkG8Qtko=
Received: by 10.151.133.5 with SMTP id k5mr1055984ybn.115.1279665504116; Tue, 
	20 Jul 2010 15:38:24 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Tue, 20 Jul 2010 15:38:04 -0700 (PDT)
In-Reply-To: <29220205.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151372>

On Tue, Jul 20, 2010 at 6:15 PM, Dread Quixadhal <quixadhal@yahoo.com> =
wrote:
> I'm having some trouble figuring out how to do this. =A0I assumed I'd=
 create a
> new repository and then use git pull to merge the directories I want =
in my
> distribution repository. =A0I can't seem to find a way to specify wha=
t files I
> want though.
>
> Let's say I had a repository called stuff, with directories a, b, and=
 c. =A0I
> want to make a distribution repository containing just a and b, but w=
ith
> full histories so a "git pull" will sync from the stuff repository, b=
ut
> ignore the "c" directory.

This is not a particularly easy thing to do in git.  git-subtree is a
partial solution:
http://github.com/apenwarr/git-subtree

Have fun,

Avery
