From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Tue, 12 Jun 2012 01:03:47 +0200
Message-ID: <CABPQNSZuMBUa9bHwmCRDL-dGfRd8FofBf5YsmK=nuMu1iMbnMw@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org> <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <7vvcj1dep7.fsf@alter.siamese.dyndns.org> <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
 <7v4nqjbrdo.fsf@alter.siamese.dyndns.org> <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com>
 <7v8vft97a8.fsf@alter.siamese.dyndns.org> <20120611185311.Horde.RALabXwdC4BP1iJ3aQ-w89A@webmail.minatec.grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 12 01:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeDey-0003Fe-QV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 01:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab2FKXE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 19:04:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52489 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2FKXE2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 19:04:28 -0400
Received: by dady13 with SMTP id y13so6025546dad.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 16:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=UPQPrnlKRUpWs+conXdBAJgenGhF9SZQrb5GQJV9SiE=;
        b=XopAHigBsixxtdgP9i8UAkXQOOWSyXb+s/QdGFtBT+YgmFGYXL08bR9TTWAfZmr8g4
         8n942fySoTaWjDF00SpjuMddTaP5T7Lss9lM+6l3uRjnSGcX5yMuNjcBA4IMzMTuQ9kV
         pnXXAXZJ+xkjQpF6oHXRvJtpN1uSiMUo5TP8cBF5SUds7v7BFUudxw8y62MApE+vpah5
         4mLQOXpH6UspM2gFZigQUARvVu/YkHj9VvfU5j7HiPmFvZuOM7nO9lrGF/UxxB8PDsvG
         uDh7hxri8ZSWYsqoZ/5FsWMvC5BO5/E3gdzOGX9KmoqpEDw/h5ob1W7xYnN2O54R+C1p
         QhGw==
Received: by 10.68.217.166 with SMTP id oz6mr31386702pbc.136.1339455867556;
 Mon, 11 Jun 2012 16:04:27 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Mon, 11 Jun 2012 16:03:47 -0700 (PDT)
In-Reply-To: <20120611185311.Horde.RALabXwdC4BP1iJ3aQ-w89A@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199752>

On Mon, Jun 11, 2012 at 6:53 PM,  <nguyenhu@minatec.inpg.fr> wrote:
>
> Junio C Hamano <gitster@pobox.com> a =E9crit=A0:
>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> The awkward thing about doing this, is that the memory allocated by
>>> the strbuf cannot be reclaimed if you go with this. A pointer that =
has
>>> been adjusted (like cleanup_path can do) cannot be successfully fed=
 to
>>> free.
>>
>>
>> Yeah, I wouldn't recommend doing that. =A0Either
>>
>> =A0 =A0 =A0 =A0path =3D strbuf_detach(&sb, NULL);
>> =A0 =A0 =A0 =A0retval =3D xstrdup(cleanup_path(path));
>> =A0 =A0 =A0 =A0free(path);
>> =A0 =A0 =A0 =A0return retval;
>>
>> or
>>
>> =A0 =A0 =A0 =A0path =3D xstrdup(cleanup_path(sb.buf));
>> =A0 =A0 =A0 =A0strbuf_release(&sb);
>> =A0 =A0 =A0 =A0return path;
>>
>> would be more sensible.
>
>
> Erik, what do you prefer ? You can have the final answer.
>

I think the latter is the neater one, but I don't really care too much
either way :)
