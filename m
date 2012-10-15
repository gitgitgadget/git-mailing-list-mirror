From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: push race
Date: Mon, 15 Oct 2012 17:50:47 +0200
Message-ID: <CAB9Jk9A8E57byg+1yzc22ByC_3VQd0j+HGu8Sj9121=LToopyg@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
	<CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
	<507C1DB4.2010000@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Oct 15 17:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNmwV-0006O2-L7
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 17:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab2JOPut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 11:50:49 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58001 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab2JOPus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 11:50:48 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so1918451vcb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QDyIlKpy2g1fUA4RREQtI0iAYBCp7bubWkvT/WllFsg=;
        b=lzvb1glhMV5YCDDG3Nk9rdQMFBL7ldPxSTG74sKUdHjQzfikl1hPdMQxlln6I5rnHX
         5wRiaAkzCGwOQC1v1alUe2pQyAu+Nf06a26JrSr9NsXUilKIl/dxRP2JprdAV+yo7iXI
         zMUrjVgRo0OwoqlqyJikYdhCvZ9N6Dp7a8jsaH7zf0uqFdTVBsyF70/CmLjGMa8RnRNw
         M6RzIk+FRJINH0zTPJFGxR3Zr0tsuWgyqjiCpL0XJoL+sZN0cJM44h2A3DwrO1907ruC
         Jmh4SW/ALHikq/6mKsItnSytGTna2HADHdbsCOB/r/JZtqpMe8ZAuzPK9eor702Itqa8
         8ogg==
Received: by 10.58.189.33 with SMTP id gf1mr7181346vec.41.1350316247601; Mon,
 15 Oct 2012 08:50:47 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Mon, 15 Oct 2012 08:50:47 -0700 (PDT)
In-Reply-To: <507C1DB4.2010000@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207757>

Hi Marc,

correct, there will be no file overwriting because no files are
written on the work tree.
I tried to follow the actions of the program, but did not quite catch
the 6. you mention.

-Angelo
