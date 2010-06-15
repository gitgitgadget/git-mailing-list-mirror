From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mailinfo: parse From header more strictly when run from 
	rebase
Date: Tue, 15 Jun 2010 13:01:40 -0400
Message-ID: <AANLkTimmJEGf8UeGxJHhTn1BPiCQEoqhz4KkIiP5qewS@mail.gmail.com>
References: <1275885945-29241-1-git-send-email-jaysoffian@gmail.com>
	<7vzkyw6zo2.fsf@alter.siamese.dyndns.org>
	<AANLkTina5G9P-OkGAoia0DeJhPygRaoaiI7tXDRHgjtF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 19:01:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZWR-0006gs-B0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab0FORBo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 13:01:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44625 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757927Ab0FORBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jun 2010 13:01:41 -0400
Received: by iwn9 with SMTP id 9so4718827iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P61k2JNrmuwzZxusd+1KXojvL4WZTqcd5JjNRwrLrWk=;
        b=eYtgT8tIpjLK83wb4NWRglFk4z1r6bfWwofcF31z/U+C0KeAB9Wb88qX/efiugaufy
         Rw4vGLgodk7mjwhOeMNmdQ/xnHAeayFdbwfye0urFKzgg+uw0TJdwzIW0q92BMvVqGeZ
         duYF2+ANs6HKmPOafLSTihvpHMEriIjzdR7lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rj8QbwjTJSe65Tz2uiIUUNDpPaAFPxl38wM7u6w7fh+kLhF67Ud0cy0FjH+caC22Sm
         4XlltGgFk/53A7WzCEHFGnubWRY+yGqIMEqk5qzXXzvxeJk3j5W4flgE+x7OoO40jbzA
         K/XHR+tftgP+icyQNS/JtGGRZJ2FsRWF/6yGw=
Received: by 10.42.7.130 with SMTP id e2mr2616290ice.3.1276621300159; Tue, 15 
	Jun 2010 10:01:40 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Tue, 15 Jun 2010 10:01:40 -0700 (PDT)
In-Reply-To: <AANLkTina5G9P-OkGAoia0DeJhPygRaoaiI7tXDRHgjtF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149208>

On Tue, Jun 15, 2010 at 12:41 PM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> On Tue, Jun 15, 2010 at 12:14 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Sorry, but it is unclear from your message what problem you are tryi=
ng to
>> solve, what your desired outcome is, and why you think that outcome =
is
>> desired. =C2=A0The bracketed one shown above does _not_ look like a =
valid email
>> address, so using
>>
>> =C2=A0 =C2=A0name =3D "author@example.com"
>> =C2=A0 =C2=A0email =3D "author@example.com@11B4..."
>>
>> does not sound like a good thing to do to begin with.

In fact, that is an invalid email address (I thought it might be valid
per historical source-routed syntax, but I just checked the RFCs and
it's not even valid for that). Nonetheless, my goal is that I can
rebase a commit without the address (even an invalid one) being
munged.

j.
