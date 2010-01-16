From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 20:22:38 +0100
Message-ID: <40aa078e1001161122k48f55807y3f01fa0d38e5cc93@mail.gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
	 <40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com>
	 <fabb9a1e1001161117t6d572024yc5598be1b32ffcde@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 20:22:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWEEQ-0006KQ-IW
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426Ab0APTWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756392Ab0APTWl
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:22:41 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:34220 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab0APTWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:22:40 -0500
Received: by ewy19 with SMTP id 19so1959685ewy.21
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=WbUg9X+YXDgMP2PZudoBaVjobecQ2su5/u8YSBK0XJQ=;
        b=HYb44elB5po+R3UIViBpejtLcNMQcml7KfNVcN9OeQhBVasuB1CxTUKoHwjnHktipB
         eaBlNeftGRiinH1blKB/nv66gV3Lid8iF1kxyIBzzoUwWzohbhokA/16Ok3JuFC7ko8e
         XnLpoE4pVCi6NSRgmGDUvZueGf53r3HBR5QeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=jRXz/0yeXeDufziEjuIyvPru6FjAwEPiC67KXY6rsqBC4JU6uGOozhWn/DF67OOMXr
         11mvLql2aO7Qw5cFIuXNFlr5unusfftNXeTD+I2IjmqQoFXsPfxK6HUira5eFMl+acT1
         9k0jaZbET/1z9RLOOqV29xvIK++e+qkT2Nz38=
Received: by 10.216.88.75 with SMTP id z53mr238569wee.46.1263669758880; Sat, 
	16 Jan 2010 11:22:38 -0800 (PST)
In-Reply-To: <fabb9a1e1001161117t6d572024yc5598be1b32ffcde@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137254>

On Sat, Jan 16, 2010 at 8:17 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sat, Jan 16, 2010 at 20:14, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>> I think you are looking for "git rev-parse HEAD". This outputs the
>> hash of HEAD as a single line on stdout. Or even better, you can use
>> the "git describe"-tool, which gives a nice and short description of
>> the commit relative to the most recent commit.
>
> It would be better to have a look at gitattributes [0] instead.
>

Since he's looking for a replacement for SubWCRev (as opposed to
svn:keywords); not really.

-- 
Erik "kusma" Faye-Lund
