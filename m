From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Fri, 27 Nov 2009 11:56:25 +0100
Message-ID: <46a038f90911270256w57487e6cq9bda8b98a5384799@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
	 <4B0CEFCA.5020605@syntevo.com>
	 <76718490911260927h9ff796bgbebcccab7e52ffbe@mail.gmail.com>
	 <4B0FA388.4030507@syntevo.com> <4B0FA7D7.1050302@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 11:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDyV9-0004jN-9z
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbZK0K4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 05:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbZK0K4V
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:56:21 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:24421 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbZK0K4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Nov 2009 05:56:20 -0500
Received: by ey-out-2122.google.com with SMTP id 25so106156eya.5
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b1GaPuivJFUKhGsg7vT705jNCTbRhm0ye+gZ7xNpX00=;
        b=uDZpuVRK3x9zNHbMR1j0YWvhSZlPidXAylU5tAy4dNvy2R51x0T8kExd9BGd3K3Xv9
         0OOzfRNBSmjXiaTLtNsDj+BIFP40xVGwGLcu6KV2bl/hvT+wbNVTcnfhQlglS+KjGy7A
         ZuQ3LwRzSsJ2XckiMcURBBPTidNXBSUCz1JQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RhP025S/V3/KlbpzxZXz+H/qKr9p1FaaQIt5P//PmsleI38oqJEMpigYkYud9kAXyw
         /DudSR3ucAZiC8tL7EqhHi5T6pYveBrnvF5DQfgwkCB+vGyVJ72RbAB6yMsvGPaYdJDt
         ymeF0tmts5b9pIFqDT9JZkU3B+7bNpcpZujGo=
Received: by 10.213.63.136 with SMTP id b8mr227533ebi.71.1259319385949; Fri, 
	27 Nov 2009 02:56:25 -0800 (PST)
In-Reply-To: <4B0FA7D7.1050302@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133891>

On Fri, Nov 27, 2009 at 11:20 AM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
>> toms-mac-mini:git-umlauts tom$ git rm --cached "U\314\210berla\314\2=
10nge.txt"
>> fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any fi=
les
>
> OK, I've found it. This works (I have to complete the file name after=
 having
> typed an U):
>
> toms-mac-mini:git-umlauts tom$ git rm --cached =DCberl=E4nge.txt

Tom,

have you tried calling git-update-index --add
--stdin -z? Your original email stated

> we've got a problem report regarding our SmartGit GUI client

so it sounds like you are building a porcelain. In that case, the
sanest approach is to invoke git-update-index and write to its stdin.

cheers,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
