From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 19:33:44 +1000
Message-ID: <fd1b0343-d92f-4e51-a54e-a7629ea31028@email.android.com>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net> <5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org> <m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org> <87ppjt6xjv.fsf@igel.home> <87lhugu7iw.fsf@fencepost.gnu.org> <87vbtk60lh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 19:03:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhwJ-0005Yp-48
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbaEEJeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 05:34:01 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:56586 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbaEEJeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 05:34:00 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1908046pad.23
        for <git@vger.kernel.org>; Mon, 05 May 2014 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=6rw1km6HmjzT5LuImBI2MBEzVgh5KFf2A2//IWAnmvo=;
        b=gHjsSyLKOn8g/Y+//evtgiwntWgRwre/Smms0RtKZAvwXhmwkKenyRdE3S0y7QTcp8
         Hg+OIYgU8eLkvJGLYjHfmRBL+jYGEgeVSYtoKYcBbIhVjY56ixrJI519KExLSV64RadH
         87mHIZOL4gQCJksJkCYLlalmo3kbg4+2p9g3XUqxKmjX5Z0dZhC1+iMHjYkPgN7plTIK
         8CsafoIrBNoSJfF3mdBk/wVd1PjNQlN3tYJm0cxynKREMBVudFNwCBA7yBZasSTka7QW
         44BoBk64FRrL8lDNM/lLG5LTP4Fe+GKNXIOqUocqSTcQKmwLjdE5XqSOI3OqpCEzBDu7
         VeUQ==
X-Received: by 10.66.142.42 with SMTP id rt10mr69984224pab.1.1399282439748;
        Mon, 05 May 2014 02:33:59 -0700 (PDT)
Received: from [10.84.189.122] ([101.119.29.104])
        by mx.google.com with ESMTPSA id xr9sm66434969pab.5.2014.05.05.02.33.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 May 2014 02:33:56 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <87vbtk60lh.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248168>

On 5 May 2014 19:23:06 GMT+10:00, Andreas Schwab <schwab@linux-m68k.org> wrote:
>David Kastrup <dak@gnu.org> writes:
>
>> It does not as far as I can see guarantee that a pointer to something
>> of the same type of its first member can be converted to a pointer to
>> a struct even if the struct only contains a member of such type.
>
>This sentence doesn't make any sense.  If you have an object of struct
>type then any pointer to the first member of the object can only be a
>pointer to the one and same object.

I think what David means is that a pointer to a wrapper
can be derefed into its internal, sure, but an object of
that internal type can't necessarily pretend to be a
wrapper.

That said, obviously I'm not David, so I could be wrong.
That's what I got from his statement, though.

Regards,
James Denholm.
