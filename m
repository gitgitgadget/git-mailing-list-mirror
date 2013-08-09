From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 8 Aug 2013 17:11:10 -0700
Message-ID: <CAPc5daXLzM1zG-6-mfddrSywzA=P3NB5Q9kJ6uEwAy-UWmqucg@mail.gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <7v61vg9eht.fsf@alter.siamese.dyndns.org> <ku1blo$5so$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Damien Robert <damien.olivier.robert+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 02:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7aIq-0005ic-03
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 02:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966883Ab3HIALc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 20:11:32 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:42215 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966748Ab3HIALb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 20:11:31 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so2610020lab.14
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 17:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oyj0SL3msvD4CgQFb8FaEHXbTnxX4OoQfek4xI3lxN0=;
        b=Zs3y1Xxnfe1VogE75vAXwAzpEuo7zhngyygT3ndetkORGNBwIchY6a7JVsDvK1EMeJ
         18pLgoBtf5nIJtd5e0Iw1nI44Cd2lNYnsZkl/O+vGe/Eqr05HPPXlsYw9YcxVNmvKmLZ
         os3G+hdGalLmiGC/jVAQEHh8SE76bXy1Lh6oj/9TjEQpVeZ0RZxK/25SVag7BLOcrmzq
         gQhPKlSkuxU0Rh0n3J7YUn+fbMUr0/wqaV9uDQ6t/3zS1PQgHVfP5budqqX5NOZVCbrP
         XhTR7SLMqFI+f6hQWgZ+LReluFgl9vI64GXqBLASRtssVGGzTAr8DlefFVpRI4R09RsQ
         oMuA==
X-Received: by 10.112.159.100 with SMTP id xb4mr3364875lbb.91.1376007090122;
 Thu, 08 Aug 2013 17:11:30 -0700 (PDT)
Received: by 10.112.219.200 with HTTP; Thu, 8 Aug 2013 17:11:10 -0700 (PDT)
In-Reply-To: <ku1blo$5so$1@ger.gmane.org>
X-Google-Sender-Auth: ItrzkFzg6t_A8kl4D6Qpml4onz8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231953>

>> The above section primarily explains the use of diff-tree and it was
>> appropriate back when git-whatchanged was a script.  The intent of
>> the whole document, not just this section, was to tickle the
>> curiousity of the users and encourage them to see how the above
>> "much more powerful" whatchanged was implemented by going to the
>> source.
>
> Well in this case you can say that the intent was successful since it made
> me read the source code ;)

No, it is a failure. "By going to the source" was meant for
"git-whatchanged.sh" source,
a scripted version of Porcelain, so that users can mimic what is done
in their script.

Reading C source would not help them.
