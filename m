From: Eugene Sajine <euguess@gmail.com>
Subject: Re: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 12:52:14 -0400
Message-ID: <CAPZPVFanWTpCDO+A0dV4TWUVx-22VjFOdk6f7cmgfU59GqG3sQ@mail.gmail.com>
References: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
	<7vipnd3trk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:52:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIkEg-0004yJ-H3
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1JYQwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 12:52:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43186 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1JYQwO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 12:52:14 -0400
Received: by iaby12 with SMTP id y12so756306iab.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QVuhEAKu1bpKn1Z06zI00ehsmuJbmSMNqCrI4Hrq7iI=;
        b=vrSm/7g+wwGWjzDcFemwzjSLtU760z96dZMUcOzjjuCGCSoaJBWemS4J7ZJeS+kT9M
         P+PRJ4MAgrpilF5yxkssEJ+uDlnBneJ+YfIcsmSoJIYcTiTwHB4NzkAEpmXpf51SRX1n
         BHQ0IRDnC2iy+LOwnc8wOMuT39tItzJOBs2nU=
Received: by 10.231.21.149 with SMTP id j21mr592870ibb.29.1319561534150; Tue,
 25 Oct 2011 09:52:14 -0700 (PDT)
Received: by 10.231.199.17 with HTTP; Tue, 25 Oct 2011 09:52:14 -0700 (PDT)
In-Reply-To: <7vipnd3trk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184222>

On Tue, Oct 25, 2011 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> We have built git 1.7.6.4 and we have a following problem with it:
>> .,,
>> It doesn't seem to be the case with 1.7.4.1
>>
>> Was there any change between those versions that i missed, or may be
>> there is some property we have to specify during build?
>
> Nothing I can think of offhand that you need to specify _differently_
> between the build procedures of these two versions.
>
> Just a wild guess. perhaps you specified prefix=3D/usr/local/git-1.7.=
4.1/
> eons ago when you built and installed 1.7.4.1 like this:
>
> =C2=A0 =C2=A0make prefix=3D/usr/local/git-1.7.4.1 all install
>
> and then you did it differently when you installed 1.7.6.4, e.g.
>
> =C2=A0 =C2=A0make all
> =C2=A0 =C2=A0make prefix=3D/usr/local/git-1.7.6.4 install
>
>


Are you saying that the first command is more correct?
I will check it.

Thanks a lot,
Eugene
