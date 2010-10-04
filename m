From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Mon, 4 Oct 2010 15:57:25 -0500
Message-ID: <20101004205725.GJ6466@burratino>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
 <20101004204625.GH6466@burratino>
 <AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:00:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2s9U-00049G-G1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab0JDVAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 17:00:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62107 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab0JDVAp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 17:00:45 -0400
Received: by ewy23 with SMTP id 23so2246386ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ld/RxtSFjTU0iQyYOKLtrc59WsqywHsW2Bl88J9cTqk=;
        b=VxO0zKHHQNbiTNLImGR8aQgSEi2XKdLp2sE0iiL3RgZnzYvzbkbtZi0VZv4nSejexV
         kbDrgl1/MuT3GBLkCJOVgooxPHFeMqqOxuDUY1s6vdvQnylLQYvuS0GqjIs5DrzCwUvy
         nt+eUTSof0mbe3i1q3zGRTgou410aLIYRogNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TdLVIVkA9QMdSAzMFlA/AygkJCHvtPK0hJT0zHOf2TGS7NXs+EUbSdhYAR8J4P5up2
         7sE3IZ33d4M3zzWqwvJ4T1oFOt407/ohEVwmRM/ku19BA9oPsMmS/Es2ELk44+6vElW+
         JNxFnmokAaISmdvCc+lMbWYNs97ntbhvnZNls=
Received: by 10.103.175.13 with SMTP id c13mr3888992mup.30.1286226043637;
        Mon, 04 Oct 2010 14:00:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m17sm960312fag.2.2010.10.04.14.00.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 14:00:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158116>

=46elipe Contreras wrote:
> On Mon, Oct 4, 2010 at 11:46 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> git merge @{u}
>
> Interesting, I don't find anything like that in the documentation.

The @{upstream} notation is documented in gitrevisions(7).  But yes,
a more prominent mention (maybe some examples?) would be nice.

> Moreover, wouldn't it make sense to make 'git merge' =3D 'git merge
> @{u}'?

I think so, yes. :)

>> Maybe 'git pull --all' could be taught to eventually do this? =C2=A0=
That
>> would be incompatible with its current behavior of fetching everythi=
ng
>> and merging some random branch, but I don't think anyone is relying
>> on that.
>
> Maybe, I feel 'git pull' is for single branches or repos, whereas 'gi=
t
> remote update' is pretty clear it's for all the repos

If I remember correctly, the current status is:

 - 'git remote' is for adding, removing, and pruning remotes
 - 'git fetch <remote>' and 'git fetch --all' are for updating them, an=
d
 - 'git remote update' is for backward compatibility.
