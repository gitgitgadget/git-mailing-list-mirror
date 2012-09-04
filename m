From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Tue, 04 Sep 2012 20:59:52 +0200
Message-ID: <50464FA8.3020104@gmail.com>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org> <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org> <50425F8B.5020406@gmail.com> <7voblognny.fsf@alter.siamese.dyndns.org> <5044D162.1010608@gmail.com> <7voblmeua3.fsf@alter.siamese.dyndns.org> <CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com> <7v4nneduvj.fsf@alter.siamese.dyndns.org> <CANGUGtChELcXe08JtrJW=rt48xOSSeEd9tCgcJvtHiKaX5GCMQ@mail.gmail.com> <7vd321dc0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8ySM-00019G-Ry
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574Ab2IDTGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:06:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64477 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540Ab2IDTGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:06:31 -0400
Received: by bkwj10 with SMTP id j10so2813418bkw.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6xBJMYGkTN9W91eAurR6sFOwOc8/m4FU/7T2rz+saws=;
        b=y1idXlaS7Q8R2FcHq/SytLpbpPJkBylpCfEPdHTRE7/bXGvi4tOpPlx4dzJtTr2lNG
         etlr5WHGLW/MofcMf6aMYuVSw3kFQt/Tfo0Hh4d7WjdK0J2Lyu4udaSz5kGc+fXDudv7
         OZb8cXeOG3jdaeYJVPN9MI9efxHk0JRNwILVAF+R+NlEdSAwXZ1k0VxlU5swSRR/hm67
         kgUxXRnXicOUR+NqlZDetHxwiRn5B/G7Vvla/av8O2gmqmTfdmBJsZKx8zV4zrtJ4Eyg
         MsLN725puFOOoreNxccRIsW+FrvN3/INuyzdDnGsOW6LDF4mpDdFReOEhzNKc8phtQwX
         Zp6w==
Received: by 10.205.117.141 with SMTP id fm13mr8747266bkc.125.1346785589924;
        Tue, 04 Sep 2012 12:06:29 -0700 (PDT)
Received: from [95.251.12.204] (host204-12-dynamic.251-95-r.retail.telecomitalia.it. [95.251.12.204])
        by mx.google.com with ESMTPS id g6sm11251966bkg.2.2012.09.04.12.06.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Sep 2012 12:06:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <7vd321dc0e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204766>

Il 04/09/2012 17:49, Junio C Hamano ha scritto:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> 2012/9/4 Junio C Hamano <gitster@pobox.com>:
>>
>>> I would expect, at least when you are responding to an existing
>>> message, some of them are filled already (and if so, I think appp.sh
>>> wants to know exactly how, for example, has RFC2047 quoting already
>>> applied, or are we supposed to write in UTF-8 and let Thunderbird
>>> massage the contents when we give the file back to it?), and also
>>> there would appear In-Reply-To: field already filled (possibly there
>>> may be References: as well).
>>
>> Message reply is out of scope of my patch. The goal here is send a
>> patch, so the execution flow is to open a new message,
>> clik on external editor (configured properly), select patch file and
>> send. It was the scope of the old script and it is the scope of my
>> patch.
>
> I certainly can understand that you updated the script for that use
> case and that use case only, but given that the original tries very
> hard to preserve:
>
>   - what was in $HEADERS (by only replacing Subject);
>   - the recipients CC'ed in $HEADERS (by grabbing them into $CCS); and
>   - the body of the message in $BODY (i.e. what came after $SEP),
>
> I find it hard to believe that it was meant to work on a freshly
> created empty message and nothing else.  If people were depending on
> the recipients listed on Cc that are taken from $1 to be preserved,
> your patch will introduce a regression for them, no?
>

I think all the process is different. Current script rely on the user to 
fill Cc: and To: in message composition window, it does a union of what 
found in commit message as signed-off-by (adding own address in cc?!) 
and Cc (usually not filled in the commit message and we should even 
count acked-by, tested-by and so on). My vision of things: the user can 
create a patch *already* with all information using --to and --cc. If 
you want to add optional addresses, you can of course add them in the 
composition window. In addition, with this approach is really easy to 
use external script as get_maintainer.pl of linux kernel, load the patch 
and send, really easy. So I don't think it's a regression, it's only a 
change in the work flow.

Marco
