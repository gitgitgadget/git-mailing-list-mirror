From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC] Distributing Windows binary package compiled with non gpl code
Date: Fri, 28 Dec 2007 09:17:30 +0100
Message-ID: <e5bfff550712280017m6d2b228bne1db05bd54fefd48@mail.gmail.com>
References: <e5bfff550712271032q25d135e7y47d68337e937d401@mail.gmail.com>
	 <alpine.LNX.1.00.0712271647130.13593@iabervon.org>
	 <fl1bcn$k2h$1@ger.gmane.org>
	 <alpine.LNX.1.00.0712271846380.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Abdelrazak Younes" <younes.a@free.fr>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 09:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8APn-0004qe-9q
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 09:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbXL1IRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 03:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXL1IRd
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 03:17:33 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:29015 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbXL1IRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 03:17:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3259493rvb.1
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 00:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qPJ4excDvu/56b/1cvii6pZG78QQ6yq+fHQFNVqQ848=;
        b=S6rDm9y6xrQuAe9fRgBb2mzlngkKRMl1oKir1jXGahfPD2JhaqITaw8nHfoo++pq+/blJZ0heXzU7Ri9goLR+0pFUmDf7bkp2RD/mKg2HzbbxoeqTOlajbYYm2HvucZ1PCT0F+s+nM13eiAYlPXuCaDFwcXqCECLdHRu9Kg8Erk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vsyCXJU0C2tiDbI6/dK7anrCBxK/FPp3niGLhduKgNvfQCZ9wtbG2VSRy0VgPEsnu2+JG0jqopDT/eF7fjEubuy6OzCFs6usUN9qZBKL6IVdLdvhZP4bOrtUtRYUi4tqxhXaqiqnxMg5Rvl5mpB5pfDAEpkTvJBnTr8xDfOcTX0=
Received: by 10.141.211.13 with SMTP id n13mr4567164rvq.184.1198829850083;
        Fri, 28 Dec 2007 00:17:30 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 28 Dec 2007 00:17:30 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0712271846380.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69279>

On Dec 28, 2007 1:05 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>
> It probably actually falls under the "system software" exception, in that
> case (when distributing source, you have to include everything needed to
> build the source, except for normal system software, which you can assume
> the recipient has).
>

Reading the GPL FAQ at www.gnu.org I have come up with following
clarifications that IMO apply to this case:


http://www.gnu.org/licenses/gpl-faq.html#WindowsRuntimeAndGPL
-------------------------------------------------------------------------------------------------

Q: I'm writing a Windows application with Microsoft Visual C++ (or
Visual Basic) and I will be releasing it under the GPL. Is dynamically
linking my program with the Visual C++ (or Visual Basic) run-time
library permitted under the GPL?


A: The GPL permits this because that run-time library normally
accompanies the compiler or interpreter you are using. So it falls
under the exception in GPL section 3.

   That doesn't mean it is a good idea to write the program so that it
only runs on Windows. Doing so results in a program that is free
software but "trapped" (in this case, trapped by Windows instead of by
Java, but the effect is the same). (Historical note: As of December
2006 Sun is in the middle of rereleasing its Java platform under GNU
GPL.)




http://www.gnu.org/licenses/gpl-faq.html#GPLCompatInstaller
-----------------------------------------------------------------------------------------

Q: I would like to bundle GPLed software with some sort of
installation software. Does that installer need to have a
GPL-compatible license?

A: No. The installer and the files it installs are separate works. As
a result, the terms of the GPL do not apply to the installation
software.




http://www.gnu.org/licenses/gpl-faq.html#NonFreeTools
--------------------------------------------------------------------------------

Q: Can I release a program under the GPL which I developed using non-free tools?

A: Which programs you used to edit the source code, or to compile it,
or study it, or record it, usually makes no difference for issues
concerning the licensing of that source code.

    However, if you link non-free libraries with the source code, that
would be an issue you need to deal with. It does not preclude
releasing the source code under the GPL, but if the libraries don't
fit under the "system library" exception, you should affix an explicit
notice giving permission to link your program with them. The FSF can
give you advice on doing this.



http://www.gnu.org/licenses/gpl-faq.html#GPLIncompatibleLibs
------------------------------------------------------------------------------------------

Q: What legal issues come up if I use GPL-incompatible libraries with
GPL software?

A: If the libraries that you link with fall within the following
exception in the GPL:

 "However, as a special exception, the source code distributed need
not include anything that is normally distributed (in either source or
binary form) with the major components (compiler, kernel, and so on)
of the operating system on which the executable runs, unless that
component itself accompanies the executable."

    then you don't have to do anything special to use them; the
requirement to distribute source code for the whole program does not
include those libraries, even if you distribute a linked executable
containing them. Thus, if the libraries you need come with major parts
of a proprietary operating system, the GPL says people can link your
program with them without any conditions.






The last FAQ is not very clear IMHO because the rule says "unless that
component itself accompanies the executable" (as is the case with my
distributed dll) but after the explanation says "the requirement to
distribute source code for the whole program does not include those
libraries, even if you distribute a linked executable containing them"


Marco
