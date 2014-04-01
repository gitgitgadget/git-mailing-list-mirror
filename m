From: Michael Toy <michael@toyland.org>
Subject: Re: git-status -- trying to understand all possible states
Date: Tue, 1 Apr 2014 16:01:21 -0700
Message-ID: <1DC6FC8F-3CF8-4DDF-8B34-9349E8289C47@toyland.org>
References: <4AF06B83-E928-4FE2-8094-F23CE3BA1EBC@toyland.org> <xmqq4n2czq6n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVdep-0004JW-T2
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaDAXBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 19:01:25 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:62478 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbaDAXBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 19:01:24 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so10244749pdj.37
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=23Vcm7wzXwvurnUs+D2chTnGM9mf6DdcDJgjm2nmD7U=;
        b=nJh9rUtlg+13Z78g6/5MPX1a+KPNH7CkvKvjqexUEtr2RzzYcTIFDxmDKhWdAmeuhM
         skVGPA2pwUJW8ITrXYHOJg8y0DvDGpVkh8CCPCiYr9xhG28ive/lxaE3GVg4EyToiM5v
         P6QUmlLeqpAmFDzF3TDu03hwyqmQhhuwOYGb2E87u9k80vJwyNFkQGrNTghMAV06j5ff
         rUzZFXXtJkWNcvVzlMth5MGUm+wc4k0qYh78vTEBZtU1ppoOvIrD2+8H+cm5oFJkbVGc
         NqzoK6vJdhVdmMCG+3GDVoYxpg5RxOVcjtNoL/Pq7a1hJMV0c9gdU3kOgd1uM9s2wUPg
         Sgnw==
X-Received: by 10.68.240.99 with SMTP id vz3mr17643592pbc.93.1396393283843;
        Tue, 01 Apr 2014 16:01:23 -0700 (PDT)
Received: from [10.0.1.106] ([63.249.67.138])
        by mx.google.com with ESMTPSA id pv4sm88253pbb.55.2014.04.01.16.01.22
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Apr 2014 16:01:23 -0700 (PDT)
In-Reply-To: <xmqq4n2czq6n.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245668>

On Apr 1, 2014, at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> D           M    deleted from index
> 
> I doubt this is possible in practice ...
> 
>> D           D    unmerged, both deleted
>> A           U    unmerged, added by us
>> U           A    unmerged, added by them
> 
>   ... you would not see these three unless you are developing Git using a
> low-level plumbing machinery.

Thanks, that is very helpful.

The "C[ MD]" are now the remaining mystery
