From: Ryan Ray <ryan.ray@methodologie.com>
Subject: Git hangs on compressing objects
Date: Thu, 13 May 2010 13:05:40 -0700
Message-ID: <AANLkTik4WMqjkqYady6BQAf2OTPLzCeMoedwrGj8s10T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 22:13:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCemg-0001fj-1C
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 22:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856Ab0EMUNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 16:13:13 -0400
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34309 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932503Ab0EMUNL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 16:13:11 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2010 16:13:11 EDT
Received: from source ([209.85.212.173]) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS+xdUl/8GIbGJ/o34rGEkLP7NhBqusWB@postini.com; Thu, 13 May 2010 13:13:11 PDT
Received: by mail-px0-f173.google.com with SMTP id 19so933738pxi.4
        for <git@vger.kernel.org>; Thu, 13 May 2010 13:13:06 -0700 (PDT)
Received: by 10.140.248.13 with SMTP id v13mr34511rvh.25.1273781160244; Thu, 
	13 May 2010 13:06:00 -0700 (PDT)
Received: by 10.140.174.4 with HTTP; Thu, 13 May 2010 13:05:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147020>

I'm on Mac OS 10.6

ryanray:fhlb2009ar ryan.ray$ git push
Counting objects: 322, done.
Delta compression using up to 4 threads.
^Cmpressing objects:  94% (243/258)

Iv'e tried this countless times today. It just doesn't finish. My
local dir is 6 revisions ahead of master so I prefer not to can my
local dir and re-clone.

Any suggestions? Can I figure out which file (243) is hanging it?

Thanks,

Ryan





--=20
___________________________________


R. Ryan Ray / Se=F1or Developer

Methodologie
720 Third Avenue, Suite 800
Seattle, WA 98104-1870

206.399.5063 direct
206.623.1044 phone
206.625.0154 fax

http://www.methodologie.com
