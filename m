From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sun, 29 Jan 2012 17:26:52 +0100
Message-ID: <CABPQNSYwuo0vXUj2ZWPHihZFpvwao+G8nWTEiBFFUm2xWdd5nQ@mail.gmail.com>
References: <201201212036.57632.tboegi@web.de> <1327184934.31804.32.camel@centaur.lab.cmartin.tk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Jan 29 17:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrXbl-00049C-20
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 17:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab2A2Q1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 11:27:33 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59002 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab2A2Q1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 11:27:32 -0500
Received: by pbaa10 with SMTP id a10so3095303pba.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=7c0evhWfHKRhHKAAcswbX6O1cAm9AIfgNC/T266M+g4=;
        b=LcmSlkUWMcRgaufRiv5NErurwvOSlKkNGQwm8DY1uZp52hQG8wbHG+oXwfurGH77JE
         YJrDAy8tvtE2AE969ehTbhDM04KwgqARvKQj5iLYIcmDfWN3t9KAFZ9/IU0zqWx45Afw
         FkHlvIpEV1CwrnpanF62iSy9sIEfJuExCXCRs=
Received: by 10.68.73.234 with SMTP id o10mr34001358pbv.90.1327854452170; Sun,
 29 Jan 2012 08:27:32 -0800 (PST)
Received: by 10.68.27.103 with HTTP; Sun, 29 Jan 2012 08:26:52 -0800 (PST)
In-Reply-To: <1327184934.31804.32.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189293>

On Sat, Jan 21, 2012 at 11:28 PM, Carlos Mart=EDn Nieto <cmn@elego.de> =
wrote:
> On Sat, 2012-01-21 at 20:36 +0100, Torsten B=F6gershausen wrote:
>> * (Not all Windows versions support UTF-8 yet:
>> =A0 =A0Msysgit needs the unicode branch, cygwin supports UTF-8 since=
 1.7)
>
> This might be overly pedantic, but Windows doesn't really deal with
> UTF-8. To use Unicode you need to use the "wide" variant of the
> functions, and those take UTF-16.

This is exactly what the 'unicode'-branch in msysGit does, so the
comment is not incorrect at all.
