From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: Qgit should use "git config" instead of "git repo-config"
Date: Sat, 14 May 2011 09:35:54 +0100
Message-ID: <BANLkTin4kkzChJwh209SOD9-rJSiQxdGcQ@mail.gmail.com>
References: <4DC85AA7.2090502@socialserve.com> <20110509231942.GA23781@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Rogers <jrogers@socialserve.com>, git@vger.kernel.org,
	Thiago Farina <tfransosi@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 10:36:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLAKj-00006U-9q
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 10:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab1ENIgR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 04:36:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41471 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab1ENIgQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 04:36:16 -0400
Received: by yxs7 with SMTP id 7so1113066yxs.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=idf5C2r4l5frTvuSQU1s2Jm1IHAu2XY/yrByE+GG90k=;
        b=w7XWkBR2itTo8lGPY6wnN+qlzPGZF4HFBExU38qTrdqDF47hjqD0yPweC1Ma3yxIZ7
         8HCKhoWVM/Lt7TznYefnhKKBOPGUurrS46EJr0IMS/tt0WNRFgjFnmPiyrvA4+PwrxY3
         pgStaTfB6VWtR60GPIJxteLAJvNMLUrVQSBJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KurgLhfYyLgaq0VrxBbnb5d29I9rCQGy+qwpNEEGIw2DMyFo/ip64TDQMOjJrrH/KL
         cHcGNR1HOPyUFUtYRctsYMwlbOOqh96+jDCqg5QXo8091pmKl8DB0qjOTgs+WSrnXrxW
         88aFsg+x3wfB5LGc47q0oc/Xq0I7jvJoxHYvc=
Received: by 10.236.182.105 with SMTP id n69mr2469304yhm.199.1305362174149;
 Sat, 14 May 2011 01:36:14 -0700 (PDT)
Received: by 10.236.108.139 with HTTP; Sat, 14 May 2011 01:35:54 -0700 (PDT)
In-Reply-To: <20110509231942.GA23781@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173576>

On Tue, May 10, 2011 at 00:19, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi Jonathan,
>
> Jonathan Rogers wrote:
>
>> Here's a small patch to cause qgit to use "git config" instead of
>> "git repo-config" in a couple of places.
>
> Thanks! =C2=A0I noticed you also submitted this at [1].
>
> Looking at the qgit source[2] I don't see an address to send patches =
to;
> cc-ing Marco for advice.
>
> Hope that helps,
> Jonathan
>
> [1] http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D3299=
672&group_id=3D139897&atid=3D744829
> [2] http://git.kernel.org/?p=3Dqgit/qgit4.git
>

Hi Jonathan,

   thanks for the patch, please send to git list (if other people
don't mind), I more or less routinely read the list. I really should
do at least some maintenance work on qgit that has gone vastly
bitrotten in the past months.....

Marco
