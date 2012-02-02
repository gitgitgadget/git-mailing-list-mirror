From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 11:38:49 +0200
Message-ID: <CAMP44s0nD4p9=fwpLwchmGJ123onLmRaSPmOL+cYpTFCJ-jwXw@mail.gmail.com>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
	<1328145320-14071-2-git-send-email-felipe.contreras@gmail.com>
	<20120202081622.GB3823@burratino>
	<CAMP44s3FxUmnpQevoV2ARJpWK9CJ16zXDmpJRDOLHNW6RdSc5Q@mail.gmail.com>
	<20120202091059.GE3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rst87-0000SC-8z
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab2BBJix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 04:38:53 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47117 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754589Ab2BBJiu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 04:38:50 -0500
Received: by lagu2 with SMTP id u2so1167477lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6LgX5VJHGFiI5Z6jvGolM3uHLA/V8wexJdPQDnmuVh0=;
        b=R204Q3QlAdVqFVbYtm9aCVl7zNFo/+3spJ30qQijzZG/5I2gx/h5SDp/7UBl6t95m1
         uvfL/cdlk0bY6f4Onh0wu8IyxmAkQErT300O9PtD3V0e8j4Z6/lVbrKiHyi06y3Z80Of
         rC4ZhhsSxzwEBUeGc6XN4Gs4DG8Ssc2/bjWA0=
Received: by 10.152.130.98 with SMTP id od2mr405966lab.3.1328175529162; Thu,
 02 Feb 2012 01:38:49 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Thu, 2 Feb 2012 01:38:49 -0800 (PST)
In-Reply-To: <20120202091059.GE3823@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189608>

On Thu, Feb 2, 2012 at 11:10 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> (dropping Shawn from cc list, since I don't think he's touched the
> =C2=A0completion code for years)
> Felipe Contreras wrote:
>> On Thu, Feb 2, 2012 at 10:16 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> Patches didn't hit the list again. =C2=A0Any idea why?
>>
>> No. A bug in list software?
>>
>> I didn't get any warning or error.
>
> Except in response to HTML attachments, I've never seen vger return a=
ny
> explanation when it decides a message is spam. =C2=A0It just discards=
 them.

Which is wrong, because when it discards them wrongly nobody knows why.

> See [1] for details. =C2=A0If there's no obvious explanation, I'd sug=
gest
> contacting the postmaster.

But there's nothing like the taboo words in the mail:
http://vger.kernel.org/majordomo-taboos.txt

--=20
=46elipe Contreras
